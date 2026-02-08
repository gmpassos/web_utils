import 'package:test/test.dart';
import 'package:web_utils/src/wev_utils_virtual_list.dart';

void main() {
  group('VirtualListView', () {
    test('computes length lazily', () {
      var sizeValue = 3;
      final list = VirtualListView<int>(() => sizeValue, (i) => i * 10);

      expect(list.length, 3);
      sizeValue = 5;
      expect(list.length, 5);
    });

    test('computes elements lazily via getter', () {
      var calls = <int>[];
      final list = VirtualListView<int>(() => 3, (i) {
        calls.add(i);
        return i + 1;
      });

      expect(list[0], 1);
      expect(list[2], 3);
      expect(calls, [0, 2]);
    });

    test('iterates using current length', () {
      var sizeValue = 2;
      final list = VirtualListView<int>(() => sizeValue, (i) => i);

      expect(list.toList(), [0, 1]);

      sizeValue = 4;
      expect(list.toList(), [0, 1, 2, 3]);
    });

    test('mutation operations throw UnsupportedError', () {
      final list = VirtualListView<int>(() => 1, (i) => i);

      expect(() => list[0] = 10, throwsUnsupportedError);
      expect(() => list.length = 10, throwsUnsupportedError);
    });
  });

  group('VirtualFixedListView', () {
    test('has fixed length', () {
      final list = VirtualFixedListView<int>(3, (i) => i * 2);
      expect(list.length, 3);
    });

    test('computes elements lazily via getter', () {
      var calls = <int>[];
      final list = VirtualFixedListView<int>(3, (i) {
        calls.add(i);
        return i + 5;
      });

      expect(list[1], 6);
      expect(list[2], 7);
      expect(calls, [1, 2]);
    });

    test('iterates correctly', () {
      final list = VirtualFixedListView<int>(4, (i) => i);
      expect(list.toList(), [0, 1, 2, 3]);
    });

    test('mutation operations throw UnsupportedError', () {
      final list = VirtualFixedListView<int>(2, (i) => i);

      expect(() => list[0] = 10, throwsUnsupportedError);
      expect(() => list.length = 5, throwsUnsupportedError);
    });
  });
}
