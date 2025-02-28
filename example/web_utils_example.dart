import 'package:web_utils/web_utils.dart';

void main() {
  var div = document.selectTyped<HTMLDivElement>('#output', Web.HTMLDivElement);

  print(div?.text);

  print(div?.children.toList());
}
