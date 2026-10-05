import 'package:flutter/foundation.dart';
import '../models/book.dart';

class Catalog extends ChangeNotifier {
  Catalog({List<Book> initial = const []}) : _books = List.of(initial);
  final List<Book> _books;
  int _nextId = 0;
  List<Book> get books => List.unmodifiable(_books);
  String newId() =>
      'book-${DateTime.now().microsecondsSinceEpoch}-${_nextId++}';
  Book? find(String id) {
    for (final book in _books) {
      if (book.id == id) return book;
    }
    return null;
  }

  void save(Book book) {
    final index = _books.indexWhere((item) => item.id == book.id);
    if (index < 0) {
      _books.add(book);
    } else {
      _books[index] = book;
    }
    notifyListeners();
  }

  void remove(String id) {
    _books.removeWhere((book) => book.id == id);
    notifyListeners();
  }
}
