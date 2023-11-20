import 'package:book_reader/http/client_http.dart';
import 'package:book_reader/repository/book_repository.dart';
import 'package:mobx/mobx.dart';
import '../models/book.dart';

part 'books_store.g.dart';

class BooksStore = _BooksStore with _$BooksStore;

abstract class _BooksStore with Store {
  _BooksStore() {
    getBooks();
  }

  @observable
  ObservableList<Book> _books = ObservableList<Book>();

  @computed
  ObservableList<Book> get books => ObservableList.of(_books);

  @action
  Future<void> getBooks() async {
    final itens = await BookRepository(client: HttpClient()).getBooks();
    _books.addAll(itens);
  }
}
