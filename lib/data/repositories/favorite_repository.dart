import '../models/book_dto.dart';

abstract class FavoriteRepository {
  void toogleFavorite(BookDto book);
}
