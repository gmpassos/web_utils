import 'package:js_interop_utils/js_interop_utils.dart';
import 'package:web/web.dart' as web;

extension JSObjectDOMTypeChecks on JSObject {
  bool get isNode => JSAnyDOMTypeChecks(this).isNode;

  bool get isElement => JSAnyDOMTypeChecks(this).isElement;

  bool get isHTMLElement => JSAnyDOMTypeChecks(this).isHTMLElement;

  bool get isHTMLDivElement => JSAnyDOMTypeChecks(this).isHTMLDivElement;

  bool get isHTMLLinkElement => JSAnyDOMTypeChecks(this).isHTMLLinkElement;

  bool get isHTMLButtonElement => JSAnyDOMTypeChecks(this).isHTMLButtonElement;

  bool get isHTMLTextAreaElement =>
      JSAnyDOMTypeChecks(this).isHTMLTextAreaElement;

  bool get isHTMLInputElement => JSAnyDOMTypeChecks(this).isHTMLInputElement;

  bool get isHTMLSelectElement => JSAnyDOMTypeChecks(this).isHTMLSelectElement;

  bool get isHTMLOptionElement => JSAnyDOMTypeChecks(this).isHTMLOptionElement;

  bool get isHTMLAnchorElement => JSAnyDOMTypeChecks(this).isHTMLAnchorElement;

  bool get isHTMLImageElement => JSAnyDOMTypeChecks(this).isHTMLImageElement;

  bool get isHTMLSpanElement => JSAnyDOMTypeChecks(this).isHTMLSpanElement;

  bool get isHTMLTableElement => JSAnyDOMTypeChecks(this).isHTMLTableElement;

  bool get isHTMLTableRowElement =>
      JSAnyDOMTypeChecks(this).isHTMLTableRowElement;

  bool get isHTMLTableCellElement =>
      JSAnyDOMTypeChecks(this).isHTMLTableCellElement;

  bool get isHTMLFormElement => JSAnyDOMTypeChecks(this).isHTMLFormElement;

  bool get isHTMLLabelElement => JSAnyDOMTypeChecks(this).isHTMLLabelElement;

  bool get isHTMLParagraphElement =>
      JSAnyDOMTypeChecks(this).isHTMLParagraphElement;

  bool get isHTMLHeadingElement =>
      JSAnyDOMTypeChecks(this).isHTMLHeadingElement;

  bool get isHTMLUListElement => JSAnyDOMTypeChecks(this).isHTMLUListElement;

  bool get isHTMLOListElement => JSAnyDOMTypeChecks(this).isHTMLOListElement;

  bool get isHTMLLIElement => JSAnyDOMTypeChecks(this).isHTMLLIElement;

  bool get isHTMLIFrameElement => JSAnyDOMTypeChecks(this).isHTMLIFrameElement;

  bool get isHTMLMetaElement => JSAnyDOMTypeChecks(this).isHTMLMetaElement;

  bool get isHTMLScriptElement => JSAnyDOMTypeChecks(this).isHTMLScriptElement;

  bool get isHTMLStyleElement => JSAnyDOMTypeChecks(this).isHTMLStyleElement;

  bool get isHTMLCanvasElement => JSAnyDOMTypeChecks(this).isHTMLCanvasElement;

  bool get isHTMLVideoElement => JSAnyDOMTypeChecks(this).isHTMLVideoElement;

  bool get isHTMLAudioElement => JSAnyDOMTypeChecks(this).isHTMLAudioElement;

  bool get isHTMLDialogElement => JSAnyDOMTypeChecks(this).isHTMLDialogElement;

  bool get isHTMLOutputElement => JSAnyDOMTypeChecks(this).isHTMLOutputElement;

  bool get isHTMLPictureElement =>
      JSAnyDOMTypeChecks(this).isHTMLPictureElement;

  bool get isHTMLSourceElement => JSAnyDOMTypeChecks(this).isHTMLSourceElement;

  bool get isHTMLTrackElement => JSAnyDOMTypeChecks(this).isHTMLTrackElement;

  bool get isHTMLTableCaptionElement =>
      JSAnyDOMTypeChecks(this).isHTMLTableCaptionElement;

  bool get isHTMLTableColElement =>
      JSAnyDOMTypeChecks(this).isHTMLTableColElement;

  bool get isHTMLTableSectionElement =>
      JSAnyDOMTypeChecks(this).isHTMLTableSectionElement;

  bool get isText => JSAnyDOMTypeChecks(this).isText;

  bool get isComment => JSAnyDOMTypeChecks(this).isComment;
}

extension JSObjectDOMTypeChecksNullable on JSObject? {
  bool get isNode => JSAnyDOMTypeChecksNullable(this).isNode;

  bool get isElement => JSAnyDOMTypeChecksNullable(this).isElement;

  bool get isHTMLElement => JSAnyDOMTypeChecksNullable(this).isHTMLElement;

  bool get isHTMLDivElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLDivElement;

  bool get isHTMLLinkElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLLinkElement;

  bool get isHTMLButtonElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLButtonElement;

  bool get isHTMLTextAreaElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLTextAreaElement;

  bool get isHTMLInputElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLInputElement;

  bool get isHTMLSelectElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLSelectElement;

  bool get isHTMLOptionElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLOptionElement;

  bool get isHTMLAnchorElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLAnchorElement;

  bool get isHTMLImageElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLImageElement;

  bool get isHTMLSpanElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLSpanElement;

  bool get isHTMLTableElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLTableElement;

  bool get isHTMLTableRowElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLTableRowElement;

  bool get isHTMLTableCellElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLTableCellElement;

  bool get isHTMLFormElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLFormElement;

  bool get isHTMLLabelElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLLabelElement;

  bool get isHTMLParagraphElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLParagraphElement;

  bool get isHTMLHeadingElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLHeadingElement;

  bool get isHTMLUListElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLUListElement;

  bool get isHTMLOListElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLOListElement;

  bool get isHTMLLIElement => JSAnyDOMTypeChecksNullable(this).isHTMLLIElement;

  bool get isHTMLIFrameElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLIFrameElement;

  bool get isHTMLMetaElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLMetaElement;

  bool get isHTMLScriptElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLScriptElement;

  bool get isHTMLStyleElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLStyleElement;

  bool get isHTMLCanvasElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLCanvasElement;

  bool get isHTMLVideoElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLVideoElement;

  bool get isHTMLAudioElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLAudioElement;

  bool get isHTMLDialogElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLDialogElement;

  bool get isHTMLOutputElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLOutputElement;

  bool get isHTMLPictureElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLPictureElement;

  bool get isHTMLSourceElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLSourceElement;

  bool get isHTMLTrackElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLTrackElement;

  bool get isHTMLTableCaptionElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLTableCaptionElement;

  bool get isHTMLTableColElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLTableColElement;

  bool get isHTMLTableSectionElement =>
      JSAnyDOMTypeChecksNullable(this).isHTMLTableSectionElement;

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

  bool get isHTMLLinkElement {
    final self = this;
    return self == null ? false : self.isHTMLLinkElement;
  }

  bool get isHTMLButtonElement {
    final self = this;
    return self == null ? false : self.isHTMLButtonElement;
  }

  bool get isHTMLTextAreaElement {
    final self = this;
    return self == null ? false : self.isHTMLTextAreaElement;
  }

  bool get isHTMLInputElement {
    final self = this;
    return self == null ? false : self.isHTMLInputElement;
  }

  bool get isHTMLSelectElement {
    final self = this;
    return self == null ? false : self.isHTMLSelectElement;
  }

  bool get isHTMLOptionElement {
    final self = this;
    return self == null ? false : self.isHTMLOptionElement;
  }

  bool get isHTMLAnchorElement {
    final self = this;
    return self == null ? false : self.isHTMLAnchorElement;
  }

  bool get isHTMLImageElement {
    final self = this;
    return self == null ? false : self.isHTMLImageElement;
  }

  bool get isHTMLSpanElement {
    final self = this;
    return self == null ? false : self.isHTMLSpanElement;
  }

  bool get isHTMLTableElement {
    final self = this;
    return self == null ? false : self.isHTMLTableElement;
  }

  bool get isHTMLTableRowElement {
    final self = this;
    return self == null ? false : self.isHTMLTableRowElement;
  }

  bool get isHTMLTableCellElement {
    final self = this;
    return self == null ? false : self.isHTMLTableCellElement;
  }

  bool get isHTMLFormElement {
    final self = this;
    return self == null ? false : self.isHTMLFormElement;
  }

  bool get isHTMLLabelElement {
    final self = this;
    return self == null ? false : self.isHTMLLabelElement;
  }

  bool get isHTMLParagraphElement {
    final self = this;
    return self == null ? false : self.isHTMLParagraphElement;
  }

  bool get isHTMLHeadingElement {
    final self = this;
    return self == null ? false : self.isHTMLHeadingElement;
  }

  bool get isHTMLUListElement {
    final self = this;
    return self == null ? false : self.isHTMLUListElement;
  }

  bool get isHTMLOListElement {
    final self = this;
    return self == null ? false : self.isHTMLOListElement;
  }

  bool get isHTMLLIElement {
    final self = this;
    return self == null ? false : self.isHTMLLIElement;
  }

  bool get isHTMLIFrameElement {
    final self = this;
    return self == null ? false : self.isHTMLIFrameElement;
  }

  bool get isHTMLMetaElement {
    final self = this;
    return self == null ? false : self.isHTMLMetaElement;
  }

  bool get isHTMLScriptElement {
    final self = this;
    return self == null ? false : self.isHTMLScriptElement;
  }

  bool get isHTMLStyleElement {
    final self = this;
    return self == null ? false : self.isHTMLStyleElement;
  }

  bool get isHTMLCanvasElement {
    final self = this;
    return self == null ? false : self.isHTMLCanvasElement;
  }

  bool get isHTMLVideoElement {
    final self = this;
    return self == null ? false : self.isHTMLVideoElement;
  }

  bool get isHTMLAudioElement {
    final self = this;
    return self == null ? false : self.isHTMLAudioElement;
  }

  bool get isHTMLDialogElement {
    final self = this;
    return self == null ? false : self.isHTMLDialogElement;
  }

  bool get isHTMLOutputElement {
    final self = this;
    return self == null ? false : self.isHTMLOutputElement;
  }

  bool get isHTMLPictureElement {
    final self = this;
    return self == null ? false : self.isHTMLPictureElement;
  }

  bool get isHTMLSourceElement {
    final self = this;
    return self == null ? false : self.isHTMLSourceElement;
  }

  bool get isHTMLTrackElement {
    final self = this;
    return self == null ? false : self.isHTMLTrackElement;
  }

  bool get isHTMLTableCaptionElement {
    final self = this;
    return self == null ? false : self.isHTMLTableCaptionElement;
  }

  bool get isHTMLTableColElement {
    final self = this;
    return self == null ? false : self.isHTMLTableColElement;
  }

  bool get isHTMLTableSectionElement {
    final self = this;
    return self == null ? false : self.isHTMLTableSectionElement;
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

  bool get isHTMLLinkElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlLinkElementConstructor)
      : isA<web.HTMLLinkElement>();

  bool get isHTMLButtonElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlButtonElementConstructor)
      : isA<web.HTMLButtonElement>();

  bool get isHTMLTextAreaElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlTextAreaElementConstructor)
      : isA<web.HTMLTextAreaElement>();

  bool get isHTMLInputElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlInputElementConstructor)
      : isA<web.HTMLInputElement>();

  bool get isHTMLSelectElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlSelectElementConstructor)
      : isA<web.HTMLSelectElement>();

  bool get isHTMLOptionElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlOptionElementConstructor)
      : isA<web.HTMLOptionElement>();

  bool get isHTMLAnchorElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlAnchorElementConstructor)
      : isA<web.HTMLAnchorElement>();

  bool get isHTMLImageElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlImageElementConstructor)
      : isA<web.HTMLImageElement>();

  bool get isHTMLSpanElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlSpanElementConstructor)
      : isA<web.HTMLSpanElement>();

  bool get isHTMLTableElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlTableElementConstructor)
      : isA<web.HTMLTableElement>();

  bool get isHTMLTableRowElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlTableRowElementConstructor)
      : isA<web.HTMLTableRowElement>();

  bool get isHTMLTableCellElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlTableCellElementConstructor)
      : isA<web.HTMLTableCellElement>();

  bool get isHTMLFormElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlFormElementConstructor)
      : isA<web.HTMLFormElement>();

  bool get isHTMLLabelElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlLabelElementConstructor)
      : isA<web.HTMLLabelElement>();

  bool get isHTMLParagraphElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlParagraphElementConstructor)
      : isA<web.HTMLParagraphElement>();

  bool get isHTMLHeadingElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlHeadingElementConstructor)
      : isA<web.HTMLHeadingElement>();

  bool get isHTMLUListElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlUListElementConstructor)
      : isA<web.HTMLUListElement>();

  bool get isHTMLOListElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlOListElementConstructor)
      : isA<web.HTMLOListElement>();

  bool get isHTMLLIElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlLIElementConstructor)
      : isA<web.HTMLLIElement>();

  bool get isHTMLIFrameElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlIFrameElementConstructor)
      : isA<web.HTMLIFrameElement>();

  bool get isHTMLMetaElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlMetaElementConstructor)
      : isA<web.HTMLMetaElement>();

  bool get isHTMLScriptElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlScriptElementConstructor)
      : isA<web.HTMLScriptElement>();

  bool get isHTMLStyleElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlStyleElementConstructor)
      : isA<web.HTMLStyleElement>();

  bool get isHTMLCanvasElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlCanvasElementConstructor)
      : isA<web.HTMLCanvasElement>();

  bool get isHTMLVideoElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlVideoElementConstructor)
      : isA<web.HTMLVideoElement>();

  bool get isHTMLAudioElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlAudioElementConstructor)
      : isA<web.HTMLAudioElement>();

  bool get isHTMLDialogElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlDialogElementConstructor)
      : isA<web.HTMLDialogElement>();

  bool get isHTMLOutputElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlOutputElementConstructor)
      : isA<web.HTMLOutputElement>();

  bool get isHTMLPictureElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlPictureElementConstructor)
      : isA<web.HTMLPictureElement>();

  bool get isHTMLSourceElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlSourceElementConstructor)
      : isA<web.HTMLSourceElement>();

  bool get isHTMLTrackElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlTrackElementConstructor)
      : isA<web.HTMLTrackElement>();

  bool get isHTMLTableCaptionElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlTableCaptionElementConstructor)
      : isA<web.HTMLTableCaptionElement>();

  bool get isHTMLTableColElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlTableColElementConstructor)
      : isA<web.HTMLTableColElement>();

  bool get isHTMLTableSectionElement => _cachedDOMTypeChecks
      ? instanceof(_cachedHtmlTableSectionElementConstructor)
      : isA<web.HTMLTableSectionElement>();

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
final _cachedHtmlLinkElementConstructor = _htmlLinkElementConstructor;
final _cachedHtmlButtonElementConstructor = _htmlButtonElementConstructor;
final _cachedHtmlTextAreaElementConstructor = _htmlTextAreaElementConstructor;
final _cachedHtmlInputElementConstructor = _htmlInputElementConstructor;
final _cachedHtmlSelectElementConstructor = _htmlSelectElementConstructor;
final _cachedHtmlOptionElementConstructor = _htmlOptionElementConstructor;
final _cachedHtmlAnchorElementConstructor = _htmlAnchorElementConstructor;
final _cachedHtmlImageElementConstructor = _htmlImageElementConstructor;
final _cachedHtmlSpanElementConstructor = _htmlSpanElementConstructor;
final _cachedHtmlTableElementConstructor = _htmlTableElementConstructor;
final _cachedHtmlTableRowElementConstructor = _htmlTableRowElementConstructor;
final _cachedHtmlTableCellElementConstructor = _htmlTableCellElementConstructor;
final _cachedHtmlFormElementConstructor = _htmlFormElementConstructor;
final _cachedHtmlLabelElementConstructor = _htmlLabelElementConstructor;
final _cachedHtmlParagraphElementConstructor = _htmlParagraphElementConstructor;
final _cachedHtmlHeadingElementConstructor = _htmlHeadingElementConstructor;
final _cachedHtmlUListElementConstructor = _htmlUListElementConstructor;
final _cachedHtmlOListElementConstructor = _htmlOListElementConstructor;
final _cachedHtmlLIElementConstructor = _htmlLIElementConstructor;
final _cachedHtmlIFrameElementConstructor = _htmlIFrameElementConstructor;
final _cachedHtmlMetaElementConstructor = _htmlMetaElementConstructor;
final _cachedHtmlScriptElementConstructor = _htmlScriptElementConstructor;
final _cachedHtmlStyleElementConstructor = _htmlStyleElementConstructor;
final _cachedHtmlCanvasElementConstructor = _htmlCanvasElementConstructor;
final _cachedHtmlVideoElementConstructor = _htmlVideoElementConstructor;
final _cachedHtmlAudioElementConstructor = _htmlAudioElementConstructor;
final _cachedHtmlDialogElementConstructor = _htmlDialogElementConstructor;
final _cachedHtmlOutputElementConstructor = _htmlOutputElementConstructor;
final _cachedHtmlPictureElementConstructor = _htmlPictureElementConstructor;
final _cachedHtmlSourceElementConstructor = _htmlSourceElementConstructor;
final _cachedHtmlTrackElementConstructor = _htmlTrackElementConstructor;
final _cachedHtmlTableCaptionElementConstructor =
    _htmlTableCaptionElementConstructor;
final _cachedHtmlTableColElementConstructor = _htmlTableColElementConstructor;
final _cachedHtmlTableSectionElementConstructor =
    _htmlTableSectionElementConstructor;
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

@JS('HTMLLinkElement')
external JSFunction get _htmlLinkElementConstructor;

@JS('HTMLButtonElement')
external JSFunction get _htmlButtonElementConstructor;

@JS('HTMLTextAreaElement')
external JSFunction get _htmlTextAreaElementConstructor;

@JS('HTMLInputElement')
external JSFunction get _htmlInputElementConstructor;

@JS('HTMLAnchorElement')
external JSFunction get _htmlAnchorElementConstructor;

@JS('HTMLImageElement')
external JSFunction get _htmlImageElementConstructor;

@JS('HTMLSelectElement')
external JSFunction get _htmlSelectElementConstructor;

@JS('HTMLOptionElement')
external JSFunction get _htmlOptionElementConstructor;

@JS('HTMLSpanElement')
external JSFunction get _htmlSpanElementConstructor;

@JS('HTMLTableElement')
external JSFunction get _htmlTableElementConstructor;

@JS('HTMLTableRowElement')
external JSFunction get _htmlTableRowElementConstructor;

@JS('HTMLTableCellElement')
external JSFunction get _htmlTableCellElementConstructor;

@JS('HTMLFormElement')
external JSFunction get _htmlFormElementConstructor;

@JS('HTMLLabelElement')
external JSFunction get _htmlLabelElementConstructor;

@JS('HTMLParagraphElement')
external JSFunction get _htmlParagraphElementConstructor;

@JS('HTMLHeadingElement')
external JSFunction get _htmlHeadingElementConstructor;

@JS('HTMLUListElement')
external JSFunction get _htmlUListElementConstructor;

@JS('HTMLOListElement')
external JSFunction get _htmlOListElementConstructor;

@JS('HTMLLIElement')
external JSFunction get _htmlLIElementConstructor;

@JS('HTMLIFrameElement')
external JSFunction get _htmlIFrameElementConstructor;

@JS('HTMLMetaElement')
external JSFunction get _htmlMetaElementConstructor;

@JS('HTMLScriptElement')
external JSFunction get _htmlScriptElementConstructor;

@JS('HTMLStyleElement')
external JSFunction get _htmlStyleElementConstructor;

@JS('HTMLCanvasElement')
external JSFunction get _htmlCanvasElementConstructor;

@JS('HTMLVideoElement')
external JSFunction get _htmlVideoElementConstructor;

@JS('HTMLAudioElement')
external JSFunction get _htmlAudioElementConstructor;

@JS('HTMLDialogElement')
external JSFunction get _htmlDialogElementConstructor;

@JS('HTMLOutputElement')
external JSFunction get _htmlOutputElementConstructor;

@JS('HTMLPictureElement')
external JSFunction get _htmlPictureElementConstructor;

@JS('HTMLSourceElement')
external JSFunction get _htmlSourceElementConstructor;

@JS('HTMLTrackElement')
external JSFunction get _htmlTrackElementConstructor;

@JS('HTMLTableCaptionElement')
external JSFunction get _htmlTableCaptionElementConstructor;

@JS('HTMLTableColElement')
external JSFunction get _htmlTableColElementConstructor;

@JS('HTMLTableSectionElement')
external JSFunction get _htmlTableSectionElementConstructor;

@JS('Text')
external JSFunction get _textConstructor;

@JS('Comment')
external JSFunction get _commentConstructor;
