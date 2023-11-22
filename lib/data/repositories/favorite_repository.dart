import '../models/book_dto.dart';

abstract class FavoriteRepository {
  BookDto toogleFavorite(BookDto book);
}
