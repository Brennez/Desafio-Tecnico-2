import 'package:book_reader/data/models/book_dto.dart';

import 'favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  @override
  void toogleFavorite(BookDto book) {
    book.isFavorite = !book.isFavorite;
  }
}
