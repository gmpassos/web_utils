import 'package:web_utils/web_utils.dart';

void main() {
  var div = document.select<HTMLDivElement>('#output');

  print(div?.text);

  print(div?.children.toList());
}
