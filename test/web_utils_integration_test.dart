@TestOn('browser')
library;

import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:web_utils/web_utils.dart';

/// Integration tests: `web_utils` driving real browser APIs (DOM, events,
/// IndexedDB, Storage, Canvas, Blob/FileReader), including the
/// `js_interop_utils` 1.1.0 features re-exported by this package.

class _Foo {}

var _dbCounter = 0;

String _uniqueDBName() =>
    'web_utils_test_${DateTime.now().microsecondsSinceEpoch}_${_dbCounter++}';

Future<void> _deleteDatabase(String name) {
  final completer = Completer<void>();
  final request = window.indexedDB.deleteDatabase(name);
  request.onsuccess = ((Event _) => completer.complete()).toJS;
  request.onerror = ((Event _) => completer.complete()).toJS;
  request.onblocked = ((Event _) => completer.complete()).toJS;
  return completer.future;
}

HTMLDivElement _attachedRoot() {
  final root = HTMLDivElement()..id = 'root-${_dbCounter++}';
  document.body!.appendChild(root);
  addTearDown(() => root.remove());
  return root;
}

void main() {
  group('IndexedDB', () {
    late String dbName;
    late IDBDatabase db;

    setUp(() async {
      dbName = _uniqueDBName();
      db = (await window.indexedDB.openDatabase(
        dbName,
        version: 1,
        onUpgradeNeeded: (event) {
          final request = event.target as IDBOpenDBRequest;
          final db = request.result as IDBDatabase;
          db.createObjectStore(
            'items',
            IDBObjectStoreParameters(keyPath: 'id'.toJS),
          );
        },
      ))!;
    });

    tearDown(() async {
      db.close();
      await _deleteDatabase(dbName);
    });

    IDBObjectStore store(String mode) =>
        db.transaction('items'.toJS, mode).objectStore('items');

    Future<void> putAll(List<Map<String, Object?>> items) async {
      for (final item in items) {
        await store('readwrite')
            .put(item.toJSDeep)
            .process<JSAny, void>((_) => (next: false, result: null));
      }
    }

    test('openDatabase: upgrade creates the store', () {
      expect(db.name, equals(dbName));
      expect(db.version, equals(1));
      expect(db.objectStoreNames.contains('items'), isTrue);
    });

    test('openDatabase: version requires onUpgradeNeeded', () {
      expect(
        window.indexedDB.openDatabase(_uniqueDBName(), version: 1),
        throwsArgumentError,
      );
    });

    test(
      'openDatabase: a lower version fails with the request error',
      () async {
        // `db` is at version 1; open a second database at version 2, then ask
        // for version 1 again:
        final name = _uniqueDBName();
        addTearDown(() => _deleteDatabase(name));

        final db2 = await window.indexedDB.openDatabase(
          name,
          version: 2,
          onUpgradeNeeded: (_) {},
          onBlocked: (_) {},
        );
        db2!.close();

        await expectLater(
          window.indexedDB.openDatabase(
            name,
            version: 1,
            onUpgradeNeeded: (_) {},
          ),
          throwsA(isA<String>()),
        );
      },
    );

    test('openDatabase: invalid version fails', () async {
      await expectLater(
        window.indexedDB.openDatabase(
          _uniqueDBName(),
          version: 0,
          onUpgradeNeeded: (_) {},
        ),
        throwsA(anything),
      );
    });

    test('openDatabase without version opens an existing database', () async {
      final db2 = await window.indexedDB.openDatabase(dbName);
      expect(db2, isNotNull);
      expect(db2!.objectStoreNames.contains('items'), isTrue);
      db2.close();
    });

    test('process: put / get / count', () async {
      await putAll([
        {'id': 1, 'name': 'a'},
        {'id': 2, 'name': 'b'},
      ]);

      final item = await store('readonly')
          .get(2.toJS)
          .process<JSObject, Map<String, dynamic>>(
            (o) => (next: false, result: o?.toMap()),
          );
      expect(item, equals({'id': 2, 'name': 'b'}));

      final count = await store('readonly')
          .count()
          .process<JSNumber, int>((n) => (next: false, result: n?.toDartInt));
      expect(count, equals(2));
    });

    test('process: iterates a cursor until exhausted', () async {
      await putAll([
        for (var i = 1; i <= 5; i++) {'id': i, 'name': 'n$i'},
      ]);

      final names = <String>[];
      final result = await store('readonly')
          .openCursor()
          .process<IDBCursorWithValue, List<String>>((cursor) {
            if (cursor == null) return (next: false, result: names);
            names.add((cursor.value as JSObject).get('name') as String);
            return (next: true, result: null);
          });

      expect(result, equals(['n1', 'n2', 'n3', 'n4', 'n5']));
    });

    test('process: stops early when next is false', () async {
      await putAll([
        for (var i = 1; i <= 5; i++) {'id': i},
      ]);

      var visited = 0;
      final result = await store('readonly')
          .openCursor()
          .process<IDBCursorWithValue, int>((cursor) {
            visited++;
            final id = ((cursor!.value as JSObject).get('id') as num).toInt();
            return id == 3
                ? (next: false, result: id)
                : (next: true, result: null);
          });

      expect(result, equals(3));
      expect(visited, equals(3));
    });

    test('process: request errors complete with an error', () async {
      await putAll([
        {'id': 1},
      ]);

      final future = store('readwrite')
          .add({'id': 1}.toJSDeep)
          .process<JSAny, void>((_) => (next: false, result: null));

      await expectLater(future, throwsA(anything));
    });
  });

  group('Storage', () {
    late Storage storage;

    setUp(() {
      storage = window.localStorage;
      storage.clear();
    });

    tearDown(() => storage.clear());

    test('keys / remove / isEmpty', () {
      expect(storage.isEmpty, isTrue);
      expect(storage.isNotEmpty, isFalse);

      storage
        ..setItem('a', '1')
        ..setItem('b', '2');

      expect(storage.isNotEmpty, isTrue);
      expect(storage.keys.toSet(), equals({'a', 'b'}));
      expect(storage.remove('a'), isTrue);
      expect(storage.remove('a'), isFalse);
      expect(storage.keys, equals(['b']));
    });
  });

  group('DOM building', () {
    test('appendHTML + typed selection + attributes', () {
      final root = _attachedRoot();
      final nodes = root.appendHTML('''
<form id="f">
  <label for="name">Name</label>
  <input id="name" name="name" value="x">
  <select id="sel"><option>a</option><option selected>b</option></select>
  <button id="btn" type="button">Go</button>
</form>
''');

      expect(nodes.whereElement().length, equals(1));

      final form = document.selectTyped('#f', Web.HTMLFormElement)!;
      expect(
        form.selectAllTyped('input', Web.HTMLInputElement).single.value,
        equals('x'),
      );
      expect(form.selectTyped('#btn', Web.HTMLButtonElement), isNotNull);
      expect(form.selectTyped('#btn', Web.HTMLInputElement), isNull);

      final select = form.selectTyped('#sel', Web.HTMLSelectElement)!;
      expect(select.options.toList().map((o) => o.text), equals(['a', 'b']));
      expect(select.selectedOptionsSafe.single.text, equals('b'));

      form.setAttributesFromKeyValueLists(
        ['data-a', 'data-b', 'id'],
        ['1', null, 'f'],
      );
      form.setAttribute('data-b', 'will be removed');
      form.setAttributesFromKeyValueLists(['data-b'], [null]);
      expect(form.attributes.toMap(), equals({'id': 'f', 'data-a': '1'}));
    });

    test('tables', () {
      final root = _attachedRoot();
      final table = HTMLTableElement();
      root.appendChild(table);

      for (var r = 0; r < 3; r++) {
        final row = table.appendRow();
        for (var c = 0; c < 2; c++) {
          row.appendCell().text = '$r,$c';
        }
      }

      final body = table.createTBody();
      body.appendRow().appendCell().text = 'body';

      expect(table.rows.length, equals(4));
      expect(table.rows.toList().last.textContent, equals('body'));
      expect(
        table.selectAllTyped('td', Web.HTMLTableCellElement).map((e) => e.text),
        equals(['0,0', '0,1', '1,0', '1,1', '2,0', '2,1', 'body']),
      );
    });
  });

  group('events', () {
    test('addEventListenerTyped / RegisteredEventListener', () {
      final root = _attachedRoot();
      final button = HTMLButtonElement();
      root.appendChild(button);

      final clicks = <MouseEvent>[];
      final reg = EventType.click.addEventListener(button, clicks.add);

      button.click();
      expect(clicks.length, equals(1));
      expect(clicks.single.type, equals('click'));

      reg.unregister();
      button.click();
      expect(clicks.length, equals(1));
    });

    test('bubbling with dispatchEventOfType', () {
      final root = _attachedRoot();
      final child = HTMLSpanElement();
      root.appendChild(child);

      var parentCount = 0;
      final reg = root.addEventListenerTyped(
        EventType.input,
        (Event _) => parentCount++,
      );
      addTearDown(reg.unregister);

      child.dispatchEventOfType('input');
      expect(parentCount, equals(0));

      child.dispatchEventOfType('input', bubbles: true);
      expect(parentCount, equals(1));
    });

    test('cancelable events', () {
      final div = HTMLDivElement();
      final reg = div.addEventListenerTyped(
        EventType.submit,
        (Event e) => e.preventDefault(),
      );
      addTearDown(reg.unregister);

      expect(div.dispatchEventOfType('submit', cancelable: true), isFalse);
      expect(div.dispatchEventOfType('submit'), isTrue);
    });

    test('HTMLSelectElement.selectIndex fires change', () {
      final select = HTMLSelectElement()
        ..appendChild(HTMLOptionElement()..text = 'a')
        ..appendChild(HTMLOptionElement()..text = 'b');

      final changes = <int>[];
      final reg = select.addEventListenerTyped(
        EventType.change,
        (Event _) => changes.add(select.selectedIndex),
      );
      addTearDown(reg.unregister);

      select.selectIndex(1);
      expect(changes, equals([1]));
      expect(select.selectedOptionsSafe.single.text, equals('b'));
    });

    test('keyboard events', () {
      final input = HTMLInputElement();
      final keys = <String>[];
      final reg = input.addEventListenerTyped(EventType.keyDown, (
        KeyboardEvent e,
      ) {
        if (e.isKeyEnter) keys.add('enter');
        if (e.isArrowKey) keys.add('arrow');
        if (e.isKeyEscape) keys.add('esc');
      });
      addTearDown(reg.unregister);

      for (final key in ['Enter', 'ArrowLeft', 'Escape', 'a']) {
        input.dispatchEvent(
          KeyboardEvent('keydown', KeyboardEventInit(key: key)),
        );
      }
      expect(keys, equals(['enter', 'arrow', 'esc']));
    });

    test('Window event streams receive dispatched events', () async {
      final resize = window.onResize.first;
      final hash = window.onHashChange.first;
      final click = window.onClick.first;

      window.dispatchEvent(Event('resize'));
      window.dispatchEvent(Event('hashchange'));
      window.dispatchEvent(MouseEvent('click', MouseEventInit(clientX: 7)));

      expect((await resize).type, equals('resize'));
      expect((await hash).type, equals('hashchange'));
      expect((await click).clientPoint, equals(const Point(7, 0)));
    });
  });

  group('Canvas / Blob / FileReader', () {
    test('draw, read pixels, export', () async {
      final canvas = HTMLCanvasElement()
        ..width = 2
        ..height = 2;
      final ctx = canvas.getContext('2d') as CanvasRenderingContext2D;

      ctx.setFillColorRgb(255, 0, 0);
      ctx.fillRect(0, 0, 2, 2);

      final pixel = ctx.getImageData(0, 0, 1, 1).data.toDart;
      expect(pixel, equals([255, 0, 0, 255]));

      ctx.setStrokeColorRgb(0, 0, 255, 0.5);
      expect((ctx.strokeStyle as JSString).toDart, contains('0, 0, 255'));

      expect(canvas.toDataUrlPNG(), startsWith('data:image/png'));
      expect(canvas.toDataUrlJPEG(), startsWith('data:image/jpeg'));
      expect(canvas.toDataUrlWEBP(), startsWith('data:image/'));

      expect((await canvas.asBlob()).type, equals('image/png'));
      expect(
        (await canvas.asBlob(type: 'image/jpeg', quality: 0.8)).type,
        equals('image/jpeg'),
      );
      expect(
        (await canvas.asBlob(type: 'image/png')).type,
        equals('image/png'),
      );
      expect((await canvas.asBlob(quality: 0.5)).type, equals('image/png'));

      final metrics = ctx.measureText('Hg');
      expect(metrics.tryActualBoundingBoxAscent, isNotNull);
      expect(metrics.tryActualBoundingBoxDescent, isNotNull);
      expect(metrics.tryFontBoundingBoxAscent, isNotNull);
      expect(metrics.tryFontBoundingBoxDescent, isNotNull);
    });

    test('ImageData from a Uint8ClampedList (js_interop_utils 1.1.0)', () {
      // Before js_interop_utils 1.1.0, `Uint8ClampedList.toJS` resolved to the
      // package `Iterable<int>.toJS` and produced a JS `Array`, which
      // `ImageData` rejects.
      final pixels = Uint8ClampedList.fromList([10, 20, 30, 255]);
      final imageData = ImageData(pixels.toJS, 1);

      final canvas = HTMLCanvasElement()
        ..width = 1
        ..height = 1;
      final ctx = canvas.getContext('2d') as CanvasRenderingContext2D;
      ctx.putImageData(imageData, 0, 0);

      expect(
        ctx.getImageData(0, 0, 1, 1).data.toDart,
        equals([10, 20, 30, 255]),
      );
    });

    test('FileReader.onLoad reads a Blob', () async {
      final blob = Blob(<JSAny>['hello'.toJS].toJS);
      final reader = FileReader();

      final loadStart = reader.onLoadStart.first;
      final load = reader.onLoad.first;
      reader.readAsText(blob);

      await loadStart;
      await load;
      expect((reader.result as JSString).toDart, equals('hello'));
    });

    test('FileReader.onLoad reads binary data as a typed array', () async {
      final bytes = Uint8List.fromList([1, 2, 3]);
      final blob = Blob(<JSAny>[bytes.toJS].toJS);
      final reader = FileReader();
      final load = reader.onLoad.first;
      reader.readAsArrayBuffer(blob);
      await load;

      expect(
        (reader.result as JSArrayBuffer).toDart.asUint8List(),
        equals([1, 2, 3]),
      );
    });

    test('FileList via DataTransfer', () {
      final transfer = DataTransfer();
      transfer.items.add(File(<JSAny>['a'.toJS].toJS, 'a.txt'));
      transfer.items.add(File(<JSAny>['bb'.toJS].toJS, 'b.txt'));

      final files = transfer.files;
      expect(files.isNotEmpty, isTrue);
      expect(files.toList().map((f) => f.name), equals(['a.txt', 'b.txt']));
      expect(files.toIterable().map((f) => f.size), equals([1, 2]));
      expect(files.asListView.length, equals(2));
      expect(files.asListViewFixed.last.name, equals('b.txt'));
    });
  });

  group('js_interop_utils 1.1.0 features on DOM values', () {
    test('type checks through asJSAny / asJSObject', () {
      final div = HTMLDivElement();
      expect(div.isHTMLElement, isTrue);
      expect((div as Object?).isNode, isTrue);

      // A plain Dart object is never a DOM node (with dart2js it was
      // previously reported as a `JSAny`):
      expect(_Foo().isNode, isFalse);
      expect(_Foo().isElement, isFalse);
      expect(Web.HTMLElement.isOf(_Foo()), isFalse);
      expect(Web.HTMLElement.castNullable(_Foo()), isNull);
      expect(() => Web.HTMLElement.cast(_Foo()), throwsArgumentError);
    });

    test('DOM objects are not plain objects', () {
      final div = HTMLDivElement();
      expect(div.isPlainObject, isFalse);
      expect(div.prototype, isNotNull);
      expect({'a': 1}.toJSDeep.isPlainObject, isTrue);
    });

    test('NodeList is a JS iterable', () {
      final root = _attachedRoot();
      root.appendHTML('<p>1</p><p>2</p><p>3</p>');

      final JSAny nodeList = root.querySelectorAll('p');
      final iterable = nodeList as JSIterable<Node>;
      expect(
        iterable.toDartIterable.map((n) => n.textContent),
        equals(['1', '2', '3']),
      );
    });

    test('event listener callbacks are exported Dart functions', () {
      final reg = HTMLDivElement().addEventListenerTyped(
        EventType.click,
        (MouseEvent _) {},
      );
      expect(reg.jsCallback.isJSFunction, isTrue);
      expect(reg.jsCallback.isJSExportedDartFunction, isTrue);
      reg.unregister();
    });

    test('typed arrays through Blob', () async {
      final floats = Float64List.fromList([0.5, 1.5]);
      final blob = Blob(<JSAny>[floats.toJS].toJS);
      // A JS `Array` would be stringified by `Blob` ("0.5,1.5"):
      expect(blob.size, equals(16));
    });
  });
}
