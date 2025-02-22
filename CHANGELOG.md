## 1.0.7

- `Web`:
  - Added `isSupported`.
  - Added `HTMLFormElement`, `HTMLLabelElement`, `HTMLParagraphElement`, `HTMLHeadingElement`, `HTMLUListElement`,
    `HTMLOListElement`, `HTMLLIElement`, `HTMLIFrameElement`, `HTMLMetaElement`, `HTMLScriptElement`,
    `HTMLStyleElement`, `HTMLCanvasElement`, `HTMLVideoElement`, `HTMLAudioElement`, `HTMLDialogElement`,
    `HTMLOutputElement`, `HTMLPictureElement`, `HTMLSourceElement`, `HTMLTrackElement`, `HTMLTableCaptionElement`,
    `HTMLTableColElement`, `HTMLTableSectionElement`, `Notification`.

- `ElementExtension`:
  - Added `classes` (alias to `classList`).

- `IDBRequestExtension`:
  - `process`: `if (cursor.isA<IDBCursor>())` call `iDBCursor.continue_()`.

- `WindowExtension`:
  - Added `onOnline` and `onOffline`.

- New `HTMLCanvasElementExtension`, `SpeechSynthesisUtteranceExtension`,
  `ServiceWorkerContainerExtension`, `GeolocationExtension`.

## 1.0.6

- `NodeExtension`:
  - `insertNode`: fix and optimize use of `insertBefore`.

- `ElementExtension`:
  - `insertChild`: fix and optimize use of `insertBefore`.

- `NodeListExtension`:
  - Removed `whereType` (can't use generics with `web` extension types).
  - Added `where`.
  - Fix `whereElement` and `whereHTMLElement`.

## 1.0.5

- js_interop_utils: ^1.0.5

- test: ^1.25.15

## 1.0.4

- js_interop_utils: ^1.0.4

🛠New extensions and their methods:

- `WebObjectExtension`:
  - `isNode`
  - `isElement`
  - `isHTMLElement`

- `WebJSAnyExtension`:
  - `isNode`
  - `isElement`
  - `isHTMLElement`

- `JSObjectWebExtension`:
  - `isNode`
  - `isElement`
  - `isHTMLElement`

- `WebIterableExtension`:
  - `whereElement()`
  - `whereElementType<E extends Element>(Web<E> webType)`

- `WebIterableJSAnyExtension`:
  - `whereElement()`
  - `whereElementType<E extends Element>(Web<E> webType)`

- `IterableElementExtension`:
  - `whereElement()`
  - `whereElementType<E extends Element>(Web<E> webType)`

- `IterableNodeExtension`:
  - `whereElement()`
  - `whereElementType<E extends Element>(Web<E> webType)`
  - `toElements()`
  - `whereHTMLElement()`

- `DocumentExtension`:
  - `select<T extends Element>(String selectors, [Web<T>? webType])`
  - `selectAll<T extends Element>(String selectors, [Web<T>? webType])`

- `NodeExtension`:
  - `removeNodes(Iterable<Node> nodes)`
  - `removeNodeWhere(bool Function(Node node) test)`
  - `clear()`

- `ElementNullableExtension`:
  - `asHTMLElement`
  - `isElementOf<T extends Element>(Web<T> webType)`
  - `asElementOf<T extends Element>(Web<T> webType)`

- `ElementExtension`:
  - `text`
  - `asHTMLElement`
  - `asHTMLElementChecked`
  - `querySelectorTyped<T extends Element>(String selectors, Web<T> webType)`
  - `querySelectorAllTyped<T extends Element>(String selectors, Web<T> webType)`
  - `insertChild(int index, Element node)`
  - `clear()`
  - `getComputedStyle()`
  - `click()`
  - `focus()`
  - `style`
  - `hidden`
  - `dispatchEventOfType(String type, {bool? bubbles, bool? cancelable, bool? composed})`
  - `dispatchChangeEvent()`
  - `setAttributes(Map<String, String> attrs)`

- `HTMLElementExtension`:
  - `appendHTML(String html)`
  - `isHidden`

- `HTMLSelectElementExtension`:
  - `selectIndex(int index)`

- `HTMLOptionsCollectionExtension`:
  - `toIterable`
  - `toList`
  - `isEmpty`

- `TouchListExtension`:
  - `toIterable`
  - `toList`
  - `isEmpty`

- `FileListExtension`:
  - `toIterable`
  - `toList`
  - `isEmpty`

- `CSSStyleDeclarationExtension`:
  - `toIterable`
  - `toList`
  - `isEmpty`

- `CSSRuleListExtension`:
  - `toIterable`
  - `toList`
  - `isEmpty`

- `CanvasRenderingContext2DExtension`:
  - (No methods were changed)

- `DOMTokenListExtension`:
  - `toIterable`
  - `toList`
  - `isEmpty`

- `NamedNodeMapExtension`:
  - `toIterable`
  - `toList`
  - `whereType`

- `HTMLCollectionExtension`:
  - `toIterable`
  - `toList`
  - `whereType`
  - `whereElementType`
  - `whereElement`
  - `toElements`

- `NodeListExtension`:
  - `toIterable`
  - `toList`
  - `whereType`
  - `whereElementType`
  - `whereElement`
  - `toElements`

- `HTMLTableElementExtension`:
  - `appendRow`

- `HTMLTableSectionElementExtension`:
  - `appendRow`

- `HTMLTableRowElementExtension`:
  - `appendCell`

- `StorageExtension`:
  - `isEmpty`
  - `isNotEmpty`
  - `keys`
  - `remove`

- `MouseEventExtension`:
  - `screenPoint`

- `TouchExtension`:
  - `clientPoint`
  - `radiusPoint`
  - `pagePoint`
  - `screenPoint`

- `FileReaderExtension`:
  - `onLoad`
  - `onLoadStart`
  - `onError`
  - `onAbort`

- `WorkerGlobalScopeExtension`:
  - `console`

- `WindowExtension`:
  - `console`
  - `onResize`
  - `onHashChange`
  - `onDeviceOrientation`
  - `onTouchStart`
  - `onTouchEndEvent`
  - `onTouchEnterEvent`
  - `onTouchLeaveEvent`

- `DOMRectExtension`:
  - `toRectangle`

## 1.0.3

- Use `toDartFix` on `String` coming from JS.

- js_interop_utils: ^1.0.3

## 1.0.2

- New `NodeExtension`:
  - `asElement`, `asHTMLElement`.
  - `insertNode`, `removeNodeAt`, `appendNodes`. `remove`, `clear`.

- New `NodeNullableExtension`: `asElementChecked`, `asHTMLElementChecked`.

- `ElementNullableExtension`:
  - Renamed `asElement<T>()` to `asElementOf<T>()`.
  - Added `isCanvasImageSource`.

- `ElementExtension`:
  - `insertChild`: returns `Element`.
  - Added `removeChildAt`, `clear`.

- `DOMTokenListExtension`:
  - Added `clear`. 

- `NamedNodeMapExtension`:
  - Added `toMap`.

- New `MouseEventExtension`: `clientPoint`, `offsetPoint`, `pagePoint`, `screenPoint`.

- js_interop_utils: ^1.0.2

## 1.0.1

- export 'package:js_interop_utils/js_interop_utils.dart'

- CI: test with `dart2js` and `dart2wasm` (on Chrome).

- js_interop_utils: ^1.0.1

## 1.0.0

- Initial version.
