## 1.0.21

- New `EventType` enum for strongly typed DOM event identifiers:
  - Associates DOM event names with their corresponding `Event` subtype.
  - Includes core, mouse, keyboard, focus, input, clipboard, drag & drop, touch, pointer lock, media, progress, storage, WebRTC, device, speech, fonts, fullscreen, security, IndexedDB, and accessibility events.
  - Provides `addEventListener` method to register typed event listeners on `EventTarget`.

- New `EventCallback` typedef for strongly typed DOM event callbacks.

- New `EventTargetExtension` extension:
  - Adds `addEventListenerTyped` method to register strongly typed event listeners using `EventType`.

- Updated `pubspec.yaml`:
  - Bumped `dependency_validator` dev dependency from `^5.0.3` to `^5.0.4`.

## 1.0.20

- `HTMLOptionsCollection`, `TouchList`, `FileList`, `CSSRuleList`,
  `DOMTokenList`, `NamedNodeMap`, `HTMLCollection`, `NodeList` extensions:
  - Added `asListView` getter returning a `VirtualListView` for lazy indexed access.
  - Added `asListViewFixed` getter returning a `VirtualFixedListView` with fixed length.

- `pubspec.yaml`:
  - Updated `test` dependency from `^1.28.0` to `^1.29.0`.

## 1.0.19

- `NamedNodeMapExtension`:
  - Added `getAttribute`, `containsAttribute`, `getAttributeValue`.

## 1.0.18

- `ElementNullableExtension`:
  - Added `asElementOfNullable`.

- `DocumentExtension`:
  - `querySelectorTyped`, `querySelectorAllTyped`: use `ElementNullableExtension`.

## 1.0.17

- New `KeyboardEventExtension` with unified key handling, including modern `.key`
  detection and legacy `.keyCode` fallback:
    - Added getters:
        - `keyCodeSafe`
        - `isKeyTabOrEnter`
        - `isKeyTab`
        - `isKeyEnter`
        - `isKeySpace`
        - `isKeyEscape`
        - `isArrowUp`, `isArrowDown`, `isArrowLeft`, `isArrowRight`
        - `isArrowKey`
        - `isNavigationKey`

- test: ^1.28.0

## 1.0.16

- js_interop_utils: ^1.0.9

- test: ^1.26.3
- dependency_validator: ^5.0.3

## 1.0.15

- `web_utils_extensions`:
  - ♻️ Optimize `indexOf`.

- `Element`:
  - ♻️ Enhance `style` getter with support for `SVGElement` and `MathMLElement`.

- js_interop_utils: ^1.0.8

- test: ^1.26.2

## 1.0.14

- New `web_utils_type_checks.dart`: optimized DOM type checking extensions:
  - New `JSAnyDOMTypeChecks`, `JSObjectDOMTypeChecksNullable`.
  - New `JSAnyDOMTypeChecks`, `JSAnyDOMTypeChecksNullable`.

- `Web`:
  - Added `Node` and `Text`.
  - Use optimized DOM type check.

## 1.0.13

- js_interop_utils: ^1.0.7

## 1.0.12

- `HTMLCanvasElementExtension`:
  - Added `asBlob`.

- `WindowExtension`:
  - Added `onKeyUp`, `onClick`, `onMouseDown`, `onMouseUp`, `onMouseMove`, `onWheel`, `onScroll`,
    `onFocus`, `onBlur`, `onBeforeUnload`, `onStorage`, `onDeviceMotion`, `onTouchEnd`, `onTouchCancel`.

## 1.0.11

✨♻️ refactor(web_utils_extensions):
  - Standardize `selectNonTyped` and rename it to `select` (without the optional `webType` parameter).
  - Standardize `selectNonTypedAll` and rename it to `selectAll` (without the optional `webType` parameter).
  - Ensure that `selectTyped` exists where `querySelectorTyped` exists.

## 1.0.10

✨♻️ Improve query selector extension methods:

- Add new query selector methods for non-typed and typed elements.
- Provide aliases to querySelector and querySelectorAll with and without type.
- Refactor existing methods for cleaner implementation and readability.

- web: ^1.1.1

## 1.0.9

- `GeolocationExtension`:
  - `watchGeolocationPosition`: call `clearWatch` when `Stream` is cancelled.

## 1.0.8

- js_interop_utils: ^1.0.6

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
