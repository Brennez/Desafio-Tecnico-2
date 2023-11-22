import 'package:book_reader/domain/use_cases/fliter_by_favorites_usecase.dart';
import 'package:book_reader/domain/use_cases/get_books_usecase.dart';
import 'package:book_reader/domain/use_cases/toggle_favorite_use_case.dart';
import 'package:mobx/mobx.dart';

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

    return _books;
  }

  @action
  Future<void> toogleFavorite(Book book) async {
    final newBook = toggleFavoriteUseCase.execute(book);
    _books[_books.indexOf(book)] = newBook.toEntity();
  }

  @action
  void loadFavorites() {
    _favoriteBooks =
        ObservableList.of(FilterByFavoritesUseCaseImpl().execute(_books));
  }
}
