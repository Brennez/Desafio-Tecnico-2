import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:book_reader/domain/use_cases/fliter_by_favorites_usecase.dart';
import 'package:book_reader/domain/use_cases/get_books_usecase.dart';
import 'package:book_reader/domain/use_cases/toggle_favorite_use_case.dart';

import '../../domain/entities/book.dart';

part 'books_store.g.dart';

class BooksStore = _BooksStore with _$BooksStore;

abstract class _BooksStore with Store {
  final GetBooksUseCase getBooksUseCase;

  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  _BooksStore(
      {required this.getBooksUseCase, required this.toggleFavoriteUseCase});

  @observable
  ObservableList<Book> _books = ObservableList<Book>();

  @observable
  ObservableList<Book> _favoriteBooks = ObservableList<Book>();

  @computed
  ObservableList<Book> get favoriteBooks => ObservableList.of(_favoriteBooks);

  @computed
  ObservableList<Book> get books => ObservableList.of(_books);

  @action
  Future<List<Book>> loadBooks() async {
    final itens = ObservableList.of(await getBooksUseCase.execute());

    _books = ObservableList.of(itens);

    await _loadFavoriteBooks();

    return _books;
  }

  @action
  Future<void> toggleFavorite(Book book) async {
    final newBook = toggleFavoriteUseCase.execute(book);

    _books[_books.indexOf(book)] = newBook.toEntity();

    await _saveFavoriteBook(book.id, newBook.isFavorite);
  }

  @action
  void loadFavorites() {
    _favoriteBooks =
        ObservableList.of(FilterByFavoritesUseCaseImpl().execute(_books));
  }

  @action
  Future<void> _loadFavoriteBooks() async {
    for (var item in _books) {
      item.isFavorite = await _loadIsFavoritPreferences(item.id) ?? false;
    }
  }

  @action
  Future<void> _saveFavoriteBook(int bookId, bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(bookId.toString(), value);
  }

  @action
  Future<bool?> _loadIsFavoritPreferences(int bookId) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(bookId.toString());
  }
}
