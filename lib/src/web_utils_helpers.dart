import 'package:js_interop_utils/js_interop_utils.dart';
import 'package:web/web.dart';

@JS('eval')
external JSAny? jsEval(JSString code);

bool _defined = false;

void _define() {
  if (_defined) return;
  _defined = true;

  jsEval(r'''
window._setElementAttributesJS = function(el, attrsKeys, attrsValues) {
  const keys = attrsKeys;
  const values = attrsValues;
  const len = keys.length;

  for (let i = 0; i < len; ++i) {
    const v = values[i];
    if (v == null) {
      el.removeAttribute(keys[i]);
    } else {
      el.setAttribute(keys[i], v);
    }
  }
}
'''
      .toJS);
}

@JS()
external void _setElementAttributesJS(
  Element element,
  JSArray<JSString> attrsKeys,
  JSArray<JSString?> attrsValues,
);

/// Sets multiple attributes on [element] using a single JavaScript call.
///
/// This avoids multiple JS interop crossings by applying all attributes
/// in one execution, improving performance — especially when running
/// under WASM.
///
/// Each key in [attrsKeys] is paired with the value at the same index
/// in [attrsValues].
///
/// If a value is `null`, the corresponding attribute is removed.
///
/// Both lists must have the same length.
void setAttributesFromKeyValueLists(
  Element element,
  List<String> attrsKeys,
  List<String?> attrsValues,
) {
  if (!_defined) _define();
  assert(attrsKeys.length == attrsValues.length);
  _setElementAttributesJS(
    element,
    attrsKeys.toJS,
    attrsValues.toJS,
  );
}
