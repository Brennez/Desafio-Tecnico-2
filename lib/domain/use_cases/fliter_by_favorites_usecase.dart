import '../entities/book.dart';

abstract class FilterByFavoritesUseCase {
  List<Book> execute(List<Book> books);
}

class FilterByFavoritesUseCaseImpl implements FilterByFavoritesUseCase {
  @override
  List<Book> execute(List<Book> books) {
    return books.where((book) => book.isFavorite == true).toList();
  }
}
