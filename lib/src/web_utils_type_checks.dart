import 'package:js_interop_utils/js_interop_utils.dart';
import 'package:web/web.dart' as web;

extension JSObjectDOMTypeChecks on JSObject {
  bool get isNode => JSAnyDOMTypeChecks(this).isNode;

  bool get isElement => JSAnyDOMTypeChecks(this).isElement;

  bool get isHTMLElement => JSAnyDOMTypeChecks(this).isHTMLElement;

  bool get isHTMLDivElement => JSAnyDOMTypeChecks(this).isHTMLDivElement;

  bool get isHTMLImageElement => JSAnyDOMTypeChecks(this).isHTMLImageElement;

  bool get isHTMLInputElement => JSAnyDOMTypeChecks(this).isHTMLInputElement;

  bool get isHTMLAnchorElement => JSAnyDOMTypeChecks(this).isHTMLAnchorElement;

  bool get isHTMLSelectElement => JSAnyDOMTypeChecks(this).isHTMLSelectElement;

  bool get isHTMLTextAreaElement =>
      JSAnyDOMTypeChecks(this).isHTMLTextAreaElement;

  bool get isHTMLOptionElement => JSAnyDOMTypeChecks(this).isHTMLOptionElement;

  bool get isText => JSAnyDOMTypeChecks(this).isText;

  bool get isComment => JSAnyDOMTypeChecks(this).isComment;
}

extension JSObjectDOMTypeChecksNullable on JSObject? {
  bool get isNode => JSAnyDOMTypeChecksNullable(this).isNode;

  bool get isElement => JSAnyDOMTypeChecksNullable(this).isElement;

  bool get isHTMLElement => JSAnyDOMTypeChecksNullable(this).isHTMLElement;

  bool get isHTMLDivElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLDivElement;

  bool get isHTMLImageElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLImageElement;

  bool get isHTMLInputElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLInputElement;

  bool get isHTMLAnchorElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLAnchorElement;

  bool get isHTMLSelectElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLSelectElement;

  bool get isHTMLTextAreaElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLTextAreaElement;

  bool get isHTMLOptionElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLOptionElement;

  bool get isText => JSAnyDOMTypeChecksNullable(this).isText;

  bool get isComment => JSAnyDOMTypeChecksNullable(this).isComment;
}

extension JSAnyDOMTypeChecksNullable on JSAny? {
  bool get isNode {
    final self = this;
    return self == null ? false : self.isNode;
  }

  bool get isElement {
    final self = this;
    return self == null ? false : self.isElement;
  }

  bool get isHTMLElement {
    final self = this;
    return self == null ? false : self.isHTMLElement;
  }

  bool get isHTMLDivElement {
    final self = this;
    return self == null ? false : self.isHTMLDivElement;
  }

  bool get isHTMLImageElement {
    final self = this;
    return self == null ? false : self.isHTMLImageElement;
  }

  bool get isHTMLInputElement {
    final self = this;
    return self == null ? false : self.isHTMLInputElement;
  }

  bool get isHTMLAnchorElement {
    final self = this;
    return self == null ? false : self.isHTMLAnchorElement;
  }

  bool get isHTMLSelectElement {
    final self = this;
    return self == null ? false : self.isHTMLSelectElement;
  }

  bool get isHTMLTextAreaElement {
    final self = this;
    return self == null ? false : self.isHTMLTextAreaElement;
  }

  bool get isHTMLOptionElement {
    final self = this;
    return self == null ? false : self.isHTMLOptionElement;
  }

  bool get isText {
    final self = this;
    return self == null ? false : self.isText;
  }

  bool get isComment {
    final self = this;
    return self == null ? false : self.isComment;
  }
}

// Based on Martin Kustermann (mkustermann @ GitHub) implementation for Jaspr:
// https://github.com/mkustermann/jaspr/blob/23f9377ae2e2ddbbdb58c2f5de6a298990cc7208/packages/jaspr/lib/src/foundation/type_checks.dart
// https://github.com/mkustermann/jaspr/tree/main/packages/jaspr/lib/src/foundation/type_checks.dart

extension JSAnyDOMTypeChecks on JSAny {
  static bool _cachedDOMTypeChecks = true;

  static bool get cached => _cachedDOMTypeChecks;

  static set cached(bool cached) => _cachedDOMTypeChecks = cached;

  bool get isNode => _cachedDOMTypeChecks
      ? instanceof(_cachedNodeConstructor)
      : isA<web.Node>();

  bool get isElement => _cachedDOMTypeChecks
      ? instanceof(_cachedElementConstructor)
      : isA<web.Element>();

  bool get isHTMLElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlElementConstructor)
      : isA<web.HTMLElement>();

  bool get isHTMLDivElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlDivElementConstructor)
      : isA<web.HTMLDivElement>();

  bool get isHTMLImageElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlImageElementConstructor)
      : isA<web.HTMLImageElement>();

  bool get isHTMLInputElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlInputElementConstructor)
      : isA<web.HTMLInputElement>();

  bool get isHTMLAnchorElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlAnchorElementConstructor)
      : isA<web.HTMLAnchorElement>();

  bool get isHTMLSelectElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlSelectElementConstructor)
      : isA<web.HTMLSelectElement>();

  bool get isHTMLTextAreaElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlTextAreaElementConstructor)
      : isA<web.HTMLTextAreaElement>();

  bool get isHTMLOptionElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlOptionElementConstructor)
      : isA<web.HTMLOptionElement>();

  bool get isText => _cachedDOMTypeChecks
      ? instanceof(_cachedTextConstructor)
      : isA<web.Text>();

  bool get isComment => _cachedDOMTypeChecks
      ? instanceof(_cachedCommentConstructor)
      : isA<web.Comment>();
}

final _cachedNodeConstructor = _nodeConstructor;
final _cachedElementConstructor = _elementConstructor;
final _cachedHtmlElementConstructor = _htmlElementConstructor;
final _cachedHtmlDivElementConstructor = _htmlDivElementConstructor;
final _cachedHtmlImageElementConstructor = _htmlImageElementConstructor;
final _cachedHtmlInputElementConstructor = _htmlInputElementConstructor;
final _cachedHtmlAnchorElementConstructor = _htmlAnchorElementConstructor;
final _cachedHtmlSelectElementConstructor = _htmlSelectElementConstructor;
final _cachedHtmlTextAreaElementConstructor = _htmlTextAreaElementConstructor;
final _cachedHtmlOptionElementConstructor = _htmlOptionElementConstructor;
final _cachedTextConstructor = _textConstructor;
final _cachedCommentConstructor = _commentConstructor;

@JS('Node')
external JSFunction get _nodeConstructor;

@JS('Element')
external JSFunction get _elementConstructor;

@JS('HTMLElement')
external JSFunction get _htmlElementConstructor;

@JS('HTMLDivElement')
external JSFunction get _htmlDivElementConstructor;

@JS('HTMLImageElement')
external JSFunction get _htmlImageElementConstructor;

@JS('HTMLInputElement')
external JSFunction get _htmlInputElementConstructor;

@JS('HTMLAnchorElement')
external JSFunction get _htmlAnchorElementConstructor;

@JS('HTMLSelectElement')
external JSFunction get _htmlSelectElementConstructor;

@JS('HTMLTextAreaElement')
external JSFunction get _htmlTextAreaElementConstructor;

@JS('HTMLOptionElement')
external JSFunction get _htmlOptionElementConstructor;

@JS('Text')
external JSFunction get _textConstructor;

@JS('Comment')
external JSFunction get _commentConstructor;
