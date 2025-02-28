@TestOn('browser')
library;

import 'package:test/test.dart';
import 'package:web_utils/web_utils.dart';

void main() {
  group('', () {
    test('', () {
      var body = document.body!;

      body.appendChild(
        HTMLDivElement()
          ..id = 'my-div1'
          ..classList.add('myDiv'),
      );

      body.appendChild(
        HTMLDivElement()
          ..id = 'my-div2'
          ..classList.add('myDiv'),
      );

      var div1 =
          document.selectTyped<HTMLDivElement>('#my-div1', Web.HTMLDivElement);
      expect(div1, isNotNull);
      //expect(div1!.isA<HTMLDivElement>, isTrue);

      var div2 =
          document.selectTyped<HTMLDivElement>('#my-div2', Web.HTMLDivElement);
      expect(div2, isNotNull);
      //expect(div2!.isA<HTMLDivElement>, isTrue);
    });
  });
}
