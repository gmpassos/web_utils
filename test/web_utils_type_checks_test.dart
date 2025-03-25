@TestOn('browser')
library;

import 'package:test/test.dart';
import 'package:web_utils/src/web_utils_type_checks.dart';
import 'package:web_utils/web_utils.dart';

void main() {
  group('DOM Types', () {
    test('checks (cached)', () => _domTypeChecks(true));
    test('checks (uncached)', () => _domTypeChecks(false));
  });
}

void _domTypeChecks(bool cached) {
  JSAnyDOMTypeChecks.cached = cached;

  try {
    expect(HTMLElement.article().isHTMLElement, isTrue);
    expect(HTMLElement.section().isHTMLElement, isTrue);

    expect(HTMLElement.article().isHTMLDivElement, isFalse);
    expect(HTMLElement.section().isHTMLDivElement, isFalse);

    expect(HTMLDivElement().isHTMLDivElement, isTrue);
    expect(HTMLAnchorElement().isHTMLDivElement, isFalse);

    expect(HTMLAnchorElement().isHTMLAnchorElement, isTrue);
    expect(HTMLDivElement().isHTMLAnchorElement, isFalse);

    expect(HTMLButtonElement().isHTMLButtonElement, isTrue);
    expect(HTMLDivElement().isHTMLButtonElement, isFalse);

    expect(HTMLTextAreaElement().isHTMLTextAreaElement, isTrue);
    expect(HTMLDivElement().isHTMLTextAreaElement, isFalse);

    expect(HTMLInputElement().isHTMLInputElement, isTrue);
    expect(HTMLDivElement().isHTMLInputElement, isFalse);

    expect(HTMLSelectElement().isHTMLSelectElement, isTrue);
    expect(HTMLDivElement().isHTMLSelectElement, isFalse);

    expect(HTMLOptionElement().isHTMLOptionElement, isTrue);
    expect(HTMLDivElement().isHTMLOptionElement, isFalse);

    expect(HTMLImageElement().isHTMLImageElement, isTrue);
    expect(HTMLDivElement().isHTMLImageElement, isFalse);

    expect(HTMLSpanElement().isHTMLSpanElement, isTrue);
    expect(HTMLDivElement().isHTMLSpanElement, isFalse);

    expect(HTMLTableElement().isHTMLTableElement, isTrue);
    expect(HTMLDivElement().isHTMLTableElement, isFalse);

    expect(HTMLTableRowElement().isHTMLTableRowElement, isTrue);
    expect(HTMLDivElement().isHTMLTableRowElement, isFalse);

    expect(HTMLTableRowElement().appendCell().isHTMLTableCellElement, isTrue);
    expect(HTMLDivElement().isHTMLTableCellElement, isFalse);

    expect(HTMLFormElement().isHTMLFormElement, isTrue);
    expect(HTMLDivElement().isHTMLFormElement, isFalse);

    expect(HTMLLabelElement().isHTMLLabelElement, isTrue);
    expect(HTMLDivElement().isHTMLLabelElement, isFalse);

    expect(HTMLParagraphElement().isHTMLParagraphElement, isTrue);
    expect(HTMLDivElement().isHTMLParagraphElement, isFalse);

    expect(HTMLHeadingElement.h1().isHTMLHeadingElement, isTrue);
    expect(HTMLDivElement().isHTMLHeadingElement, isFalse);

    expect(HTMLUListElement().isHTMLUListElement, isTrue);
    expect(HTMLDivElement().isHTMLUListElement, isFalse);

    expect(HTMLOListElement().isHTMLOListElement, isTrue);
    expect(HTMLDivElement().isHTMLOListElement, isFalse);

    expect(HTMLLIElement().isHTMLLIElement, isTrue);
    expect(HTMLDivElement().isHTMLLIElement, isFalse);

    expect(HTMLIFrameElement().isHTMLIFrameElement, isTrue);
    expect(HTMLDivElement().isHTMLIFrameElement, isFalse);

    expect(HTMLMetaElement().isHTMLMetaElement, isTrue);
    expect(HTMLDivElement().isHTMLMetaElement, isFalse);

    expect(HTMLScriptElement().isHTMLScriptElement, isTrue);
    expect(HTMLDivElement().isHTMLScriptElement, isFalse);

    expect(HTMLStyleElement().isHTMLStyleElement, isTrue);
    expect(HTMLDivElement().isHTMLStyleElement, isFalse);

    expect(HTMLCanvasElement().isHTMLCanvasElement, isTrue);
    expect(HTMLDivElement().isHTMLCanvasElement, isFalse);

    expect(HTMLVideoElement().isHTMLVideoElement, isTrue);
    expect(HTMLDivElement().isHTMLVideoElement, isFalse);

    expect(HTMLAudioElement().isHTMLAudioElement, isTrue);
    expect(HTMLDivElement().isHTMLAudioElement, isFalse);

    expect(HTMLDialogElement().isHTMLDialogElement, isTrue);
    expect(HTMLDivElement().isHTMLDialogElement, isFalse);

    expect(HTMLOutputElement().isHTMLOutputElement, isTrue);
    expect(HTMLDivElement().isHTMLOutputElement, isFalse);

    expect(HTMLPictureElement().isHTMLPictureElement, isTrue);
    expect(HTMLDivElement().isHTMLPictureElement, isFalse);

    expect(HTMLSourceElement().isHTMLSourceElement, isTrue);
    expect(HTMLDivElement().isHTMLSourceElement, isFalse);

    expect(HTMLTrackElement().isHTMLTrackElement, isTrue);
    expect(HTMLDivElement().isHTMLTrackElement, isFalse);

    expect(HTMLTableCaptionElement().isHTMLTableCaptionElement, isTrue);
    expect(HTMLDivElement().isHTMLTableCaptionElement, isFalse);

    expect(HTMLTableColElement.col().isHTMLTableColElement, isTrue);
    expect(HTMLDivElement().isHTMLTableColElement, isFalse);

    expect(HTMLTableSectionElement.thead().isHTMLTableSectionElement, isTrue);
    expect(HTMLDivElement().isHTMLTableSectionElement, isFalse);

    expect(HTMLTableSectionElement.tbody().isHTMLTableSectionElement, isTrue);
    expect(HTMLDivElement().isHTMLTableSectionElement, isFalse);

    expect(HTMLTableSectionElement.tfoot().isHTMLTableSectionElement, isTrue);
    expect(HTMLDivElement().isHTMLTableSectionElement, isFalse);
  } finally {
    // Default:
    JSAnyDOMTypeChecks.cached = true;
  }
}
