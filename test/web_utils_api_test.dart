@TestOn('browser')
library;

import 'dart:math';

import 'package:test/test.dart';
import 'package:web_utils/src/web_utils_type_checks.dart';
import 'package:web_utils/web_utils.dart';

/// Unit tests covering the public API of `web_utils`, member by member.

class _Foo {}

const _svgNS = 'http://www.w3.org/2000/svg';
const _mathMLNS = 'http://www.w3.org/1998/Math/MathML';
const _xlinkNS = 'http://www.w3.org/1999/xlink';

HTMLDivElement _attached() {
  final div = HTMLDivElement();
  document.body!.appendChild(div);
  addTearDown(() => div.remove());
  return div;
}

HTMLDivElement _divWith(String html) => HTMLDivElement()..innerHTML = html.toJS;

/// Returns [value] with a nullable static type.
T? _nullable<T>(T? value) => value;

/// Matches the same JS object as [expected] (JS `===`). With `dart2wasm`,
/// the same JS object can be wrapped by distinct Dart objects, so `same`
/// can't be used.
Matcher _sameJS(JSAny expected) => predicate<Object?>(
  (actual) => (actual as JSAny?).strictEquals(expected).toDart,
  'the same JS object as $expected',
);

/// Every `Web` HTML element type with a factory for an instance of it.
final _htmlTypes = <(Web<Element>, Element Function())>[
  (Web.HTMLDivElement, () => HTMLDivElement()),
  (Web.HTMLLinkElement, () => HTMLLinkElement()),
  (Web.HTMLButtonElement, () => HTMLButtonElement()),
  (Web.HTMLTextAreaElement, () => HTMLTextAreaElement()),
  (Web.HTMLInputElement, () => HTMLInputElement()),
  (Web.HTMLSelectElement, () => HTMLSelectElement()),
  (Web.HTMLOptionElement, () => HTMLOptionElement()),
  (Web.HTMLAnchorElement, () => HTMLAnchorElement()),
  (Web.HTMLImageElement, () => HTMLImageElement()),
  (Web.HTMLSpanElement, () => HTMLSpanElement()),
  (Web.HTMLTableElement, () => HTMLTableElement()),
  (Web.HTMLTableRowElement, () => HTMLTableRowElement()),
  (Web.HTMLTableCellElement, () => document.createElement('td')),
  (Web.HTMLFormElement, () => HTMLFormElement()),
  (Web.HTMLLabelElement, () => HTMLLabelElement()),
  (Web.HTMLParagraphElement, () => HTMLParagraphElement()),
  (Web.HTMLHeadingElement, () => HTMLHeadingElement.h1()),
  (Web.HTMLUListElement, () => HTMLUListElement()),
  (Web.HTMLOListElement, () => HTMLOListElement()),
  (Web.HTMLLIElement, () => HTMLLIElement()),
  (Web.HTMLIFrameElement, () => HTMLIFrameElement()),
  (Web.HTMLMetaElement, () => HTMLMetaElement()),
  (Web.HTMLScriptElement, () => HTMLScriptElement()),
  (Web.HTMLStyleElement, () => HTMLStyleElement()),
  (Web.HTMLCanvasElement, () => HTMLCanvasElement()),
  (Web.HTMLVideoElement, () => HTMLVideoElement()),
  (Web.HTMLAudioElement, () => HTMLAudioElement()),
  (Web.HTMLDialogElement, () => HTMLDialogElement()),
  (Web.HTMLOutputElement, () => HTMLOutputElement()),
  (Web.HTMLPictureElement, () => HTMLPictureElement()),
  (Web.HTMLSourceElement, () => HTMLSourceElement()),
  (Web.HTMLTrackElement, () => HTMLTrackElement()),
  (Web.HTMLTableCaptionElement, () => HTMLTableCaptionElement()),
  (Web.HTMLTableColElement, () => document.createElement('col')),
  (Web.HTMLTableSectionElement, () => document.createElement('tbody')),
];

void main() {
  group('Web enum', () {
    for (final cached in [true, false]) {
      group(cached ? 'cached' : 'uncached', () {
        setUp(() {
          final prev = Web.cachedDOMTypesChecks;
          Web.cachedDOMTypesChecks = cached;
          addTearDown(() => Web.cachedDOMTypesChecks = prev);
        });

        test('each HTML type matches only its own elements', () {
          expect(Web.cachedDOMTypesChecks, equals(cached));

          for (final (type, create) in _htmlTypes) {
            final own = create();
            expect(type.isOf(own), isTrue, reason: '$type');
            expect(type.castNullable(own), isNotNull, reason: '$type');
            expect(type.cast(own), isNotNull, reason: '$type');

            expect(Web.Node.isOf(own), isTrue, reason: '$type');
            expect(Web.Element.isOf(own), isTrue, reason: '$type');
            expect(Web.HTMLElement.isOf(own), isTrue, reason: '$type');
            expect(Web.Text.isOf(own), isFalse, reason: '$type');

            for (final (other, _) in _htmlTypes) {
              if (other == type) continue;
              expect(other.isOf(own), isFalse, reason: '$other.isOf($type)');
              expect(other.castNullable(own), isNull, reason: '$other');
            }
          }
        });

        test('Node / Text / Element / HTMLElement', () {
          final text = Text('t');
          final comment = Comment('c');
          final svg = document.createElementNS(_svgNS, 'svg');
          final div = HTMLDivElement();

          expect(Web.Node.isOf(text), isTrue);
          expect(Web.Node.isOf(comment), isTrue);
          expect(Web.Text.isOf(text), isTrue);
          expect(Web.Text.isOf(comment), isFalse);
          expect(Web.Text.castNullable(text), isNotNull);
          expect(Web.Element.isOf(text), isFalse);

          expect(Web.Element.isOf(svg), isTrue);
          expect(Web.HTMLElement.isOf(svg), isFalse);
          expect(Web.Element.castNullable(svg), isNotNull);
          expect(Web.HTMLElement.castNullable(svg), isNull);

          expect(Web.HTMLElement.castNullable(div), isNotNull);
          expect(Web.Node.castNullable(div), isNotNull);
        });

        test('non-DOM values', () {
          for (final value in <Object?>[null, 1, 'div', _Foo(), JSObject()]) {
            expect(Web.HTMLDivElement.isOf(value), isFalse, reason: '$value');
            expect(Web.Node.castNullable(value), isNull, reason: '$value');
          }
        });
      });
    }

    test('cast errors', () {
      expect(() => Web.HTMLDivElement.cast(null), throwsArgumentError);
      expect(
        () => Web.HTMLDivElement.cast(HTMLSpanElement()),
        throwsArgumentError,
      );
      expect(() => Web.HTMLDivElement.cast(_Foo()), throwsArgumentError);
    });

    test('toString / isSupported', () {
      expect(
        Web.HTMLDivElement.toString(),
        equals('`web` type `HTMLDivElement`'),
      );
      for (final type in Web.values) {
        expect(type.isSupported, isTrue, reason: '$type');
      }
    });

    test('Notification', () {
      expect(Web.Notification.isOf(HTMLDivElement()), isFalse);
      expect(Web.Notification.castNullable(HTMLDivElement()), isNull);
    });
  });

  group('DOM type checks', () {
    test('JSAny / JSObject / nullable variants agree', () {
      final div = HTMLDivElement();
      final JSAny any = div;
      final JSObject obj = div;
      final nullableAny = _nullable<JSAny>(div);
      final nullableObj = _nullable<JSObject>(div);
      final nullAny = _nullable<JSAny>(null);
      final nullObj = _nullable<JSObject>(null);

      expect(any.isHTMLDivElement, isTrue);
      expect(obj.isHTMLDivElement, isTrue);
      expect(nullableAny.isHTMLDivElement, isTrue);
      expect(nullableObj.isHTMLDivElement, isTrue);
      expect(nullAny.isHTMLDivElement, isFalse);
      expect(nullObj.isHTMLDivElement, isFalse);

      expect(obj.isNode && obj.isElement && obj.isHTMLElement, isTrue);
      // `isNode`/`isElement` on `JSObject?` are also declared by
      // `JSObjectWebExtension` (see below), so override explicitly:
      expect(JSObjectDOMTypeChecksNullable(nullableObj).isNode, isTrue);
      expect(JSObjectDOMTypeChecksNullable(nullObj).isNode, isFalse);
      expect(JSObjectDOMTypeChecksNullable(nullObj).isElement, isFalse);
      expect(JSObjectDOMTypeChecksNullable(nullObj).isHTMLElement, isFalse);

      expect(Text('x').isText, isTrue);
      expect((Text('x') as JSObject?).isText, isTrue);
      expect(Comment('x').isComment, isTrue);
      expect((Comment('x') as JSObject).isComment, isTrue);
      expect(nullAny.isComment, isFalse);
    });

    test('every element type check, on JSAny? / JSObject / JSObject?', () {
      // (element, JSAny? check, JSObject check, JSObject? check)
      final cases =
          <
            (
              Element Function(),
              bool Function(JSAny?),
              bool Function(JSObject),
              bool Function(JSObject?),
            )
          >[
            (
              () => HTMLDivElement(),
              (o) => o.isHTMLDivElement,
              (o) => o.isHTMLDivElement,
              (o) => o.isHTMLDivElement,
            ),
            (
              () => HTMLLinkElement(),
              (o) => o.isHTMLLinkElement,
              (o) => o.isHTMLLinkElement,
              (o) => o.isHTMLLinkElement,
            ),
            (
              () => HTMLButtonElement(),
              (o) => o.isHTMLButtonElement,
              (o) => o.isHTMLButtonElement,
              (o) => o.isHTMLButtonElement,
            ),
            (
              () => HTMLTextAreaElement(),
              (o) => o.isHTMLTextAreaElement,
              (o) => o.isHTMLTextAreaElement,
              (o) => o.isHTMLTextAreaElement,
            ),
            (
              () => HTMLInputElement(),
              (o) => o.isHTMLInputElement,
              (o) => o.isHTMLInputElement,
              (o) => o.isHTMLInputElement,
            ),
            (
              () => HTMLSelectElement(),
              (o) => o.isHTMLSelectElement,
              (o) => o.isHTMLSelectElement,
              (o) => o.isHTMLSelectElement,
            ),
            (
              () => HTMLOptionElement(),
              (o) => o.isHTMLOptionElement,
              (o) => o.isHTMLOptionElement,
              (o) => o.isHTMLOptionElement,
            ),
            (
              () => HTMLAnchorElement(),
              (o) => o.isHTMLAnchorElement,
              (o) => o.isHTMLAnchorElement,
              (o) => o.isHTMLAnchorElement,
            ),
            (
              () => HTMLImageElement(),
              (o) => o.isHTMLImageElement,
              (o) => o.isHTMLImageElement,
              (o) => o.isHTMLImageElement,
            ),
            (
              () => HTMLSpanElement(),
              (o) => o.isHTMLSpanElement,
              (o) => o.isHTMLSpanElement,
              (o) => o.isHTMLSpanElement,
            ),
            (
              () => HTMLTableElement(),
              (o) => o.isHTMLTableElement,
              (o) => o.isHTMLTableElement,
              (o) => o.isHTMLTableElement,
            ),
            (
              () => HTMLTableRowElement(),
              (o) => o.isHTMLTableRowElement,
              (o) => o.isHTMLTableRowElement,
              (o) => o.isHTMLTableRowElement,
            ),
            (
              () => document.createElement('td'),
              (o) => o.isHTMLTableCellElement,
              (o) => o.isHTMLTableCellElement,
              (o) => o.isHTMLTableCellElement,
            ),
            (
              () => HTMLFormElement(),
              (o) => o.isHTMLFormElement,
              (o) => o.isHTMLFormElement,
              (o) => o.isHTMLFormElement,
            ),
            (
              () => HTMLLabelElement(),
              (o) => o.isHTMLLabelElement,
              (o) => o.isHTMLLabelElement,
              (o) => o.isHTMLLabelElement,
            ),
            (
              () => HTMLParagraphElement(),
              (o) => o.isHTMLParagraphElement,
              (o) => o.isHTMLParagraphElement,
              (o) => o.isHTMLParagraphElement,
            ),
            (
              () => HTMLHeadingElement.h2(),
              (o) => o.isHTMLHeadingElement,
              (o) => o.isHTMLHeadingElement,
              (o) => o.isHTMLHeadingElement,
            ),
            (
              () => HTMLUListElement(),
              (o) => o.isHTMLUListElement,
              (o) => o.isHTMLUListElement,
              (o) => o.isHTMLUListElement,
            ),
            (
              () => HTMLOListElement(),
              (o) => o.isHTMLOListElement,
              (o) => o.isHTMLOListElement,
              (o) => o.isHTMLOListElement,
            ),
            (
              () => HTMLLIElement(),
              (o) => o.isHTMLLIElement,
              (o) => o.isHTMLLIElement,
              (o) => o.isHTMLLIElement,
            ),
            (
              () => HTMLIFrameElement(),
              (o) => o.isHTMLIFrameElement,
              (o) => o.isHTMLIFrameElement,
              (o) => o.isHTMLIFrameElement,
            ),
            (
              () => HTMLMetaElement(),
              (o) => o.isHTMLMetaElement,
              (o) => o.isHTMLMetaElement,
              (o) => o.isHTMLMetaElement,
            ),
            (
              () => HTMLScriptElement(),
              (o) => o.isHTMLScriptElement,
              (o) => o.isHTMLScriptElement,
              (o) => o.isHTMLScriptElement,
            ),
            (
              () => HTMLStyleElement(),
              (o) => o.isHTMLStyleElement,
              (o) => o.isHTMLStyleElement,
              (o) => o.isHTMLStyleElement,
            ),
            (
              () => HTMLCanvasElement(),
              (o) => o.isHTMLCanvasElement,
              (o) => o.isHTMLCanvasElement,
              (o) => o.isHTMLCanvasElement,
            ),
            (
              () => HTMLVideoElement(),
              (o) => o.isHTMLVideoElement,
              (o) => o.isHTMLVideoElement,
              (o) => o.isHTMLVideoElement,
            ),
            (
              () => HTMLAudioElement(),
              (o) => o.isHTMLAudioElement,
              (o) => o.isHTMLAudioElement,
              (o) => o.isHTMLAudioElement,
            ),
            (
              () => HTMLDialogElement(),
              (o) => o.isHTMLDialogElement,
              (o) => o.isHTMLDialogElement,
              (o) => o.isHTMLDialogElement,
            ),
            (
              () => HTMLOutputElement(),
              (o) => o.isHTMLOutputElement,
              (o) => o.isHTMLOutputElement,
              (o) => o.isHTMLOutputElement,
            ),
            (
              () => HTMLPictureElement(),
              (o) => o.isHTMLPictureElement,
              (o) => o.isHTMLPictureElement,
              (o) => o.isHTMLPictureElement,
            ),
            (
              () => HTMLSourceElement(),
              (o) => o.isHTMLSourceElement,
              (o) => o.isHTMLSourceElement,
              (o) => o.isHTMLSourceElement,
            ),
            (
              () => HTMLTrackElement(),
              (o) => o.isHTMLTrackElement,
              (o) => o.isHTMLTrackElement,
              (o) => o.isHTMLTrackElement,
            ),
            (
              () => HTMLTableCaptionElement(),
              (o) => o.isHTMLTableCaptionElement,
              (o) => o.isHTMLTableCaptionElement,
              (o) => o.isHTMLTableCaptionElement,
            ),
            (
              () => document.createElement('col'),
              (o) => o.isHTMLTableColElement,
              (o) => o.isHTMLTableColElement,
              (o) => o.isHTMLTableColElement,
            ),
            (
              () => document.createElement('thead'),
              (o) => o.isHTMLTableSectionElement,
              (o) => o.isHTMLTableSectionElement,
              (o) => o.isHTMLTableSectionElement,
            ),
          ];

      for (final cached in [true, false]) {
        JSAnyDOMTypeChecks.cached = cached;
        try {
          for (var i = 0; i < cases.length; i++) {
            final (create, isAny, isObj, isNullableObj) = cases[i];
            final e = create();
            final reason = '${e.tagName} (cached: $cached)';

            expect(isAny(e), isTrue, reason: reason);
            expect(isObj(e), isTrue, reason: reason);
            expect(isNullableObj(e), isTrue, reason: reason);
            expect(isAny(null), isFalse, reason: reason);
            expect(isNullableObj(null), isFalse, reason: reason);

            final other = cases[(i + 1) % cases.length].$1();
            expect(
              isAny(other),
              isFalse,
              reason: '$reason vs ${other.tagName}',
            );
            expect(
              isObj(other),
              isFalse,
              reason: '$reason vs ${other.tagName}',
            );
          }
        } finally {
          JSAnyDOMTypeChecks.cached = true;
        }
      }
    });

    test('Node / Element / HTMLElement / Text / Comment on JSAny?', () {
      final div = _nullable<JSAny>(HTMLDivElement());
      final text = _nullable<JSAny>(Text('t'));
      final comment = _nullable<JSAny>(Comment('c'));
      final none = _nullable<JSAny>(null);

      for (final cached in [true, false]) {
        JSAnyDOMTypeChecks.cached = cached;
        try {
          expect(div.isNode && div.isElement && div.isHTMLElement, isTrue);
          expect(text.isNode && text.isText && !text.isElement, isTrue);
          expect(comment.isNode && comment.isComment, isTrue);
          expect(none.isNode || none.isElement || none.isHTMLElement, isFalse);
          expect(none.isText || none.isComment, isFalse);
        } finally {
          JSAnyDOMTypeChecks.cached = true;
        }
      }
    });

    test('primitives are not DOM types', () {
      expect('x'.toJS.isNode, isFalse);
      expect(1.toJS.isElement, isFalse);
      expect(true.toJS.isHTMLElement, isFalse);
    });
  });

  group('WebObjectExtension / JSObjectWebExtension', () {
    test('Object?', () {
      expect((HTMLDivElement() as Object?).isNode, isTrue);
      expect((HTMLDivElement() as Object?).isElement, isTrue);
      expect((HTMLDivElement() as Object?).isHTMLElement, isTrue);
      expect((Text('t') as Object?).isElement, isFalse);
      expect((null as Object?).isNode, isFalse);
      expect(('div' as Object?).isNode, isFalse);
      expect((_Foo() as Object?).isHTMLElement, isFalse);
    });

    test('JSObject?', () {
      final none = _nullable<JSObject>(null);
      final svg = _nullable<JSObject>(document.createElementNS(_svgNS, 'svg'));
      expect(JSObjectWebExtension(none).isNode, isFalse);
      expect(JSObjectWebExtension(svg).isNode, isTrue);
      expect(JSObjectWebExtension(svg).isElement, isTrue);
      expect(JSObjectWebExtension(svg).isHTMLElement, isFalse);
      expect(JSObjectWebExtension(HTMLDivElement()).isHTMLElement, isTrue);
    });
  });

  group('Iterable extensions', () {
    test('Iterable<Object?>.whereElement / whereElementType', () {
      final div = HTMLDivElement();
      final span = HTMLSpanElement();
      final values = <Object?>[div, 'x', null, Text('t'), span, _Foo(), 1];

      expect(values.whereElement().toList(), equals([div, span]));
      expect(
        values.whereElementType(Web.HTMLSpanElement).toList(),
        equals([span]),
      );
    });

    test('Iterable<JSAny?>', () {
      final div = HTMLDivElement();
      final values = <JSAny?>[div, 'x'.toJS, null, Text('t')];
      expect(values.whereElement().toList(), equals([div]));
      expect(
        values.whereElementType(Web.HTMLDivElement).toList(),
        equals([div]),
      );
      expect(values.whereElementType(Web.HTMLSpanElement), isEmpty);
    });

    test('Iterable<Element?>', () {
      final div = HTMLDivElement();
      final svg = document.createElementNS(_svgNS, 'svg');
      final values = <Element?>[div, null, svg];
      expect(values.whereElement().toList(), equals([div, svg]));
      expect(values.whereElementType(Web.HTMLElement).toList(), equals([div]));
    });

    test('Iterable<Node>', () {
      final div = HTMLDivElement();
      final svg = document.createElementNS(_svgNS, 'svg');
      final text = Text('t');
      final nodes = <Node>[div, text, svg];

      expect(nodes.whereElement().toList(), equals([div, svg]));
      expect(nodes.toElements(), equals([div, svg]));
      expect(nodes.whereHTMLElement().toList(), equals([div]));
      expect(nodes.toHTMLElements(), equals([div]));
      expect(
        nodes.whereElementType(Web.HTMLDivElement).toList(),
        equals([div]),
      );
    });
  });

  group('DocumentExtension', () {
    test('select / selectAll (typed and non-typed)', () {
      final root = _attached()
        ..innerHTML =
            '<p class="api-doc">1</p><span class="api-doc">2</span>'.toJS;

      expect(document.select('.api-doc')!.textContent, equals('1'));
      expect(document.querySelectorNonTyped('span.api-doc'), isNotNull);
      expect(document.selectAll('.api-doc').length, equals(2));
      expect(document.querySelectorAllNonTyped('.api-doc').length, equals(2));

      expect(
        document.selectTyped('.api-doc', Web.HTMLParagraphElement),
        isNotNull,
      );
      expect(document.selectTyped('.api-doc', Web.HTMLSpanElement), isNull);
      expect(
        document.querySelectorTyped('span.api-doc', Web.HTMLSpanElement),
        isNotNull,
      );
      expect(
        document.selectAllTyped('.api-doc', Web.HTMLSpanElement).single.text,
        equals('2'),
      );
      expect(
        document.querySelectorAllTyped('.api-doc', Web.HTMLElement).length,
        equals(2),
      );
      expect(document.select('.api-doc-none'), isNull);
      expect(root.isConnected, isTrue);
    });
  });

  group('NodeNullableExtension / NodeExtension', () {
    test('checked casts', () {
      final Node div = HTMLDivElement();
      final Node text = Text('t');
      final Node svg = document.createElementNS(_svgNS, 'svg');
      const Node? none = null;

      expect(div.asElementChecked, isNotNull);
      expect(div.asHTMLElementChecked, isNotNull);
      expect(text.asElementChecked, isNull);
      expect(svg.asHTMLElementChecked, isNull);
      expect(none.asElementChecked, isNull);
      expect(none.asHTMLElementChecked, isNull);

      expect(div.asElement, _sameJS(div));
      expect(div.asHTMLElement, _sameJS(div));
    });

    test('insertNode', () {
      final Node parent = HTMLDivElement();
      final a = Text('a');
      final b = Text('b');
      final c = Text('c');
      final d = Text('d');

      parent.insertNode(0, b); // empty -> append
      parent.insertNode(0, a); // front
      parent.insertNode(10, d); // past end -> append
      parent.insertNode(2, c); // middle
      expect(parent.textContent, equals('abcd'));
    });

    test('removeNodeAt', () {
      final Node parent = _divWith('<i>0</i>1<b>2</b>');
      expect(parent.removeNodeAt(-1), isNull);
      expect(parent.removeNodeAt(3), isNull);
      expect(parent.removeNodeAt(1)!.textContent, equals('1'));
      expect(parent.textContent, equals('02'));
    });

    test('appendNodes / removeNodes / remove', () {
      final Node parent = HTMLDivElement();
      final nodes = [
        Text('a'),
        HTMLSpanElement()..textContent = 'b',
        Text('c'),
      ];
      parent.appendNodes(nodes);
      expect(parent.textContent, equals('abc'));

      parent.removeNodes(nodes.take(2));
      expect(parent.textContent, equals('c'));

      nodes.last.remove();
      expect(parent.childNodes.length, equals(0));
      Text('orphan').remove(); // no parent: no-op
    });

    test('removeNodeWhere', () {
      final Node parent = _divWith('<i>x</i>keep<b>x</b><u>keep</u>');
      parent.removeNodeWhere((n) => n.textContent == 'x');
      expect(parent.textContent, equals('keepkeep'));
      expect(parent.childNodes.length, equals(2));
    });

    test('clear: Element', () {
      final Node parent = _divWith('<i>a</i>b');
      parent.clear();
      expect(parent.childNodes.length, equals(0));
    });

    test('clear / clearNodes: non-Element node', () {
      final fragment = DocumentFragment()
        ..appendChild(Text('a'))
        ..appendChild(HTMLSpanElement());

      final removed = fragment.clearNodes();
      expect(removed.length, equals(2));
      expect(fragment.childNodes.length, equals(0));

      fragment.appendChild(Text('b'));
      fragment.clear();
      expect(fragment.childNodes.length, equals(0));
    });
  });

  group('ElementNullableExtension', () {
    test('asHTMLElement / isElementOf / asElementOf', () {
      final Element div = HTMLDivElement();
      final Element svg = document.createElementNS(_svgNS, 'svg');
      const Element? none = null;

      expect(ElementNullableExtension(div).asHTMLElement, isNotNull);
      expect(ElementNullableExtension(svg).asHTMLElement, isNull);
      expect(none.asHTMLElement, isNull);

      expect(div.isElementOf(Web.HTMLDivElement), isTrue);
      expect(div.isElementOf(Web.HTMLSpanElement), isFalse);
      expect(none.isElementOf(Web.HTMLDivElement), isFalse);

      expect(div.asElementOf(Web.HTMLDivElement), _sameJS(div));
      expect(() => div.asElementOf(Web.HTMLSpanElement), throwsArgumentError);
      expect(div.asElementOfNullable(Web.HTMLSpanElement), isNull);
      expect(none.asElementOfNullable(Web.HTMLDivElement), isNull);
    });

    test('isCanvasImageSource', () {
      expect(HTMLImageElement().isCanvasImageSource, isTrue);
      expect(HTMLCanvasElement().isCanvasImageSource, isTrue);
      expect(HTMLVideoElement().isCanvasImageSource, isTrue);
      expect(HTMLDivElement().isCanvasImageSource, isFalse);
      expect((null as Element?).isCanvasImageSource, isFalse);
    });
  });

  group('ElementExtension', () {
    test('text / classes / classList', () {
      final Element e = HTMLDivElement();
      e.text = 'hello';
      expect(e.text, equals('hello'));
      e.text = null;
      expect(e.text, isEmpty);

      expect(e.classes, isNotNull);
      e.classList.add('a');
      expect(e.classes!.toList(), equals(['a']));
      expect(ElementExtension(e).classList!.toList(), equals(['a']));

      // The native `Element.classList` shadows the extension getter:
      final Element svg = document.createElementNS(_svgNS, 'svg');
      expect(ElementExtension(svg).classList, isNull, reason: 'not HTML');
      expect(svg.classes, isNull);
    });

    test('select / selectAll on elements', () {
      final Element e = _divWith(
        '<span class="s">1</span><p><span class="s">2</span></p>',
      );
      expect(e.select('.s')!.textContent, equals('1'));
      expect(e.querySelectorNonTyped('p .s')!.textContent, equals('2'));
      expect(e.selectAll('.s').length, equals(2));
      expect(e.querySelectorAllNonTyped('.s').length, equals(2));
      expect(e.selectTyped('.s', Web.HTMLSpanElement), isNotNull);
      expect(e.querySelectorTyped('.s', Web.HTMLDivElement), isNull);
      expect(e.selectAllTyped('span', Web.HTMLSpanElement).length, equals(2));
      expect(e.querySelectorAllTyped('p', Web.HTMLSpanElement), isEmpty);
    });

    test('insertChild / removeChildAt', () {
      final Element e = HTMLDivElement();
      Element el(String t) => HTMLSpanElement()..textContent = t;

      e.insertChild(0, el('b')); // empty -> append
      e.insertChild(0, el('a')); // front
      e.insertChild(5, el('d')); // past end
      e.insertChild(2, el('c')); // middle
      expect(e.textContent, equals('abcd'));

      expect(e.removeChildAt(-1), isNull);
      expect(e.removeChildAt(4), isNull);
      expect(e.removeChildAt(1)!.textContent, equals('b'));
      expect(e.textContent, equals('acd'));
    });

    test('appendAll / clear', () {
      final Element e = HTMLDivElement();
      e.appendAll(['a'.toJS, HTMLSpanElement()..textContent = 'b', Text('c')]);
      expect(e.textContent, equals('abc'));
      expect(e.childNodes.length, equals(3));
      e.clear();
      expect(e.childNodes.length, equals(0));
    });

    test('style for HTML / SVG / MathML / other elements', () {
      final Element div = HTMLDivElement();
      final Element svg = document.createElementNS(_svgNS, 'svg');
      final Element math = document.createElementNS(_mathMLNS, 'math');
      final Element other = document.createElementNS('urn:x', 'x');

      expect(div.style, isNotNull);
      expect(svg.style, isNotNull);
      expect(math.style, isNotNull);
      expect(other.style, isNull);

      div.style!.color = 'red';
      expect(div.style!.isNotEmpty, isTrue);
      expect(HTMLDivElement().style.isEmpty, isTrue);
    });

    test('getComputedStyle', () {
      final Element e = _attached()..setAttribute('style', 'display: flex');
      expect(e.getComputedStyle().display, equals('flex'));
    });

    test('hidden', () {
      final Element e = HTMLDivElement();
      expect(e.hidden, isFalse);
      e.hidden = true;
      expect(e.hidden, isTrue);
      expect(e.hasAttribute('hidden'), isTrue);
      e.hidden = false;
      expect(e.hidden, isFalse);

      final Element svg = document.createElementNS(_svgNS, 'svg');
      expect(svg.hidden, isFalse);
      svg.hidden = true; // not an HTMLElement: no-op
    });

    test('click / focus', () {
      final Element button = HTMLButtonElement();
      _attached().appendChild(button);

      var clicks = 0;
      final reg = button.addEventListenerTyped(
        EventType.click,
        (MouseEvent _) => clicks++,
      );
      addTearDown(reg.unregister);

      button.click();
      expect(clicks, equals(1));

      expect(button.focus(), isTrue);
      expect(document.activeElement, _sameJS(button));

      final Element svg = document.createElementNS(_svgNS, 'svg');
      expect(svg.focus(), isFalse);
      svg.click(); // not an HTMLElement: no-op
    });

    test('dispatchChangeEvent', () {
      final Element e = HTMLInputElement();
      var changes = 0;
      final reg = e.addEventListenerTyped(
        EventType.change,
        (Event _) => changes++,
      );
      addTearDown(reg.unregister);

      expect(e.dispatchChangeEvent(), isTrue);
      expect(changes, equals(1));
    });

    test('dispatchEventOfType options', () {
      final Element e = HTMLDivElement();
      Event? last;
      final reg = e.addEventListenerTyped(
        EventType.input,
        (Event ev) => last = ev,
      );
      addTearDown(reg.unregister);

      e.dispatchEventOfType('input');
      expect(last!.bubbles, isFalse);
      expect(last!.cancelable, isFalse);

      e.dispatchEventOfType(
        'input',
        bubbles: true,
        cancelable: true,
        composed: true,
      );
      expect(last!.bubbles, isTrue);
      expect(last!.cancelable, isTrue);
      expect(last!.composed, isTrue);
    });

    test('setAttributes / setAttributesFromKeyValueLists', () {
      final Element e = HTMLDivElement()..setAttribute('data-x', 'old');
      e.setAttributes({'id': 'i', 'data-y': '2'});
      e.setAttributesFromKeyValueLists(['data-x', 'title'], [null, 't']);
      expect(
        e.attributes.toMap(),
        equals({'id': 'i', 'data-y': '2', 'title': 't'}),
      );
    });

    test('setAttributesFromKeyValueLists helper', () {
      final e = HTMLDivElement();
      setAttributesFromKeyValueLists(e, ['a', 'b'], ['1', '2']);
      setAttributesFromKeyValueLists(e, [], []);
      expect(e.getAttribute('a'), equals('1'));
      expect(e.getAttribute('b'), equals('2'));
    });
  });

  group('HTMLElementExtension', () {
    test('classes', () {
      final e = HTMLDivElement()..className = 'a b';
      expect(e.classes.toList(), equals(['a', 'b']));
    });

    test('appendHTML', () {
      final e = HTMLDivElement();
      final nodes = e.appendHTML('<b>1</b>text<i>2</i>');
      expect(nodes.length, equals(3));
      expect(e.innerHTML.dartify(), equals('<b>1</b>text<i>2</i>'));
      expect(e.appendHTML(''), isEmpty);
    });

    test('isHidden', () {
      final e = HTMLDivElement();
      expect(e.isHidden, isFalse);
      e.hidden = true.toJS;
      expect(e.isHidden, isTrue);
      e.hidden = false.toJS;
      expect(e.isHidden, isFalse);
      e.hidden = 'until-found'.toJS;
      expect(e.isHidden, isFalse);
    });
  });

  group('collections', () {
    test('HTMLSelectElement / HTMLOptionsCollection', () {
      final select = HTMLSelectElement();
      expect(select.options.isEmpty, isTrue);
      expect(select.selectedOptionsSafe, isEmpty);

      select
        ..appendChild(HTMLOptionElement()..text = 'a')
        ..appendChild(HTMLOptionElement()..text = 'b');

      final options = select.options;
      expect(options.isNotEmpty, isTrue);
      expect(options.toList().map((o) => o.text), equals(['a', 'b']));
      expect(options.toIterable().length, equals(2));

      final live = options.asListView;
      final fixed = options.asListViewFixed;
      select.appendChild(HTMLOptionElement()..text = 'c');
      expect(live.length, equals(3));
      expect(fixed.length, equals(2));

      expect(select.selectIndex(2), isTrue);
      expect(select.selectedOptionsSafe.single.text, equals('c'));
    });

    test('DOMTokenList', () {
      final list = HTMLDivElement().classList;
      expect(list.isEmpty, isTrue);

      expect(list.addAndDetectChange('a'), isTrue);
      expect(list.addAndDetectChange('a'), isFalse);
      list.addAll(['b', 'c']);
      expect(list.isNotEmpty, isTrue);
      expect(list.toList(), equals(['a', 'b', 'c']));
      expect(list.toIterable().last, equals('c'));

      final live = list.asListView;
      final fixed = list.asListViewFixed;
      expect(list.removeAndDetectChange('b'), isTrue);
      expect(list.removeAndDetectChange('b'), isFalse);
      expect(live.toList(), equals(['a', 'c']));
      expect(fixed.length, equals(3));

      list.removeAll(['a']);
      expect(list.toList(), equals(['c']));
      list.clear();
      expect(list.isEmpty, isTrue);
    });

    test('NamedNodeMap', () {
      final svg = document.createElementNS(_svgNS, 'svg');
      svg.setAttribute('id', 'i');
      svg.setAttributeNS(_xlinkNS, 'xlink:href', '#h');

      final attrs = svg.attributes;
      expect(attrs.isNotEmpty, isTrue);
      expect(HTMLDivElement().attributes.isEmpty, isTrue);
      expect(attrs.toList().length, equals(2));
      expect(attrs.toIterable().map((a) => a.name), contains('id'));
      expect(attrs.asListView.length, equals(2));
      expect(attrs.asListViewFixed.length, equals(2));
      expect(attrs.whereType<Attr>().length, equals(2));
      expect(attrs.toMap(), equals({'id': 'i', 'xlink:href': '#h'}));

      expect(attrs.containsAttribute('id'), isTrue);
      expect(attrs.containsAttribute('none'), isFalse);
      expect(attrs.getAttributeValue('id'), equals('i'));
      expect(attrs.getAttribute('href', ns: _xlinkNS)!.value, equals('#h'));
      expect(attrs.getAttributeValue('href', ns: _xlinkNS), equals('#h'));
      expect(attrs.containsAttribute('href'), isFalse);
    });

    test('HTMLCollection', () {
      final e = _divWith('<i>0</i>text<b>1</b>');
      final children = e.children;
      expect(children.isNotEmpty, isTrue);
      expect(HTMLDivElement().children.isEmpty, isTrue);
      expect(children.toList().length, equals(2));
      expect(children.toIterable().first.tagName, equals('I'));
      expect(children.asListView.length, equals(2));
      expect(children.asListViewFixed.length, equals(2));
      expect(children.whereType<Element>().length, equals(2));
      expect(children.indexOf(children.item(1)!), equals(1));
      expect(children.indexOf(HTMLDivElement()), equals(-1));
    });

    test('NodeList', () {
      final e = _divWith('<i>0</i>text<b>1</b>');
      final nodes = e.childNodes;
      expect(nodes.isNotEmpty, isTrue);
      expect(HTMLDivElement().childNodes.isEmpty, isTrue);
      expect(nodes.toList().length, equals(3));
      expect(nodes.toIterable().length, equals(3));
      expect(nodes.asListView.length, equals(3));
      expect(nodes.asListViewFixed.length, equals(3));
      expect(nodes.where((n) => n.isA<Text>()).single.textContent, 'text');
      expect(nodes.whereElement().length, equals(2));
      expect(nodes.toElements().length, equals(2));
      expect(nodes.whereHTMLElement().length, equals(2));
      expect(nodes.toHTMLElements().length, equals(2));
      expect(
        nodes.whereElementType(Web.HTMLElement).map((e) => e.tagName),
        equals(['I', 'B']),
      );
      expect(nodes.indexOf(nodes.item(2)!), equals(2));
      expect(nodes.indexOf(Text('x')), equals(-1));
    });

    test('CSSRuleList', () {
      final style = HTMLStyleElement()..textContent = '.a{color:red}.b{}';
      document.head!.appendChild(style);
      addTearDown(() => style.remove());

      final rules = (style.sheet as CSSStyleSheet).cssRules;
      expect(rules.isNotEmpty, isTrue);
      expect(rules.toList().length, equals(2));
      expect(rules.toIterable().first.cssText, contains('.a'));
      expect(rules.asListView.length, equals(2));
      expect(rules.asListViewFixed.length, equals(2));

      final empty = HTMLStyleElement();
      document.head!.appendChild(empty);
      addTearDown(() => empty.remove());
      expect((empty.sheet as CSSStyleSheet).cssRules.isEmpty, isTrue);
    });

    test('TouchList / Touch', () {
      final target = HTMLDivElement();
      final touch = Touch(
        TouchInit(
          identifier: 1,
          target: target,
          clientX: 1,
          clientY: 2,
          pageX: 3,
          pageY: 4,
          screenX: 5,
          screenY: 6,
          radiusX: 7,
          radiusY: 8,
        ),
      );
      expect(touch.clientPoint, equals(const Point(1, 2)));
      expect(touch.pagePoint, equals(const Point(3, 4)));
      expect(touch.screenPoint, equals(const Point(5, 6)));
      expect(touch.radiusPoint, equals(const Point(7, 8)));

      final event = TouchEvent(
        'touchstart',
        TouchEventInit(touches: [touch].toJS),
      );
      final touches = event.touches;
      expect(touches.isNotEmpty, isTrue);
      expect(touches.toList().single.identifier, equals(1));
      expect(touches.toIterable().length, equals(1));
      expect(touches.asListView.length, equals(1));
      expect(touches.asListViewFixed.length, equals(1));
      expect(TouchEvent('touchend').touches.isEmpty, isTrue);
    });
  });

  group('events', () {
    test('MouseEvent points', () {
      final e = MouseEvent(
        'click',
        MouseEventInit(clientX: 1, clientY: 2, screenX: 5, screenY: 6),
      );
      expect(e.clientPoint, equals(const Point(1, 2)));
      expect(e.pagePoint, equals(const Point(1, 2)));
      expect(e.screenPoint, equals(const Point(5, 6)));
      expect(e.offsetPoint, isA<Point>());
    });

    test('KeyboardEvent keys', () {
      KeyboardEvent key(String k) =>
          KeyboardEvent('keydown', KeyboardEventInit(key: k));

      expect(key('Tab').isKeyTab, isTrue);
      expect(key('Enter').isKeyEnter, isTrue);
      expect(key(' ').isKeySpace, isTrue);
      expect(key('Spacebar').isKeySpace, isTrue);
      expect(key('Escape').isKeyEscape, isTrue);
      expect(key('Esc').isKeyEscape, isTrue);
      expect(key('ArrowUp').isArrowUp, isTrue);
      expect(key('ArrowDown').isArrowDown, isTrue);
      expect(key('ArrowLeft').isArrowLeft, isTrue);
      expect(key('ArrowRight').isArrowRight, isTrue);

      expect(key('Tab').isKeyTabOrEnter, isTrue);
      expect(key('ArrowUp').isArrowKey, isTrue);
      expect(key('Escape').isNavigationKey, isTrue);
      expect(key('a').isNavigationKey, isFalse);
      expect(key('A').keyLC, equals('a'));
      expect(key('a').keyCodeSafe, equals(0));
    });

    test('KeyboardEvent legacy keyCode fallback', () {
      final e = KeyboardEvent(
        'keydown',
        KeyboardEventInit(key: 'Unidentified', keyCode: 13),
      );
      expect(e.keyCodeSafe, equals(13));
      expect(e.isKeyEnter, isTrue);
      expect(e.isKeyTab, isFalse);
    });

    test('EventType types are unique and non-empty', () {
      final types = EventType.values.map((e) => e.type).toList();
      expect(types.every((t) => t.isNotEmpty), isTrue);
      expect(types.toSet().length, equals(types.length));
      expect(EventType.contentLoaded.type, equals('DOMContentLoaded'));
      expect(EventType.doubleClick.type, equals('dblclick'));
    });

    test('RegisteredEventListener / unregisterAll', () {
      final e = HTMLDivElement();
      var count = 0;
      final regs = <RegisteredEventListener?>[
        e.addEventListenerTyped(EventType.click, (MouseEvent _) => count++),
        null,
        EventType.focus.addEventListener(e, (Event _) => count++),
      ];

      expect(regs.first!.eventTarget, _sameJS(e));
      expect(regs.first!.type, equals('click'));

      e.dispatchEvent(MouseEvent('click'));
      e.dispatchEvent(Event('focus'));
      expect(count, equals(2));

      regs.unregisterAll();
      regs.unregisterAll(); // idempotent
      e.dispatchEvent(MouseEvent('click'));
      e.dispatchEvent(Event('focus'));
      expect(count, equals(2));
    });

    test('event stream getters', () async {
      final streams = <Stream<Event>>[
        window.onResize,
        window.onHashChange,
        window.onDeviceOrientation,
        window.onTouchStart,
        window.onTouchEndEvent,
        window.onTouchEnterEvent,
        window.onTouchLeaveEvent,
        window.onOnline,
        window.onOffline,
        window.onKeyUp,
        window.onClick,
        window.onMouseDown,
        window.onMouseUp,
        window.onMouseMove,
        window.onWheel,
        window.onScroll,
        window.onFocus,
        window.onBlur,
        window.onBeforeUnload,
        window.onStorage,
        window.onDeviceMotion,
        window.onTouchEnd,
        window.onTouchCancel,
        FileReader().onError,
        FileReader().onAbort,
        SpeechSynthesisUtterance().onEnd,
        SpeechSynthesisUtterance().onStart,
        SpeechSynthesisUtterance().onPause,
        SpeechSynthesisUtterance().onResume,
        SpeechSynthesisUtterance().onBoundary,
        SpeechSynthesisUtterance().onMark,
        SpeechSynthesisUtterance().onError,
        window.navigator.serviceWorker.onMessage,
      ];

      for (final s in streams) {
        final sub = s.listen((_) {});
        await sub.cancel();
      }

      final keyUp = window.onKeyUp.first;
      window.dispatchEvent(KeyboardEvent('keyup', KeyboardEventInit(key: 'x')));
      expect((await keyUp).key, equals('x'));

      final wheel = window.onWheel.first;
      window.dispatchEvent(WheelEvent('wheel', WheelEventInit(deltaY: 3)));
      expect((await wheel).deltaY, equals(3));
    });
  });

  group('misc', () {
    test('Window / console', () {
      expect(window.console, isNotNull);
    });

    test('DOMRect.toRectangle', () {
      expect(
        DOMRect(1, 2, 3, 4).toRectangle(),
        equals(const Rectangle<double>(1, 2, 3, 4)),
      );
    });

    test('CSSStyleDeclaration isEmpty', () {
      final style = HTMLDivElement().style;
      expect(style.isEmpty, isTrue);
      expect(style.isNotEmpty, isFalse);
      style.setProperty('color', 'blue');
      expect(style.isEmpty, isFalse);
    });

    test('jsEval', () {
      expect((jsEval('1 + 2'.toJS) as JSNumber).toDartInt, equals(3));
    });
  });
}
