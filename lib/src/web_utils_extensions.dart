import 'dart:async';
import 'dart:math';

import 'package:js_interop_utils/js_interop_utils.dart';
import 'package:web/web.dart';

extension IterableNodeExtension on Iterable<Node> {
  Iterable<Element> whereElement() =>
      where((e) => e.isA<Element>()).cast<Element>();

  List<Element> toElements() => whereElement().toList();

  Iterable<HTMLElement> whereHTMLElement() =>
      where((e) => e.isA<HTMLElement>()).cast<HTMLElement>();

  List<HTMLElement> toHTMLElements() => whereHTMLElement().toList();
}

extension DocumentExtension on Document {
  T? select<T extends Element>(String selectors) {
    var o = document.querySelector(selectors);
    return o?.asElementOf<T>();
  }

  List<T> selectAll<T extends Element>(String selectors) {
    var l = document.querySelectorAll(selectors).whereElement();
    return l.map((e) => e.asElementOf<T>()).nonNulls.toList();
  }
}

extension NodeNullableExtension on Node? {
  Element? get asElementChecked => isA<Element>() ? this as Element : null;

  HTMLElement? get asHTMLElementChecked =>
      isA<HTMLElement>() ? this as HTMLElement : null;
}

extension NodeExtension on Node {
  Element get asElement => this as Element;

  HTMLElement get asHTMLElement => this as HTMLElement;

  Node insertNode(int index, Node node) {
    final childNodes = this.childNodes;
    if (index >= childNodes.length) {
      return appendChild(node);
    } else {
      var node = childNodes.item(index)!;
      return insertBefore(node, node);
    }
  }

  Node? removeNodeAt(int index) {
    final childNodes = this.childNodes;
    if (index < 0 || index >= childNodes.length) return null;

    var node = childNodes.item(index);
    if (node == null) return null;

    return removeChild(node);
  }

  void appendNodes(Iterable<Node> nodes) {
    for (var node in nodes) {
      appendChild(node);
    }
  }

  void remove() {
    parentNode?.removeChild(this);
  }

  void clear() {
    if (isA<Element>()) {
      asElement.innerHTML = ''.toJS;
    } else {
      clearNodes();
    }
  }

  List<Node> clearNodes() {
    var nodes = childNodes.toList();
    for (var n in nodes.reversed) {
      n.removeChild(n);
    }
    return nodes;
  }
}

extension ElementNullableExtension on Element? {
  T? asElementOf<T extends Element>() {
    final self = this;

    if (self == null || self.isUndefinedOrNull) {
      return null;
    } else if (T == HTMLElement) {
      return self.isA<HTMLElement>() ? self as T : null;
    } else if (T == HTMLDivElement) {
      return self.isA<HTMLDivElement>() ? self as T : null;
    } else if (T == HTMLSpanElement) {
      return self.isA<HTMLSpanElement>() ? self as T : null;
    } else if (T == HTMLInputElement) {
      return self.isA<HTMLInputElement>() ? self as T : null;
    } else if (T == HTMLLabelElement) {
      return self.isA<HTMLLabelElement>() ? self as T : null;
    } else if (T == HTMLBodyElement) {
      return self.isA<HTMLBodyElement>() ? self as T : null;
    } else {
      try {
        return self as T;
      } catch (_) {
        return null;
      }
    }
  }

  bool get isCanvasImageSource {
    final node = this;
    if (node == null) return false;
    return node.isA<HTMLImageElement>() ||
        node.isA<HTMLCanvasElement>() ||
        node.isA<HTMLVideoElement>();
  }
}

extension ElementExtension on Element {
  String? get text => textContent;

  set text(String? text) => textContent = text;

  HTMLElement? get asHTMLElement =>
      isA<HTMLElement>() ? this as HTMLElement : null;

  Element insertChild(int index, Element node) {
    final children = this.children;
    if (index >= children.length) {
      return appendChild(node) as Element;
    } else {
      var elem = children.item(index)!;
      return insertBefore(elem, node) as Element;
    }
  }

  Element? removeChildAt(int index) {
    final children = this.children;
    if (index < 0 || index >= children.length) return null;

    var element = children.item(index);
    if (element == null) return null;

    return removeChild(element) as Element;
  }

  void appendAll(Iterable<JSAny> nodes) {
    for (var node in nodes) {
      append(node);
    }
  }

  void clear() {
    innerHTML = ''.toJS;
  }
}

extension HTMLOptionsCollectionExtension on HTMLOptionsCollection {
  Iterable<HTMLOptionElement> toIterable() =>
      List.generate(length, (i) => item(i)).whereType<HTMLOptionElement>();

  List<HTMLOptionElement> toList() => toIterable().toList();

  bool get isEmpty => length == 0;

  bool get isNotEmpty => !isEmpty;
}

extension TouchListExtension on TouchList {
  Iterable<Touch> toIterable() =>
      List.generate(length, (i) => item(i)).whereType<Touch>();

  List<Touch> toList() => toIterable().toList();

  bool get isEmpty => length == 0;

  bool get isNotEmpty => !isEmpty;
}

extension FileListExtension on FileList {
  Iterable<File> toIterable() =>
      List.generate(length, (i) => item(i)).whereType<File>();

  List<File> toList() => toIterable().toList();

  bool get isEmpty => length == 0;

  bool get isNotEmpty => !isEmpty;
}

extension CSSStyleDeclarationExtension on CSSStyleDeclaration {
  bool get isEmpty => cssText.trim().isEmpty;

  bool get isNotEmpty => !isEmpty;
}

extension CSSRuleListExtension on CSSRuleList {
  Iterable<CSSRule> toIterable() =>
      List.generate(length, (i) => item(i)).whereType<CSSRule>();

  List<CSSRule> toList() => toIterable().toList();

  bool get isEmpty => length == 0;

  bool get isNotEmpty => !isEmpty;
}

extension CanvasRenderingContext2DExtension on CanvasRenderingContext2D {
  void setFillColorRgb(int r, int g, int b, [num a = 1]) {
    fillStyle = 'rgba($r, $g, $b, $a)'.toJS;
  }

  void setStrokeColorRgb(int r, int g, int b, [num a = 1]) {
    strokeStyle = 'rgba($r, $g, $b, $a)'.toJS;
  }
}

extension DOMTokenListExtension on DOMTokenList {
  Iterable<String> toIterable() =>
      List.generate(length, (i) => item(i)).nonNulls;

  List<String> toList() => toIterable().toList();

  bool get isEmpty => length == 0;

  bool get isNotEmpty => !isEmpty;

  bool addAndDetectChange(String clazz) {
    var prevLng = length;
    add(clazz);
    return prevLng != length;
  }

  bool removeAndDetectChange(String clazz) {
    var prevLng = length;
    remove(clazz);
    return prevLng != length;
  }

  void addAll(Iterable<String> classes) {
    for (var c in classes) {
      add(c);
    }
  }

  void removeAll(Iterable<String> classes) {
    for (var c in classes) {
      remove(c);
    }
  }

  void clear() {
    value = '';
  }
}

extension NamedNodeMapExtension on NamedNodeMap {
  Iterable<Attr> toIterable() => List.generate(length, (i) => item(i)).nonNulls;

  List<Attr> toList() => toIterable().toList();

  Iterable<T> whereType<T>() => toIterable().whereType<T>();

  bool get isEmpty => length == 0;

  bool get isNotEmpty => !isEmpty;

  Map<String, String> toMap() =>
      Map.fromEntries(toIterable().map((a) => MapEntry(a.name, a.value)));
}

extension HTMLCollectionExtension on HTMLCollection {
  Iterable<Element> toIterable() =>
      List.generate(length, (i) => item(i)).nonNulls;

  List<Element> toList() => toIterable().toList();

  Iterable<T> whereType<T>() => toIterable().whereType<T>();

  bool get isEmpty => length == 0;

  bool get isNotEmpty => !isEmpty;

  int indexOf(Element element) {
    var i = 0;
    for (var e in toIterable()) {
      if (e == element) {
        return i;
      }
      i++;
    }
    return -1;
  }
}

extension NodeListExtension on NodeList {
  Iterable<Node> toIterable() => List.generate(length, (i) => item(i)).nonNulls;

  List<Node> toList() => toIterable().toList();

  Iterable<T> whereType<T extends Node>() => toIterable().whereType<T>();

  Iterable<Element> whereElement() => whereType<Element>();

  List<Element> toElements() => whereElement().toList();

  Iterable<HTMLElement> whereHTMLElement() => whereType<HTMLElement>();

  List<HTMLElement> toHTMLElements() => whereHTMLElement().toList();

  bool get isEmpty => length == 0;

  bool get isNotEmpty => !isEmpty;

  int indexOf(Node node) {
    var i = 0;
    for (var e in toIterable()) {
      if (e == node) {
        return i;
      }
      i++;
    }
    return -1;
  }
}

extension StorageExtension on Storage {
  bool get isEmpty => length == 0;

  bool get isNotEmpty => !isEmpty;

  Iterable<String> get keys => List.generate(length, (i) => key(i)).nonNulls;

  bool remove(String key) {
    var prevLng = length;
    removeItem(key);
    var changed = length != prevLng;
    return changed;
  }
}

extension IDBFactoryExtension on IDBFactory {
  Future<IDBDatabase?> openDatabase(
    String name, {
    int? version,
    void Function(Event event)? onUpgradeNeeded,
    void Function(Event event)? onBlocked,
  }) async {
    if ((version == null) != (onUpgradeNeeded == null)) {
      return Future.error(ArgumentError(
          'version and onUpgradeNeeded must be specified together'));
    }
    try {
      IDBOpenDBRequest? request;
      if (version != null) {
        request = open(name, version);
      } else {
        request = open(name);
      }

      if (onUpgradeNeeded != null) {
        request.onupgradeneeded = onUpgradeNeeded.toJS;
      }

      if (onBlocked != null) {
        request.onblocked = onBlocked.toJS;
      }

      final completer = Completer<void>();

      request.onerror = ((Event _) => completer
          .completeError(request?.error?.message ?? 'Unknown Error!')).toJS;

      request.onsuccess = ((Event _) => completer.complete()).toJS;

      await completer.future;

      return request.result as IDBDatabase?;
    } catch (e, stacktrace) {
      return Future.error(e, stacktrace);
    }
  }
}

extension IDBRequestExtension on IDBRequest {
  Future<R?> process<T extends JSAny, R>(
      ({bool next, R? result}) Function(T? result) processor) {
    final completer = Completer<R?>();

    onsuccess = (Event event) {
      var request = event.target as IDBRequest;
      var cursor = request.result as T?;

      var (next: next, result: r) = processor(cursor);

      if (!next) {
        completer.completeSafe(r);
      }
    }.toJS;

    onerror = (Event event) {
      var request = event.target as IDBRequest;
      var error = request.error;

      if (error != null) {
        completer.completeErrorSafe(error);
      } else {
        completer.completeErrorSafe("`IDBRequest` error!");
      }
    }.toJS;

    return completer.future;
  }
}

extension TextMetricsExtension on TextMetrics {
  double? get tryActualBoundingBoxAscent =>
      tryCall(() => actualBoundingBoxAscent);

  double? get tryActualBoundingBoxDescent =>
      tryCall(() => actualBoundingBoxDescent);

  double? get tryFontBoundingBoxAscent => tryCall(() => fontBoundingBoxAscent);

  double? get tryFontBoundingBoxDescent =>
      tryCall(() => fontBoundingBoxDescent);

  double? get tryEmHeightAscent => tryCall(() => emHeightAscent);
}

extension MouseEventExtension on MouseEvent {
  Point get clientPoint => Point(clientX, clientY);

  Point get offsetPoint => Point(offsetX, offsetY);

  Point get pagePoint => Point(pageX, pageY);

  Point get screenPoint => Point(screenX, screenY);
}

extension _CompleterExtension<T> on Completer<T> {
  void completeSafe([FutureOr<T>? value]) {
    if (!isCompleted) {
      complete(value);
    }
  }

  void completeErrorSafe(Object error, [StackTrace? stackTrace]) {
    if (!isCompleted) {
      completeError(error, stackTrace);
    }
  }
}
