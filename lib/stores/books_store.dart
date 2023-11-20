import 'package:book_reader/repository/book_repository.dart';
import 'package:mobx/mobx.dart';
import '../models/book.dart';

part 'books_store.g.dart';

class BooksStore = _BooksStore with _$BooksStore;

abstract class _BooksStore with Store {
  final BookRepository bookRepository;

  _BooksStore({required this.bookRepository});

  @observable
  ObservableList<Book> _books = ObservableList<Book>();

  @computed
  ObservableList<Book> get books => ObservableList.of(_books);

  @action
  Future<List<Book>> getBooks() async {
    final itens = await bookRepository.getBooks();

    _books = ObservableList.of(itens);

    return _books;
  }
}
