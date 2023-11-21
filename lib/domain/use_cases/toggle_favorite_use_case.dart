import 'package:book_reader/data/repositories/favorite_repository_impl.dart';

import '../entities/book.dart';

abstract class ToggleFavoriteUseCase {
  void execute(Book book);
}

class ToggleFavoriteUseCaseImpl implements ToggleFavoriteUseCase {
  @override
  void execute(Book book) {
    FavoriteRepositoryImpl().toogleFavorite(book.toDto());
  }
}
