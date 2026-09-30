/// [web](https://pub.dev/packages/web) utils library.
///
/// - Exports `package:web/web.dart`
library;

export 'package:js_interop_utils/js_interop_utils.dart';
// `TouchListConvert.toList` (deprecated in `package:web`) is ambiguous with
// `TouchListExtension.toList`.
export 'package:web/web.dart' hide TouchListConvert;

export 'src/web_utils_extensions.dart';
export 'src/web_utils_helpers.dart';
