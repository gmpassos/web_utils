# web_utils

[![pub package](https://img.shields.io/pub/v/web_utils.svg?logo=dart&logoColor=00b9fc)](https://pub.dartlang.org/packages/web_utils)
[![Null Safety](https://img.shields.io/badge/null-safety-brightgreen)](https://dart.dev/null-safety)
[![Codecov](https://img.shields.io/codecov/c/github/gmpassos/web_utils)](https://app.codecov.io/gh/gmpassos/web_utils)
[![Dart CI](https://github.com/gmpassos/web_utils/actions/workflows/dart.yml/badge.svg?branch=master)](https://github.com/gmpassos/web_utils/actions/workflows/dart.yml)
[![GitHub Tag](https://img.shields.io/github/v/tag/gmpassos/web_utils?logo=git&logoColor=white)](https://github.com/gmpassos/web_utils/releases)
[![New Commits](https://img.shields.io/github/commits-since/gmpassos/web_utils/latest?logo=git&logoColor=white)](https://github.com/gmpassos/web_utils/network)
[![Last Commits](https://img.shields.io/github/last-commit/gmpassos/web_utils?logo=git&logoColor=white)](https://github.com/gmpassos/web_utils/commits/master)
[![Pull Requests](https://img.shields.io/github/issues-pr/gmpassos/web_utils?logo=github&logoColor=white)](https://github.com/gmpassos/web_utils/pulls)
[![Code size](https://img.shields.io/github/languages/code-size/gmpassos/web_utils?logo=github&logoColor=white)](https://github.com/gmpassos/web_utils)
[![License](https://img.shields.io/github/license/gmpassos/web_utils?logo=open-source-initiative&logoColor=green)](https://github.com/gmpassos/web_utils/blob/master/LICENSE)

This Dart package provides a set of extensions that enhance the capabilities of
various [web](https://pub.dev/packages/web) API types, such as `Node`, `Element`, `Document`, and others, making it
easier to work with HTML elements, styles, and other web-related objects in your Dart projects.

### js_interop_utils

This package **exports** and utilizes the [js_interop_utils](https://pub.dev/packages/js_interop_utils) package for
enhanced JavaScript interoperation in Dart. The `js_interop_utils` package provides utilities for working with
JavaScript objects and types, helping to bridge Dart and JavaScript in a seamless manner.

## Usage

```dart
import 'package:dom_extensions/dom_extensions.dart';

void main() {
  // Selecting elements
  final div = document.select<Element>('.my-div');
  final allDivs = document.selectAll<Element>('.my-div');

  // Manipulating elements
  div?.text = 'Hello, world!';

  // Working with NodeList
  final nodes = document.querySelectorAll('.node');
  final elements = nodes.toElements();
}

```

## Features

The package includes the following extensions:

### IterableNodeExtension

- **`whereElement()`**: Filters the `Iterable<Node>` and returns only `Element` nodes.
- **`toElements()`**: Converts the `Iterable<Node>` to a `List<Element>`.
- **`whereHTMLElement()`**: Filters the `Iterable<Node>` and returns only `HTMLElement` nodes.
- **`toHTMLElements()`**: Converts the `Iterable<Node>` to a `List<HTMLElement>`.

### DocumentExtension

- **`select<T extends Element>(String selectors)`**: Selects the first element matching the given selector and casts it
  to type `T`.
- **`selectAll<T extends Element>(String selectors)`**: Selects all elements matching the selector and casts them to
  type `T`.

### ElementExtension

- **`text`**: Gets or sets the text content of an element.
- **`asHTMLElement`**: Casts an element to `HTMLElement` if applicable.
- **`insertChild(int index, Element node)`**: Inserts an element at a specified index.
- **`insertNode(int index, Node node)`**: Inserts a node at a specified index.
- **`appendAll(Iterable<JSAny> nodes)`**: Appends multiple nodes to the element.
- **`appendNodes(Iterable<Node> nodes)`**: Appends multiple nodes to the element.

### HTMLOptionsCollectionExtension

- **`toIterable()`**: Converts the collection to an `Iterable<HTMLOptionElement>`.
- **`toList()`**: Converts the collection to a `List<HTMLOptionElement>`.
- **`isEmpty`**: Checks if the collection is empty.
- **`isNotEmpty`**: Checks if the collection is not empty.

### TouchListExtension

- **`toIterable()`**: Converts the `TouchList` to an `Iterable<Touch>`.
- **`toList()`**: Converts the `TouchList` to a `List<Touch>`.
- **`isEmpty`**: Checks if the list is empty.
- **`isNotEmpty`**: Checks if the list is not empty.

### FileListExtension

- **`toIterable()`**: Converts the `FileList` to an `Iterable<File>`.
- **`toList()`**: Converts the `FileList` to a `List<File>`.
- **`isEmpty`**: Checks if the list is empty.
- **`isNotEmpty`**: Checks if the list is not empty.

### CSSStyleDeclarationExtension

- **`isEmpty`**: Checks if the style declaration is empty.
- **`isNotEmpty`**: Checks if the style declaration is not empty.

### CSSRuleListExtension

- **`toIterable()`**: Converts the `CSSRuleList` to an `Iterable<CSSRule>`.
- **`toList()`**: Converts the `CSSRuleList` to a `List<CSSRule>`.
- **`isEmpty`**: Checks if the rule list is empty.
- **`isNotEmpty`**: Checks if the rule list is not empty.

### CanvasRenderingContext2DExtension

- **`setFillColorRgb(int r, int g, int b, [num a = 1])`**: Sets the fill color for the context using RGB values.
- **`setStrokeColorRgb(int r, int g, int b, [num a = 1])`**: Sets the stroke color for the context using RGB values.

### DOMTokenListExtension

- **`toIterable()`**: Converts the `DOMTokenList` to an `Iterable<String>`.
- **`toList()`**: Converts the `DOMTokenList` to a `List<String>`.
- **`isEmpty`**: Checks if the token list is empty.
- **`isNotEmpty`**: Checks if the token list is not empty.
- **`addAndDetectChange(String clazz)`**: Adds a class and detects whether it caused a change.
- **`removeAndDetectChange(String clazz)`**: Removes a class and detects whether it caused a change.
- **`addAll(Iterable<String> classes)`**: Adds multiple classes.
- **`removeAll(Iterable<String> classes)`**: Removes multiple classes.

### NamedNodeMapExtension

- **`toIterable()`**: Converts the `NamedNodeMap` to an `Iterable<Attr>`.
- **`toList()`**: Converts the `NamedNodeMap` to a `List<Attr>`.
- **`whereType<T>()`**: Filters the map for attributes of a specific type.
- **`isEmpty`**: Checks if the map is empty.
- **`isNotEmpty`**: Checks if the map is not empty.

### HTMLCollectionExtension

- **`toIterable()`**: Converts the `HTMLCollection` to an `Iterable<Element>`.
- **`toList()`**: Converts the `HTMLCollection` to a `List<Element>`.
- **`whereType<T>()`**: Filters the collection for elements of a specific type.
- **`isEmpty`**: Checks if the collection is empty.
- **`isNotEmpty`**: Checks if the collection is not empty.
- **`indexOf(Element element)`**: Finds the index of a specific element in the collection.

### NodeListExtension

- **`toIterable()`**: Converts the `NodeList` to an `Iterable<Node>`.
- **`toList()`**: Converts the `NodeList` to a `List<Node>`.
- **`whereType<T extends Node>()`**: Filters the list for nodes of a specific type.
- **`whereElement()`**: Filters the list for `Element` nodes.
- **`toElements()`**: Converts the list to a `List<Element>`.
- **`whereHTMLElement()`**: Filters the list for `HTMLElement` nodes.
- **`toHTMLElements()`**: Converts the list to a `List<HTMLElement>`.
- **`isEmpty`**: Checks if the node list is empty.
- **`isNotEmpty`**: Checks if the node list is not empty.
- **`indexOf(Node node)`**: Finds the index of a specific node in the list.

### StorageExtension

- **`isEmpty`**: Checks if the storage is empty.
- **`isNotEmpty`**: Checks if the storage is not empty.
- **`keys`**: Retrieves the keys of the storage.
- **`remove(String key)`**: Removes an item from the storage.

### IDBFactoryExtension

- **
  `openDatabase(String name, {int? version, void Function(Event event)? onUpgradeNeeded, void Function(Event event)? onBlocked})`
  **: Opens a database with the given name and version, with optional upgrade and blocked handlers.

### IDBRequestExtension

- **`process<T extends JSAny, R>(({bool next, R? result}) Function(T? result) processor)`**: Processes an `IDBRequest`
  result with a custom processor function.

### TextMetricsExtension

- **`tryActualBoundingBoxAscent`**: Tries to get the actual bounding box ascent.
- **`tryActualBoundingBoxDescent`**: Tries to get the actual bounding box descent.
- **`tryFontBoundingBoxAscent`**: Tries to get the font bounding box ascent.
- **`tryFontBoundingBoxDescent`**: Tries to get the font bounding box descent.
- **`tryEmHeightAscent`**: Tries to get the em height ascent.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/gmpassos/web_utils/issues

## Author

Graciliano M. Passos: [gmpassos@GitHub][github].

[github]: https://github.com/gmpassos

## Sponsor

Don't be shy, show some love, and become our [GitHub Sponsor][github_sponsors].
Your support means the world to us, and it keeps the code caffeinated! ☕✨

Thanks a million! 🚀😄

[github_sponsors]: https://github.com/sponsors/gmpassos

## License

[Apache License - Version 2.0][apache_license]

[apache_license]: https://www.apache.org/licenses/LICENSE-2.0.txt
