@TestOn('browser')
library;

import 'package:test/test.dart';
import 'package:web_utils/src/web_utils_type_checks.dart';
import 'package:web_utils/web_utils.dart';

void main() {
  group('DOM Types', () {
    test('checks', () {
      expect(HTMLElement.article().isHTMLElement, isTrue);
      expect(HTMLElement.section().isHTMLElement, isTrue);

      expect(HTMLElement.article().isHTMLDivElement, isFalse);
      expect(HTMLElement.section().isHTMLDivElement, isFalse);

      expect(HTMLDivElement().isHTMLDivElement, isTrue);
      expect(HTMLAnchorElement().isHTMLAnchorElement, isTrue);
      expect(HTMLButtonElement().isHTMLButtonElement, isTrue);
      expect(HTMLTextAreaElement().isHTMLTextAreaElement, isTrue);
      expect(HTMLInputElement().isHTMLInputElement, isTrue);
      expect(HTMLSelectElement().isHTMLSelectElement, isTrue);
      expect(HTMLOptionElement().isHTMLOptionElement, isTrue);
      expect(HTMLImageElement().isHTMLImageElement, isTrue);
      expect(HTMLSpanElement().isHTMLSpanElement, isTrue);
      expect(HTMLTableElement().isHTMLTableElement, isTrue);
      expect(HTMLTableRowElement().isHTMLTableRowElement, isTrue);
      expect(HTMLTableRowElement().appendCell().isHTMLTableCellElement, isTrue);
      expect(HTMLFormElement().isHTMLFormElement, isTrue);
      expect(HTMLLabelElement().isHTMLLabelElement, isTrue);
      expect(HTMLParagraphElement().isHTMLParagraphElement, isTrue);
      expect(HTMLHeadingElement.h1().isHTMLHeadingElement, isTrue);
      expect(HTMLUListElement().isHTMLUListElement, isTrue);
      expect(HTMLOListElement().isHTMLOListElement, isTrue);
      expect(HTMLLIElement().isHTMLLIElement, isTrue);
      expect(HTMLIFrameElement().isHTMLIFrameElement, isTrue);
      expect(HTMLMetaElement().isHTMLMetaElement, isTrue);
      expect(HTMLScriptElement().isHTMLScriptElement, isTrue);
      expect(HTMLStyleElement().isHTMLStyleElement, isTrue);
      expect(HTMLCanvasElement().isHTMLCanvasElement, isTrue);
      expect(HTMLVideoElement().isHTMLVideoElement, isTrue);
      expect(HTMLAudioElement().isHTMLAudioElement, isTrue);
      expect(HTMLDialogElement().isHTMLDialogElement, isTrue);
      expect(HTMLOutputElement().isHTMLOutputElement, isTrue);
      expect(HTMLPictureElement().isHTMLPictureElement, isTrue);
      expect(HTMLSourceElement().isHTMLSourceElement, isTrue);
      expect(HTMLTrackElement().isHTMLTrackElement, isTrue);

      expect(HTMLTableCaptionElement().isHTMLTableCaptionElement, isTrue);
      expect(HTMLTableColElement.col().isHTMLTableColElement, isTrue);

      expect(HTMLTableSectionElement.thead().isHTMLTableSectionElement, isTrue);
      expect(HTMLTableSectionElement.tbody().isHTMLTableSectionElement, isTrue);
      expect(HTMLTableSectionElement.tfoot().isHTMLTableSectionElement, isTrue);
    });
  });
}
