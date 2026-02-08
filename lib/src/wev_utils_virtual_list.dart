import 'dart:collection';

/// A read-only [List] view whose elements are computed lazily.
///
/// This list does not store elements internally. Instead, its length is
/// provided by [size], and each element is produced on demand by [getter].
///
/// The value returned by [size] is queried every time [length] is accessed.
/// If [size] returns different values over time, the list length may appear
/// inconsistent during iteration.
///
/// All mutation operations are unsupported and will throw [UnsupportedError].
class VirtualListView<E> extends ListBase<E> {
  /// Returns the current number of elements in the list.
  ///
  /// This function is invoked every time [length] is accessed.
  final int Function() size;

  /// Returns the element at the given [index].
  ///
  /// The caller is responsible for ensuring that [index] is within bounds.
  final E Function(int index) getter;

  /// Creates a virtual, read-only list backed by [size] and [getter].
  VirtualListView(this.size, this.getter);

  /// The current length of the list, as returned by [size].
  @override
  int get length => size();

  /// Returns the element at [index] using [getter].
  @override
  E operator [](int index) => getter(index);

  /// Unsupported. This list is read-only.
  @override
  void operator []=(int index, E value) {
    _throwUnmodifiable();
  }

  /// Unsupported. This list has a virtual, computed length.
  @override
  set length(int newLength) => _throwUnmodifiable();

  Never _throwUnmodifiable() {
    throw UnsupportedError("Unmodifiable `VirtualListView`");
  }
}

/// A read-only [List] view with a fixed length and lazily computed elements.
///
/// Unlike [VirtualListView], the [length] of this list is fixed at construction
/// time. Elements are produced on demand by [getter] and are not stored.
///
/// All mutation operations are unsupported and will throw [UnsupportedError].
class VirtualFixedListView<E> extends ListBase<E> {
  /// The fixed number of elements in the list.
  @override
  final int length;

  /// Returns the element at the given [index].
  ///
  /// The caller is responsible for ensuring that [index] is within bounds.
  final E Function(int index) getter;

  /// Creates a virtual, read-only list with a fixed [length] and a [getter].
  VirtualFixedListView(this.length, this.getter);

  /// Returns the element at [index] using [getter].
  @override
  E operator [](int index) => getter(index);

  /// Unsupported. This list is read-only.
  @override
  void operator []=(int index, E value) {
    _throwUnmodifiable();
  }

  /// Unsupported. This list has a fixed length.
  @override
  set length(int newLength) => _throwUnmodifiable();

  Never _throwUnmodifiable() {
    throw UnsupportedError("Unmodifiable `VirtualFixedListView`");
  }
}
