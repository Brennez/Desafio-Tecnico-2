import '../models/book_dto.dart';
import 'favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  @override
  BookDto toogleFavorite(BookDto book) {
    book.isFavorite = !book.isFavorite;
    return book;
  }
}
