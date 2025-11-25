import 'dart:async';
import 'dart:math';

import 'package:js_interop_utils/js_interop_utils.dart';
import 'package:web/web.dart' as web;
import 'package:web/web.dart' hide querySelector;

import 'web_utils_type_checks.dart';

extension WebObjectExtension on Object? {
  bool get isNode => asJSAny.isNode;

  bool get isElement => asJSAny.isElement;

  bool get isHTMLElement => asJSAny.isHTMLElement;
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
  Element? select(String selectors) => querySelectorNonTyped(selectors);

  T? selectTyped<T extends Element>(String selectors, Web<T> webType) =>
      querySelectorTyped<T>(selectors, webType);

  List<Element> selectAll(String selectors) =>
      querySelectorAllNonTyped(selectors);

  List<T> selectAllTyped<T extends Element>(String selectors, Web<T> webType) =>
      querySelectorAllTyped(selectors, webType);

  Element? querySelectorNonTyped(String selectors) =>
      document.querySelector(selectors);

  T? querySelectorTyped<T extends Element>(String selectors, Web<T> webType) {
    var o = document.querySelector(selectors);
    return o?.asElementOfNullable<T>(webType);
  }

  List<Element> querySelectorAllNonTyped(String selectors) {
    return document.querySelectorAll(selectors).whereElement().toList();
  }

  List<T> querySelectorAllTyped<T extends Element>(
      String selectors, Web<T> webType) {
    var l = document.querySelectorAll(selectors).whereElement();
    return l.map((e) => e.asElementOfNullable<T>(webType)).nonNulls.toList();
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
  Node<web.Node>(_isNode, _castNode),
  // ignore: constant_identifier_names
  Text<web.Node>(_isText, _castText),
  // ignore: constant_identifier_names
  Element<web.Element>(_isElement, _castElement),
  // ignore: constant_identifier_names
  HTMLElement(_isHTMLElement, _castHTMLElement),
  // ignore: constant_identifier_names
  HTMLDivElement(_isHTMLDivElement, _castHTMLDivElement),
  // ignore: constant_identifier_names
  HTMLLinkElement(_isHTMLLinkElement, _castHTMLLinkElement),
  // ignore: constant_identifier_names
  HTMLButtonElement(_isHTMLButtonElement, _castHTMLButtonElement),
  // ignore: constant_identifier_names
  HTMLTextAreaElement(_isHTMLTextAreaElement, _castHTMLTextAreaElement),
  // ignore: constant_identifier_names
  HTMLInputElement(_isHTMLInputElement, _castHTMLInputElement),
  // ignore: constant_identifier_names
  HTMLSelectElement(_isHTMLSelectElement, _castHTMLSelectElement),
  // ignore: constant_identifier_names
  HTMLOptionElement(_isHTMLOptionElement, _castHTMLOptionElement),
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
  HTMLTableCellElement(_isHTMLTableCellElement, _castHTMLTableCellElement),
  // ignore: constant_identifier_names
  HTMLFormElement(_isHTMLFormElement, _castHTMLFormElement),
  // ignore: constant_identifier_names
  HTMLLabelElement(_isHTMLLabelElement, _castHTMLLabelElement),
  // ignore: constant_identifier_names
  HTMLParagraphElement(_isHTMLParagraphElement, _castHTMLParagraphElement),
  // ignore: constant_identifier_names
  HTMLHeadingElement(_isHTMLHeadingElement, _castHTMLHeadingElement),
  // ignore: constant_identifier_names
  HTMLUListElement(_isHTMLUListElement, _castHTMLUListElement),
  // ignore: constant_identifier_names
  HTMLOListElement(_isHTMLOListElement, _castHTMLOListElement),
  // ignore: constant_identifier_names
  HTMLLIElement(_isHTMLLIElement, _castHTMLLIElement),
  // ignore: constant_identifier_names
  HTMLIFrameElement(_isHTMLIFrameElement, _castHTMLIFrameElement),
  // ignore: constant_identifier_names
  HTMLMetaElement(_isHTMLMetaElement, _castHTMLMetaElement),
  // ignore: constant_identifier_names
  HTMLScriptElement(_isHTMLScriptElement, _castHTMLScriptElement),
  // ignore: constant_identifier_names
  HTMLStyleElement(_isHTMLStyleElement, _castHTMLStyleElement),
  // ignore: constant_identifier_names
  HTMLCanvasElement(_isHTMLCanvasElement, _castHTMLCanvasElement),
  // ignore: constant_identifier_names
  HTMLVideoElement(_isHTMLVideoElement, _castHTMLVideoElement),
  // ignore: constant_identifier_names
  HTMLAudioElement(_isHTMLAudioElement, _castHTMLAudioElement),
  // ignore: constant_identifier_names
  HTMLDialogElement(_isHTMLDialogElement, _castHTMLDialogElement),
  // ignore: constant_identifier_names
  HTMLOutputElement(_isHTMLOutputElement, _castHTMLOutputElement),
  // ignore: constant_identifier_names
  HTMLPictureElement(_isHTMLPictureElement, _castHTMLPictureElement),
  // ignore: constant_identifier_names
  HTMLSourceElement(_isHTMLSourceElement, _castHTMLSourceElement),
  // ignore: constant_identifier_names
  HTMLTrackElement(_isHTMLTrackElement, _castHTMLTrackElement),
  // ignore: constant_identifier_names
  HTMLTableCaptionElement(
      _isHTMLTableCaptionElement, _castHTMLTableCaptionElement),
  // ignore: constant_identifier_names
  HTMLTableColElement(_isHTMLTableColElement, _castHTMLTableColElement),
  // ignore: constant_identifier_names
  HTMLTableSectionElement(
      _isHTMLTableSectionElement, _castHTMLTableSectionElement),
  // ignore: constant_identifier_names
  Notification(_isNotification, _castNotification),
  ;

  /////////////////

  static bool get cachedDOMTypesChecks => JSAnyDOMTypeChecks.cached;

  static set cachedDOMTypesChecks(bool cached) =>
      JSAnyDOMTypeChecks.cached = cached;

  static bool _isNode(JSAny? o) => o.isNode;

  static web.Node? _castNode(JSAny? o) => o.isNode ? o as web.Node : null;

  static bool _isText(JSAny? o) => o.isText;

  static web.Text? _castText(JSAny? o) => o.isText ? o as web.Text : null;

  static bool _isElement(JSAny? o) => o.isElement;

  static web.Element? _castElement(JSAny? o) =>
      o.isElement ? o as web.Element : null;

  static bool _isHTMLElement(JSAny? o) => o.isHTMLElement;

  static web.HTMLElement? _castHTMLElement(JSAny? o) =>
      o.isHTMLElement ? o as web.HTMLElement : null;

  static bool _isHTMLDivElement(JSAny? o) => o.isHTMLDivElement;

  static web.HTMLDivElement? _castHTMLDivElement(JSAny? o) =>
      o.isHTMLDivElement ? o as web.HTMLDivElement : null;

  static bool _isHTMLLinkElement(JSAny? o) => o.isHTMLLinkElement;

  static web.HTMLLinkElement? _castHTMLLinkElement(JSAny? o) =>
      o.isHTMLLinkElement ? o as web.HTMLLinkElement : null;

  static bool _isHTMLButtonElement(JSAny? o) => o.isHTMLButtonElement;

  static web.HTMLButtonElement? _castHTMLButtonElement(JSAny? o) =>
      o.isHTMLButtonElement ? o as web.HTMLButtonElement : null;

  static bool _isHTMLTextAreaElement(JSAny? o) => o.isHTMLTextAreaElement;

  static web.HTMLTextAreaElement? _castHTMLTextAreaElement(JSAny? o) =>
      o.isHTMLTextAreaElement ? o as web.HTMLTextAreaElement : null;

  static bool _isHTMLInputElement(JSAny? o) => o.isHTMLInputElement;

  static web.HTMLInputElement? _castHTMLInputElement(JSAny? o) =>
      o.isHTMLInputElement ? o as web.HTMLInputElement : null;

  static bool _isHTMLSelectElement(JSAny? o) => o.isHTMLSelectElement;

  static web.HTMLSelectElement? _castHTMLSelectElement(JSAny? o) =>
      o.isHTMLSelectElement ? o as web.HTMLSelectElement : null;

  static bool _isHTMLOptionElement(JSAny? o) => o.isHTMLOptionElement;

  static web.HTMLOptionElement? _castHTMLOptionElement(JSAny? o) =>
      o.isHTMLOptionElement ? o as web.HTMLOptionElement : null;

  static bool _isHTMLAnchorElement(JSAny? o) => o.isHTMLAnchorElement;

  static web.HTMLAnchorElement? _castHTMLAnchorElement(JSAny? o) =>
      o.isHTMLAnchorElement ? o as web.HTMLAnchorElement : null;

  static bool _isHTMLImageElement(JSAny? o) => o.isHTMLImageElement;

  static web.HTMLImageElement? _castHTMLImageElement(JSAny? o) =>
      o.isHTMLImageElement ? o as web.HTMLImageElement : null;

  static bool _isHTMLSpanElement(JSAny? o) => o.isHTMLSpanElement;

  static web.HTMLSpanElement? _castHTMLSpanElement(JSAny? o) =>
      o.isHTMLSpanElement ? o as web.HTMLSpanElement : null;

  static bool _isHTMLTableElement(JSAny? o) => o.isHTMLTableElement;

  static web.HTMLTableElement? _castHTMLTableElement(JSAny? o) =>
      o.isHTMLTableElement ? o as web.HTMLTableElement : null;

  static bool _isHTMLTableRowElement(JSAny? o) => o.isHTMLTableRowElement;

  static web.HTMLTableRowElement? _castHTMLTableRowElement(JSAny? o) =>
      o.isHTMLTableRowElement ? o as web.HTMLTableRowElement : null;

  static bool _isHTMLTableCellElement(JSAny? o) => o.isHTMLTableCellElement;

  static web.HTMLTableCellElement? _castHTMLTableCellElement(JSAny? o) =>
      o.isHTMLTableCellElement ? o as web.HTMLTableCellElement : null;

  static bool _isHTMLFormElement(JSAny? o) => o.isHTMLFormElement;

  static web.HTMLFormElement? _castHTMLFormElement(JSAny? o) =>
      o.isHTMLFormElement ? o as web.HTMLFormElement : null;

  static bool _isHTMLLabelElement(JSAny? o) => o.isHTMLLabelElement;

  static web.HTMLLabelElement? _castHTMLLabelElement(JSAny? o) =>
      o.isHTMLLabelElement ? o as web.HTMLLabelElement : null;

  static bool _isHTMLParagraphElement(JSAny? o) => o.isHTMLParagraphElement;

  static web.HTMLParagraphElement? _castHTMLParagraphElement(JSAny? o) =>
      o.isHTMLParagraphElement ? o as web.HTMLParagraphElement : null;

  static bool _isHTMLHeadingElement(JSAny? o) => o.isHTMLHeadingElement;

  static web.HTMLHeadingElement? _castHTMLHeadingElement(JSAny? o) =>
      o.isHTMLHeadingElement ? o as web.HTMLHeadingElement : null;

  static bool _isHTMLUListElement(JSAny? o) => o.isHTMLUListElement;

  static web.HTMLUListElement? _castHTMLUListElement(JSAny? o) =>
      o.isHTMLUListElement ? o as web.HTMLUListElement : null;

  static bool _isHTMLOListElement(JSAny? o) => o.isHTMLOListElement;

  static web.HTMLOListElement? _castHTMLOListElement(JSAny? o) =>
      o.isHTMLOListElement ? o as web.HTMLOListElement : null;

  static bool _isHTMLLIElement(JSAny? o) => o.isHTMLLIElement;

  static web.HTMLLIElement? _castHTMLLIElement(JSAny? o) =>
      o.isHTMLLIElement ? o as web.HTMLLIElement : null;

  static bool _isHTMLIFrameElement(JSAny? o) => o.isHTMLIFrameElement;

  static web.HTMLIFrameElement? _castHTMLIFrameElement(JSAny? o) =>
      o.isHTMLIFrameElement ? o as web.HTMLIFrameElement : null;

  static bool _isHTMLMetaElement(JSAny? o) => o.isHTMLMetaElement;

  static web.HTMLMetaElement? _castHTMLMetaElement(JSAny? o) =>
      o.isHTMLMetaElement ? o as web.HTMLMetaElement : null;

  static bool _isHTMLScriptElement(JSAny? o) => o.isHTMLScriptElement;

  static web.HTMLScriptElement? _castHTMLScriptElement(JSAny? o) =>
      o.isHTMLScriptElement ? o as web.HTMLScriptElement : null;

  static bool _isHTMLStyleElement(JSAny? o) => o.isHTMLStyleElement;

  static web.HTMLStyleElement? _castHTMLStyleElement(JSAny? o) =>
      o.isHTMLStyleElement ? o as web.HTMLStyleElement : null;

  static bool _isHTMLCanvasElement(JSAny? o) => o.isHTMLCanvasElement;

  static web.HTMLCanvasElement? _castHTMLCanvasElement(JSAny? o) =>
      o.isHTMLCanvasElement ? o as web.HTMLCanvasElement : null;

  static bool _isHTMLVideoElement(JSAny? o) => o.isHTMLVideoElement;

  static web.HTMLVideoElement? _castHTMLVideoElement(JSAny? o) =>
      o.isHTMLVideoElement ? o as web.HTMLVideoElement : null;

  static bool _isHTMLAudioElement(JSAny? o) => o.isHTMLAudioElement;

  static web.HTMLAudioElement? _castHTMLAudioElement(JSAny? o) =>
      o.isHTMLAudioElement ? o as web.HTMLAudioElement : null;

  static bool _isHTMLDialogElement(JSAny? o) => o.isHTMLDialogElement;

  static web.HTMLDialogElement? _castHTMLDialogElement(JSAny? o) =>
      o.isHTMLDialogElement ? o as web.HTMLDialogElement : null;

  static bool _isHTMLOutputElement(JSAny? o) => o.isHTMLOutputElement;

  static web.HTMLOutputElement? _castHTMLOutputElement(JSAny? o) =>
      o.isHTMLOutputElement ? o as web.HTMLOutputElement : null;

  static bool _isHTMLPictureElement(JSAny? o) => o.isHTMLPictureElement;

  static web.HTMLPictureElement? _castHTMLPictureElement(JSAny? o) =>
      o.isHTMLPictureElement ? o as web.HTMLPictureElement : null;

  static bool _isHTMLSourceElement(JSAny? o) => o.isHTMLSourceElement;

  static web.HTMLSourceElement? _castHTMLSourceElement(JSAny? o) =>
      o.isHTMLSourceElement ? o as web.HTMLSourceElement : null;

  static bool _isHTMLTrackElement(JSAny? o) => o.isHTMLTrackElement;

  static web.HTMLTrackElement? _castHTMLTrackElement(JSAny? o) =>
      o.isHTMLTrackElement ? o as web.HTMLTrackElement : null;

  static bool _isHTMLTableCaptionElement(JSAny? o) =>
      o.isHTMLTableCaptionElement;

  static web.HTMLTableCaptionElement? _castHTMLTableCaptionElement(JSAny? o) =>
      o.isHTMLTableCaptionElement ? o as web.HTMLTableCaptionElement : null;

  static bool _isHTMLTableColElement(JSAny? o) => o.isHTMLTableColElement;

  static web.HTMLTableColElement? _castHTMLTableColElement(JSAny? o) =>
      o.isHTMLTableColElement ? o as web.HTMLTableColElement : null;

  static bool _isHTMLTableSectionElement(JSAny? o) =>
      o.isHTMLTableSectionElement;

  static web.HTMLTableSectionElement? _castHTMLTableSectionElement(JSAny? o) =>
      o.isHTMLTableSectionElement ? o as web.HTMLTableSectionElement : null;

  static bool _isNotification(JSAny? o) => o.isA<web.Notification>();

  static web.Notification? _castNotification(JSAny? o) =>
      o.isA<web.Notification>() ? o as web.Notification : null;

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

  bool get isSupported {
    switch (this) {
      case Notification:
        return window['Notification'].isDefinedAndNotNull;
      default:
        return window[name].isDefinedAndNotNull;
    }
  }
}

extension ElementNullableExtension on Element? {
  HTMLElement? get asHTMLElement =>
      isA<HTMLElement>() ? this as HTMLElement : null;

  bool isElementOf<T extends Element>(Web<T> webType) => webType.isOf(this);

  T asElementOf<T extends Element>(Web<T> webType) => webType.cast(this);

  T? asElementOfNullable<T extends Element>(Web<T> webType) =>
      webType.castNullable(this);

  bool get isCanvasImageSource {
    final node = this;
    if (node == null) return false;
    return node.isA<HTMLImageElement>() ||
        node.isA<HTMLCanvasElement>() ||
        node.isA<HTMLVideoElement>();
  }
}

extension ElementExtension on Element {
  DOMTokenList? get classes => classList;

  String? get text => textContent?.toDartFix;

  set text(String? text) => textContent = text;

  HTMLElement get asHTMLElement => this as HTMLElement;

  HTMLElement? get asHTMLElementChecked =>
      isA<HTMLElement>() ? this as HTMLElement : null;

  /// Alias to [Element.querySelector].
  Element? select(String selectors) => querySelectorNonTyped(selectors);

  /// Alias to [Element.querySelector].
  Element? querySelectorNonTyped(String selectors) {
    var self = this;
    return self.querySelector(selectors);
  }

  /// Alias to [Element.querySelector] filtering by [webType] and casting to [T].
  T? selectTyped<T extends Element>(String selectors, Web<T> webType) =>
      querySelectorTyped(selectors, webType);

  /// Alias to [Element.querySelector] filtering by [webType] and casting to [T].
  T? querySelectorTyped<T extends Element>(String selectors, Web<T> webType) {
    var self = this;
    var elem = self.querySelector(selectors);
    return elem.isElementOf<T>(webType) ? elem as T : null;
  }

  /// Alias to [querySelectorAll].
  List<Element> selectAll(String selectors) =>
      querySelectorAllNonTyped(selectors);

  /// Alias to [querySelectorAll].
  List<Element> querySelectorAllNonTyped(String selectors) {
    var self = this;
    return self.querySelectorAll(selectors).whereElement().toList();
  }

  /// Alias to [querySelectorAll] filtering by [webType] and casting elements to [T].
  List<T> selectAllTyped<T extends Element>(String selectors, Web<T> webType) =>
      querySelectorAllTyped(selectors, webType);

  /// Alias to [querySelectorAll] filtering by [webType] and casting elements to [T].
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

  CSSStyleDeclaration? get style {
    if (isA<HTMLElement>()) {
      var htmlElement = this as HTMLElement;
      return htmlElement.style;
    } else if (isA<SVGElement>()) {
      var svgElement = this as SVGElement;
      return svgElement.style;
    } else if (isA<MathMLElement>()) {
      var mathMlElement = this as MathMLElement;
      return mathMlElement.style;
    }
    return null;
  }

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
  DOMTokenList get classes => classList;

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

  Attr? getAttribute(String key, {String? ns}) {
    if (ns != null) {
      return getNamedItemNS(ns, key);
    } else {
      return getNamedItem(key);
    }
  }

  bool containsAttribute(String key, {String? ns}) =>
      getAttribute(key, ns: ns) != null;

  String? getAttributeValue(String key, {String? ns}) =>
      getAttribute(key, ns: ns)?.value;
}

extension HTMLCollectionExtension on HTMLCollection {
  Iterable<Element> toIterable() => Iterable.generate(length, (i) => item(i)!);

  List<Element> toList() => List.generate(length, (i) => item(i)!);

  Iterable<T> whereType<T>() => toIterable().whereType<T>();

  bool get isEmpty => length == 0;

  bool get isNotEmpty => !isEmpty;

  int indexOf(Element element) {
    final length = this.length;

    for (var i = 0; i < length; ++i) {
      var e = item(i);
      if (e == element) {
        return i;
      }
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
    final length = this.length;

    for (var i = 0; i < length; ++i) {
      var e = item(i);
      if (e == node) {
        return i;
      }
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

extension HTMLCanvasElementExtension on HTMLCanvasElement {
  String toDataUrlPNG() => toDataUrl('image/png');

  String toDataUrlJPEG() => toDataUrl('image/jpeg');

  String toDataUrlWEBP() => toDataUrl('image/webp');

  Future<Blob> asBlob({String? type, double? quality}) async {
    var completer = Completer<Blob>();

    var callback = (Blob blob) {
      completer.complete(blob);
    }.toJS;

    if (quality != null) {
      type ??= 'image/png';
      toBlob(callback, type, quality.toJS);
    } else if (type != null) {
      toBlob(callback, type);
    } else {
      toBlob(callback);
    }

    return completer.future;
  }
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
      } else {
        if (cursor.isA<IDBCursor>()) {
          // ignore: invalid_runtime_check_with_js_interop_types
          var iDBCursor = cursor as IDBCursor;
          iDBCursor.continue_();
        }
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

  Stream<Event> get onOnline =>
      EventStreamProviders.onlineEvent.forTarget(this);

  Stream<Event> get onOffline =>
      EventStreamProviders.offlineEvent.forTarget(this);

  Stream<KeyboardEvent> get onKeyUp =>
      EventStreamProviders.keyUpEvent.forTarget(this);

  Stream<MouseEvent> get onClick =>
      EventStreamProviders.clickEvent.forTarget(this);

  Stream<MouseEvent> get onMouseDown =>
      EventStreamProviders.mouseDownEvent.forTarget(this);

  Stream<MouseEvent> get onMouseUp =>
      EventStreamProviders.mouseUpEvent.forTarget(this);

  Stream<MouseEvent> get onMouseMove =>
      EventStreamProviders.mouseMoveEvent.forTarget(this);

  Stream<WheelEvent> get onWheel =>
      EventStreamProviders.wheelEvent.forTarget(this);

  Stream<Event> get onScroll =>
      EventStreamProviders.scrollEvent.forTarget(this);

  Stream<Event> get onFocus => EventStreamProviders.focusEvent.forTarget(this);

  Stream<Event> get onBlur => EventStreamProviders.blurEvent.forTarget(this);

  Stream<Event> get onBeforeUnload =>
      EventStreamProviders.beforeUnloadEvent.forTarget(this);

  Stream<StorageEvent> get onStorage =>
      EventStreamProviders.storageEvent.forTarget(this);

  Stream<DeviceMotionEvent> get onDeviceMotion =>
      EventStreamProviders.deviceMotionEvent.forTarget(this);

  Stream<TouchEvent> get onTouchEnd =>
      EventStreamProviders.touchEndEvent.forTarget(this);

  Stream<TouchEvent> get onTouchCancel =>
      EventStreamProviders.touchCancelEvent.forTarget(this);
}

extension SpeechSynthesisUtteranceExtension on SpeechSynthesisUtterance {
  Stream<SpeechSynthesisEvent> get onEnd =>
      EventStreamProviders.endEvent.forTarget(this);

  Stream<SpeechSynthesisEvent> get onStart =>
      EventStreamProviders.startEvent.forTarget(this);

  Stream<Event> get onPause => EventStreamProviders.pauseEvent.forTarget(this);

  Stream<SpeechSynthesisEvent> get onResume =>
      EventStreamProviders.resumeEvent.forTarget(this);

  Stream<SpeechSynthesisEvent> get onBoundary =>
      EventStreamProviders.boundaryEvent.forTarget(this);

  Stream<SpeechSynthesisEvent> get onMark =>
      EventStreamProviders.markEvent.forTarget(this);

  Stream<Event> get onError =>
      EventStreamProviders.errorSpeechSynthesisUtteranceEvent.forTarget(this);
}

extension ServiceWorkerContainerExtension on ServiceWorkerContainer {
  Stream<MessageEvent> get onMessage =>
      EventStreamProviders.messageEvent.forTarget(this);
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

extension GeolocationExtension on Geolocation {
  Stream<GeolocationPosition> watchGeolocationPosition({
    bool enableHighAccuracy = true,
    Duration timeout = const Duration(seconds: 15),
    Duration maximumAge = const Duration(minutes: 5),
  }) {
    final controller = StreamController<GeolocationPosition>();

    final watchId = watchPosition(
      (GeolocationPosition geoPos) {
        controller.add(geoPos);
      }.toJS,
      (GeolocationPositionError geoPosError) {
        controller.addError(geoPosError);
      }.toJS,
      PositionOptions(
          enableHighAccuracy: enableHighAccuracy,
          timeout: timeout.inMilliseconds,
          maximumAge: maximumAge.inMilliseconds),
    );

    controller.onCancel = () {
      clearWatch(watchId);
    };

    var stream = controller.stream;
    return stream;
  }

  Future<GeolocationPosition> getCurrentGeolocationPosition({
    bool enableHighAccuracy = true,
    Duration timeout = const Duration(seconds: 15),
    Duration maximumAge = const Duration(minutes: 5),
  }) {
    var completer = Completer<GeolocationPosition>();

    getCurrentPosition(
      (GeolocationPosition geoPos) {
        completer.completeSafe(geoPos);
      }.toJS,
      (GeolocationPositionError geoPosError) {
        completer.completeErrorSafe(geoPosError);
      }.toJS,
      PositionOptions(
          enableHighAccuracy: enableHighAccuracy,
          timeout: timeout.inMilliseconds,
          maximumAge: maximumAge.inMilliseconds),
    );

    return completer.future;
  }
}

extension KeyboardEventExtension on KeyboardEvent {
  /// Safe access to legacy `keyCode` (may throw in some browsers).
  int? get keyCodeSafe {
    try {
      return keyCode;
    } catch (_) {
      return null;
    }
  }

  /// Normalized [key] as lower-case.
  String get keyLC => key.toLowerCase();

  /// Generic matcher: modern `key` first, fallback to legacy `keyCode`.
  bool _match(String name, int code) {
    if (keyLC == name) return true;
    return keyCodeSafe == code;
  }

  // ---- Individual Key Checks ----

  bool get isKeyTab => _match('tab', 9);

  bool get isKeyEnter => _match('enter', 13);

  bool get isKeySpace =>
      _match(' ', 32) || _match('space', 32) || _match('spacebar', 32);

  bool get isKeyEscape => _match('escape', 27) || _match('esc', 27);

  bool get isArrowUp => _match('arrowup', 38);

  bool get isArrowDown => _match('arrowdown', 40);

  bool get isArrowLeft => _match('arrowleft', 37);

  bool get isArrowRight => _match('arrowright', 39);

  // ---- Grouped Checks ----

  bool get isKeyTabOrEnter => isKeyTab || isKeyEnter;

  bool get isArrowKey =>
      isArrowUp || isArrowDown || isArrowLeft || isArrowRight;

  bool get isNavigationKey => isKeyTabOrEnter || isArrowKey || isKeyEscape;
}
