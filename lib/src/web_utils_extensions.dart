import 'dart:async';
import 'dart:math';

import 'package:js_interop_utils/js_interop_utils.dart';
import 'package:web/web.dart' as web;
import 'package:web/web.dart';

extension WebObjectExtension on Object? {
  bool get isNode => asJSAny.isNode;

  bool get isElement => asJSAny.isElement;

  bool get isHTMLElement => asJSAny.isHTMLElement;
}

extension WebJSAnyExtension on JSAny? {
  bool get isNode => isA<Node>();

  bool get isElement => isA<Element>();

  bool get isHTMLElement => isA<HTMLElement>();
}

extension JSObjectWebExtension on JSObject? {
  bool get isNode => isA<Node>();

  bool get isElement => isA<Element>();

  bool get isHTMLElement => isA<HTMLElement>();
}

extension WebIterableExtension<T> on Iterable<T> {
  Iterable<Element> whereElement() {
    return whereJSAny().where((e) => e.isA<Element>()).cast<Element>();
  }

  Iterable<E> whereElementType<E extends Element>(Web<E> webType) {
    return whereElement().where(webType.isOf).cast<E>();
  }
}

extension WebIterableJSAnyExtension<T extends JSAny?> on Iterable<T> {
  Iterable<Element> whereElement() {
    return where((e) => e != null && e.isA<Element>()).cast<Element>();
  }

  Iterable<E> whereElementType<E extends Element>(Web<E> webType) {
    return whereElement().whereElementType<E>(webType);
  }
}

extension IterableElementExtension<T extends Element?> on Iterable<T> {
  Iterable<Element> whereElement() {
    return where((e) => e != null && e.isA<Element>()).cast<Element>();
  }

  Iterable<E> whereElementType<E extends Element>(Web<E> webType) {
    return whereElement().where(webType.isOf).cast<E>();
  }
}

extension IterableNodeExtension on Iterable<Node> {
  Iterable<Element> whereElement() =>
      where((e) => e.isA<Element>()).cast<Element>();

  Iterable<E> whereElementType<E extends Element>(Web<E> webType) {
    return whereElement().whereElementType<E>(webType);
  }

  List<Element> toElements() => whereElement().toList();

  Iterable<HTMLElement> whereHTMLElement() =>
      where((e) => e.isA<HTMLElement>()).cast<HTMLElement>();

  List<HTMLElement> toHTMLElements() => whereHTMLElement().toList();
}

extension DocumentExtension on Document {
  T? select<T extends Element>(String selectors, [Web<T>? webType]) {
    var o = document.querySelector(selectors);

    if (webType != null) {
      return o?.asElementOf<T>(webType);
    } else {
      return o as T?;
    }
  }

  List<T> selectAll<T extends Element>(String selectors, [Web<T>? webType]) {
    var l = document.querySelectorAll(selectors).whereElement();

    if (webType != null) {
      return l.map((e) => e.asElementOf<T>(webType)).nonNulls.toList();
    } else {
      return l.nonNulls.cast<T>().toList();
    }
  }
}

extension NodeNullableExtension on Node? {
  Element? get asElementChecked => isA<Element>() ? this as Element : null;

  HTMLElement? get asHTMLElementChecked =>
      isA<HTMLElement>() ? this as HTMLElement : null;
}

extension NodeExtension on Node {
  Element get asElement => this as Element;

  HTMLElement get asHTMLElement => this as HTMLElement;

  Node insertNode(int index, Node node) {
    final childNodes = this.childNodes;
    if (index >= childNodes.length) {
      return appendChild(node);
    } else if (index == 0) {
      var child0 = firstChild;
      if (child0 == null) {
        return appendChild(node);
      } else {
        return insertBefore(node, child0);
      }
    } else {
      var child = childNodes.item(index)!;
      return insertBefore(node, child);
    }
  }

  Node? removeNodeAt(int index) {
    final childNodes = this.childNodes;
    if (index < 0 || index >= childNodes.length) return null;

    var node = childNodes.item(index);
    if (node == null) return null;

    return removeChild(node);
  }

  void appendNodes(Iterable<Node> nodes) {
    for (var node in nodes) {
      appendChild(node);
    }
  }

  void remove() {
    parentNode?.removeChild(this);
  }

  void removeNodes(Iterable<Node> nodes) {
    for (var node in nodes.toList(growable: false)) {
      removeChild(node);
    }
  }

  void removeNodeWhere(bool Function(Node node) test) {
    final childNodes = this.childNodes;

    for (var i = 0; i < childNodes.length;) {
      var node = childNodes.item(i)!;
      if (test(node)) {
        final prevLength = childNodes.length;
        if (node.isA<Element>()) {
          (node as Element).remove();
        } else {
          removeChild(node);
        }
        assert(childNodes.length == prevLength - 1);
      } else {
        ++i;
      }
    }
  }

  void clear() {
    if (isA<Element>()) {
      asElement.innerHTML = ''.toJS;
    } else {
      clearNodes();
    }
  }

  List<Node> clearNodes() {
    var nodes = childNodes.toList();
    for (var n in nodes.reversed) {
      n.removeChild(n);
    }
    return nodes;
  }
}

enum Web<T> {
  // ignore: constant_identifier_names
  Element<web.Element>(_isElement, _castElement),
  // ignore: constant_identifier_names
  HTMLElement(_isHTMLElement, _castHTMLElement),
  // ignore: constant_identifier_names
  HTMLDivElement(_isHTMLDivElement, _castHTMLDivElement),
  // ignore: constant_identifier_names
  HTMLButtonElement(_isHTMLButtonElement, _castHTMLButtonElement),
  // ignore: constant_identifier_names
  HTMLTextAreaElement(_isHTMLTextAreaElement, _castHTMLTextAreaElement),
  // ignore: constant_identifier_names
  HTMLInputElement(_isHTMLInputElement, _castHTMLInputElement),
  // ignore: constant_identifier_names
  HTMLSelectElement(_isHTMLSelectElement, _castHTMLSelectElement),
  // ignore: constant_identifier_names
  HTMLAnchorElement(_isHTMLAnchorElement, _castHTMLAnchorElement),
  // ignore: constant_identifier_names
  HTMLImageElement(_isHTMLImageElement, _castHTMLImageElement),
  // ignore: constant_identifier_names
  HTMLSpanElement(_isHTMLSpanElement, _castHTMLSpanElement),
  // ignore: constant_identifier_names
  HTMLTableElement(_isHTMLTableElement, _castHTMLTableElement),
  // ignore: constant_identifier_names
  HTMLTableRowElement(_isHTMLTableRowElement, _castHTMLTableRowElement),
  // ignore: constant_identifier_names
  HTMLTableCellElement(_isHTMLTableCellElement, _castHTMLTableCellElement);

  /////////////////

  static bool _isElement(JSAny? o) => o.isA<web.Element>();

  static web.Element? _castElement(JSAny? o) =>
      o.isA<web.Element>() ? o as web.Element : null;

  static bool _isHTMLElement(JSAny? o) => o.isA<web.HTMLElement>();

  static web.HTMLElement? _castHTMLElement(JSAny? o) =>
      o.isA<web.HTMLElement>() ? o as web.HTMLElement : null;

  static bool _isHTMLDivElement(JSAny? o) => o.isA<web.HTMLDivElement>();

  static web.HTMLDivElement? _castHTMLDivElement(JSAny? o) =>
      o.isA<web.HTMLDivElement>() ? o as web.HTMLDivElement : null;

  static bool _isHTMLButtonElement(JSAny? o) => o.isA<web.HTMLButtonElement>();

  static web.HTMLButtonElement? _castHTMLButtonElement(JSAny? o) =>
      o.isA<web.HTMLButtonElement>() ? o as web.HTMLButtonElement : null;

  static bool _isHTMLTextAreaElement(JSAny? o) =>
      o.isA<web.HTMLTextAreaElement>();

  static web.HTMLTextAreaElement? _castHTMLTextAreaElement(JSAny? o) =>
      o.isA<web.HTMLTextAreaElement>() ? o as web.HTMLTextAreaElement : null;

  static bool _isHTMLInputElement(JSAny? o) => o.isA<web.HTMLInputElement>();

  static web.HTMLInputElement? _castHTMLInputElement(JSAny? o) =>
      o.isA<web.HTMLInputElement>() ? o as web.HTMLInputElement : null;

  static bool _isHTMLSelectElement(JSAny? o) => o.isA<web.HTMLSelectElement>();

  static web.HTMLSelectElement? _castHTMLSelectElement(JSAny? o) =>
      o.isA<web.HTMLSelectElement>() ? o as web.HTMLSelectElement : null;

  static bool _isHTMLAnchorElement(JSAny? o) => o.isA<web.HTMLAnchorElement>();

  static web.HTMLAnchorElement? _castHTMLAnchorElement(JSAny? o) =>
      o.isA<web.HTMLAnchorElement>() ? o as web.HTMLAnchorElement : null;

  static bool _isHTMLImageElement(JSAny? o) => o.isA<web.HTMLImageElement>();

  static web.HTMLImageElement? _castHTMLImageElement(JSAny? o) =>
      o.isA<web.HTMLImageElement>() ? o as web.HTMLImageElement : null;

  static bool _isHTMLSpanElement(JSAny? o) => o.isA<web.HTMLSpanElement>();

  static web.HTMLSpanElement? _castHTMLSpanElement(JSAny? o) =>
      o.isA<web.HTMLSpanElement>() ? o as web.HTMLSpanElement : null;

  static bool _isHTMLTableElement(JSAny? o) => o.isA<web.HTMLTableElement>();

  static web.HTMLTableElement? _castHTMLTableElement(JSAny? o) =>
      o.isA<web.HTMLTableElement>() ? o as web.HTMLTableElement : null;

  static bool _isHTMLTableRowElement(JSAny? o) =>
      o.isA<web.HTMLTableRowElement>();

  static web.HTMLTableRowElement? _castHTMLTableRowElement(JSAny? o) =>
      o.isA<web.HTMLTableRowElement>() ? o as web.HTMLTableRowElement : null;

  static bool _isHTMLTableCellElement(JSAny? o) =>
      o.isA<web.HTMLTableCellElement>();

  static web.HTMLTableCellElement? _castHTMLTableCellElement(JSAny? o) =>
      o.isA<web.HTMLTableCellElement>() ? o as web.HTMLTableCellElement : null;

  ///////////////////////

  final bool Function(JSAny? o) _isA;

  final T? Function(JSAny? o) _cast;

  const Web(this._isA, this._cast);

  bool isOf(Object? o) {
    var jsObj = o.asJSObject;
    if (jsObj == null) return false;
    return _isA(jsObj);
  }

  T? castNullable(Object? o) {
    var jsObj = o.asJSObject;
    if (jsObj == null) return null;
    return _cast(jsObj);
  }

  T cast(Object? o) {
    var jsObj = o.asJSObject;
    if (jsObj == null) throw ArgumentError("Can't cast `null` to type `$name`");
    return _cast(jsObj) ??
        (throw ArgumentError("Can't cast `$o` to type `$name`"));
  }

  @override
  String toString() => '`web` type `$name`';
}

extension ElementNullableExtension on Element? {
  HTMLElement? get asHTMLElement =>
      isA<HTMLElement>() ? this as HTMLElement : null;

  bool isElementOf<T extends Element>(Web<T> webType) => webType.isOf(this);

  T? asElementOf<T extends Element>(Web<T> webType) => webType.cast(this);

  bool get isCanvasImageSource {
    final node = this;
    if (node == null) return false;
    return node.isA<HTMLImageElement>() ||
        node.isA<HTMLCanvasElement>() ||
        node.isA<HTMLVideoElement>();
  }
}

extension ElementExtension on Element {
  String? get text => textContent?.toDartFix;

  set text(String? text) => textContent = text;

  HTMLElement get asHTMLElement => this as HTMLElement;

  HTMLElement? get asHTMLElementChecked =>
      isA<HTMLElement>() ? this as HTMLElement : null;

  /// Alias to [document.querySelector] casting to [T].
  T? querySelectorTyped<T extends Element>(String selectors, Web<T> webType) {
    var self = this;
    var elem = self.querySelector(selectors);
    return elem.isElementOf<T>(webType) ? elem as T? : null;
  }

  /// Alias to [querySelectorAll] casting elements to [T].
  List<T> querySelectorAllTyped<T extends Element>(
      String selectors, Web<T> webType) {
    var self = this;
    var list = self.querySelectorAll(selectors);
    return list.whereElementType<T>(webType).toList();
  }

  Element insertChild(int index, Element node) {
    final children = this.children;
    if (index >= children.length) {
      return appendChild(node) as Element;
    } else if (index == 0) {
      var child0 = firstChild;
      if (child0 == null) {
        return appendChild(node) as Element;
      } else {
        return insertBefore(node, child0) as Element;
      }
    } else {
      var child = children.item(index)!;
      return insertBefore(node, child) as Element;
    }
  }

  Element? removeChildAt(int index) {
    final children = this.children;
    if (index < 0 || index >= children.length) return null;

    var element = children.item(index);
    if (element == null) return null;

    return removeChild(element) as Element;
  }

  void appendAll(Iterable<JSAny> nodes) {
    for (var node in nodes) {
      append(node);
    }
  }

  void clear() {
    innerHTML = ''.toJS;
  }

  CSSStyleDeclaration getComputedStyle() => window.getComputedStyle(this);

  void click() => asHTMLElementChecked?.click();

  bool focus() {
    final htmlElement = asHTMLElementChecked;
    if (htmlElement != null) {
      htmlElement.focus();
      return true;
    }
    return false;
  }

  CSSStyleDeclaration? get style => asHTMLElementChecked?.style;

  bool get hidden => asHTMLElementChecked?.hidden?.dartify() == true;

  set hidden(bool? value) => asHTMLElementChecked?.hidden = value?.toJS;

  DOMTokenList? get classList => asHTMLElementChecked?.classList;

  bool dispatchEventOfType(
    String type, {
    bool? bubbles,
    bool? cancelable,
    bool? composed,
  }) {
    var eventInit = bubbles != null || cancelable != null || composed != null
        ? EventInit(
            bubbles: bubbles ?? false,
            cancelable: cancelable ?? false,
            composed: composed ?? false,
          )
        : null;

    var event = eventInit != null ? Event(type, eventInit) : Event(type);
    return dispatchEvent(event);
  }

  bool dispatchChangeEvent() => dispatchEventOfType('change');

  void setAttributes(Map<String, String> attrs) {
    for (var e in attrs.entries) {
      setAttribute(e.key, e.value);
    }
  }
}

extension HTMLElementExtension on HTMLElement {
  static final DOMParser _domParser = DOMParser();

  List<Node> appendHTML(String html) {
    var doc = _domParser.parseFromString(html.toJS, 'text/html');
    var root = doc.body ?? doc.documentElement;
    var nodes = root?.childNodes.toList() ?? [];
    appendNodes(nodes);
    return nodes;
  }

  bool get isHidden {
    var v = hidden;
    if (v == null) return false;

    if (v.isUndefinedOrNull) {
      return false;
    } else if (v.isA<JSBoolean>()) {
      return (v as JSBoolean).toDart;
    } else if (v.isA<JSString>()) {
      var s = (v as JSString).toDart.toLowerCase().trim();
      return s == '' || s == 'hidden';
    }

    return false;
  }
}

extension HTMLSelectElementExtension on HTMLSelectElement {
  /// Selects an [index] and triggers the `change` event.
  /// See [dispatchChangeEvent] and [selectedIndex].
  bool selectIndex(int index) {
    selectedIndex = index;
    return dispatchChangeEvent();
  }

  List<HTMLOptionElement> get selectedOptionsSafe {
    try {
      return selectedOptions
          .toList()
          .where((e) => e.isA<HTMLOptionElement>())
          .cast<HTMLOptionElement>()
          .toList();
    } catch (_) {
      return [];
    }
  }
}

extension HTMLOptionsCollectionExtension on HTMLOptionsCollection {
  Iterable<HTMLOptionElement> toIterable() =>
      Iterable.generate(length, (i) => item(i) as HTMLOptionElement);

  List<HTMLOptionElement> toList() =>
      List.generate(length, (i) => item(i) as HTMLOptionElement);

  bool get isEmpty => length == 0;

  bool get isNotEmpty => !isEmpty;
}

extension TouchListExtension on TouchList {
  Iterable<Touch> toIterable() => Iterable.generate(length, (i) => item(i)!);

  List<Touch> toList() => List.generate(length, (i) => item(i)!);

  bool get isEmpty => length == 0;

  bool get isNotEmpty => !isEmpty;
}

extension FileListExtension on FileList {
  Iterable<File> toIterable() => Iterable.generate(length, (i) => item(i)!);

  List<File> toList() => List.generate(length, (i) => item(i)!);

  bool get isEmpty => length == 0;

  bool get isNotEmpty => !isEmpty;
}

extension CSSStyleDeclarationExtension on CSSStyleDeclaration {
  bool get isEmpty => cssText.trim().isEmpty;

  bool get isNotEmpty => !isEmpty;
}

extension CSSRuleListExtension on CSSRuleList {
  Iterable<CSSRule> toIterable() => Iterable.generate(length, (i) => item(i)!);

  List<CSSRule> toList() => List.generate(length, (i) => item(i)!);

  bool get isEmpty => length == 0;

  bool get isNotEmpty => !isEmpty;
}

extension CanvasRenderingContext2DExtension on CanvasRenderingContext2D {
  void setFillColorRgb(int r, int g, int b, [num a = 1]) {
    fillStyle = 'rgba($r, $g, $b, $a)'.toJS;
  }

  void setStrokeColorRgb(int r, int g, int b, [num a = 1]) {
    strokeStyle = 'rgba($r, $g, $b, $a)'.toJS;
  }
}

extension DOMTokenListExtension on DOMTokenList {
  Iterable<String> toIterable() =>
      Iterable.generate(length, (i) => item(i)!.toDartFix);

  List<String> toList() => List.generate(length, (i) => item(i)!.toDartFix);

  bool get isEmpty => length == 0;

  bool get isNotEmpty => !isEmpty;

  bool addAndDetectChange(String clazz) {
    var prevLng = length;
    add(clazz);
    return prevLng != length;
  }

  bool removeAndDetectChange(String clazz) {
    var prevLng = length;
    remove(clazz);
    return prevLng != length;
  }

  void addAll(Iterable<String> classes) {
    for (var c in classes) {
      add(c);
    }
  }

  void removeAll(Iterable<String> classes) {
    for (var c in classes) {
      remove(c);
    }
  }

  void clear() {
    value = '';
  }
}

extension NamedNodeMapExtension on NamedNodeMap {
  Iterable<Attr> toIterable() => Iterable.generate(length, (i) => item(i)!);

  List<Attr> toList() => List.generate(length, (i) => item(i)!);

  Iterable<T> whereType<T>() => toIterable().whereType<T>();

  bool get isEmpty => length == 0;

  bool get isNotEmpty => !isEmpty;

  Map<String, String> toMap() => Map.fromEntries(toIterable().map(
        (a) => MapEntry(
          a.name.toDartFix,
          a.value.toDartFix,
        ),
      ));
}

extension HTMLCollectionExtension on HTMLCollection {
  Iterable<Element> toIterable() => Iterable.generate(length, (i) => item(i)!);

  List<Element> toList() => List.generate(length, (i) => item(i)!);

  Iterable<T> whereType<T>() => toIterable().whereType<T>();

  bool get isEmpty => length == 0;

  bool get isNotEmpty => !isEmpty;

  int indexOf(Element element) {
    var i = 0;
    for (var e in toIterable()) {
      if (e == element) {
        return i;
      }
      i++;
    }
    return -1;
  }
}

extension NodeListExtension on NodeList {
  Iterable<Node> toIterable() => Iterable.generate(length, (i) => item(i)!);

  List<Node> toList() => List.generate(length, (i) => item(i)!);

  Iterable<Node> where(bool Function(Node element) test) =>
      toIterable().where(test);

  Iterable<E> whereElementType<E extends Element>(Web<E> webType) {
    return whereElement().where((e) => e.isElementOf<E>(webType)).cast<E>();
  }

  Iterable<Element> whereElement() =>
      where((e) => e.isA<Element>()).cast<Element>();

  List<Element> toElements() => whereElement().toList();

  Iterable<HTMLElement> whereHTMLElement() =>
      where((e) => e.isA<HTMLElement>()).cast<HTMLElement>();

  List<HTMLElement> toHTMLElements() => whereHTMLElement().toList();

  bool get isEmpty => length == 0;

  bool get isNotEmpty => !isEmpty;

  int indexOf(Node node) {
    var i = 0;
    for (var e in toIterable()) {
      if (e == node) {
        return i;
      }
      i++;
    }
    return -1;
  }
}

extension HTMLTableElementExtension on HTMLTableElement {
  HTMLTableRowElement appendRow() => insertRow(-1);
}

extension HTMLTableSectionElementExtension on HTMLTableSectionElement {
  HTMLTableRowElement appendRow() => insertRow(-1);
}

extension HTMLTableRowElementExtension on HTMLTableRowElement {
  HTMLTableCellElement appendCell() => insertCell(-1);
}

extension StorageExtension on Storage {
  bool get isEmpty => length == 0;

  bool get isNotEmpty => !isEmpty;

  Iterable<String> get keys =>
      Iterable.generate(length, (i) => key(i)?.toDartFix).nonNulls;

  bool remove(String key) {
    var prevLng = length;
    removeItem(key);
    var changed = length != prevLng;
    return changed;
  }
}

extension IDBFactoryExtension on IDBFactory {
  Future<IDBDatabase?> openDatabase(
    String name, {
    int? version,
    void Function(Event event)? onUpgradeNeeded,
    void Function(Event event)? onBlocked,
  }) async {
    if ((version == null) != (onUpgradeNeeded == null)) {
      return Future.error(ArgumentError(
          'version and onUpgradeNeeded must be specified together'));
    }
    try {
      IDBOpenDBRequest? request;
      if (version != null) {
        request = open(name, version);
      } else {
        request = open(name);
      }

      if (onUpgradeNeeded != null) {
        request.onupgradeneeded = onUpgradeNeeded.toJS;
      }

      if (onBlocked != null) {
        request.onblocked = onBlocked.toJS;
      }

      final completer = Completer<void>();

      request.onerror = ((Event _) => completer
          .completeError(request?.error?.message ?? 'Unknown Error!')).toJS;

      request.onsuccess = ((Event _) => completer.complete()).toJS;

      await completer.future;

      return request.result as IDBDatabase?;
    } catch (e, stacktrace) {
      return Future.error(e, stacktrace);
    }
  }
}

extension IDBRequestExtension on IDBRequest {
  Future<R?> process<T extends JSAny, R>(
      ({bool next, R? result}) Function(T? result) processor) {
    final completer = Completer<R?>();

    onsuccess = (Event event) {
      var request = event.target as IDBRequest;
      var cursor = request.result as T?;

      var (next: next, result: r) = processor(cursor);

      if (!next) {
        completer.completeSafe(r);
      }
    }.toJS;

    onerror = (Event event) {
      var request = event.target as IDBRequest;
      var error = request.error;

      if (error != null) {
        completer.completeErrorSafe(error);
      } else {
        completer.completeErrorSafe("`IDBRequest` error!");
      }
    }.toJS;

    return completer.future;
  }
}

extension TextMetricsExtension on TextMetrics {
  double? get tryActualBoundingBoxAscent =>
      tryCall(() => actualBoundingBoxAscent);

  double? get tryActualBoundingBoxDescent =>
      tryCall(() => actualBoundingBoxDescent);

  double? get tryFontBoundingBoxAscent => tryCall(() => fontBoundingBoxAscent);

  double? get tryFontBoundingBoxDescent =>
      tryCall(() => fontBoundingBoxDescent);

  double? get tryEmHeightAscent => tryCall(() => emHeightAscent);
}

extension MouseEventExtension on MouseEvent {
  Point get clientPoint => Point(clientX, clientY);

  Point get offsetPoint => Point(offsetX, offsetY);

  Point get pagePoint => Point(pageX, pageY);

  Point get screenPoint => Point(screenX, screenY);
}

extension TouchExtension on Touch {
  Point get clientPoint => Point(clientX, clientY);

  Point get radiusPoint => Point(radiusX, radiusY);

  Point get pagePoint => Point(pageX, pageY);

  Point get screenPoint => Point(screenX, screenY);
}

extension FileReaderExtension on FileReader {
  Stream<ProgressEvent> get onLoad =>
      EventStreamProviders.loadEvent.forTarget(this);

  Stream<ProgressEvent> get onLoadStart =>
      EventStreamProviders.loadStartEvent.forTarget(this);

  Stream<ProgressEvent> get onError =>
      EventStreamProviders.errorEvent.forTarget(this);

  Stream<ProgressEvent> get onAbort =>
      EventStreamProviders.abortEvent.forTarget(this);
}

extension WorkerGlobalScopeExtension on WorkerGlobalScope {
  web.$Console get console => web.console;
}

extension WindowExtension on Window {
  web.$Console get console => web.console;

  Stream<Event> get onResize =>
      EventStreamProviders.resizeEvent.forTarget(this);

  Stream<Event> get onHashChange =>
      EventStreamProviders.hashChangeEvent.forTarget(this);

  Stream<DeviceOrientationEvent> get onDeviceOrientation =>
      EventStreamProviders.deviceOrientationEvent.forTarget(this);

  Stream<TouchEvent> get onTouchStart =>
      EventStreamProviders.touchStartEvent.forTarget(this);

  Stream<TouchEvent> get onTouchEndEvent =>
      EventStreamProviders.touchEndEvent.forTarget(this);

  Stream<TouchEvent> get onTouchEnterEvent =>
      EventStreamProviders.touchEnterEvent.forTarget(this);

  Stream<TouchEvent> get onTouchLeaveEvent =>
      EventStreamProviders.touchLeaveEvent.forTarget(this);
}

extension DOMRectExtension on DOMRect {
  Rectangle<double> toRectangle() => Rectangle<double>(x, y, width, height);
}

extension _CompleterExtension<T> on Completer<T> {
  void completeSafe([FutureOr<T>? value]) {
    if (!isCompleted) {
      complete(value);
    }
  }

  void completeErrorSafe(Object error, [StackTrace? stackTrace]) {
    if (!isCompleted) {
      completeError(error, stackTrace);
    }
  }
}
