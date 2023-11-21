import '../models/book_dto.dart';

abstract class BookRepository {
  Future<List<BookDto>> getBooks();
}
