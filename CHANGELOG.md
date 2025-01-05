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
