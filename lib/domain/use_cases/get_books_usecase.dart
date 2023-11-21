import 'package:book_reader/data/repositories/book_repository_impl.dart';
import 'package:book_reader/shared/http/client_http.dart';

import '../entities/book.dart';

abstract class GetBooksUseCase {
  Future<List<Book>> execute();
}

class GetBooksUseCaseImpl implements GetBooksUseCase {
  @override
  Future<List<Book>> execute() async {
    final itens = await BookRepositoryImpl(client: HttpClient()).getBooks();

    List<Book> books = itens.map((book) => Book.fromDto(book)).toList();

    return books;
  }
}
