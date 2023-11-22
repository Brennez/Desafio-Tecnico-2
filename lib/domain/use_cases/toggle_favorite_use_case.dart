import 'package:book_reader/data/models/book_dto.dart';
import 'package:book_reader/data/repositories/favorite_repository_impl.dart';

import '../entities/book.dart';

abstract class ToggleFavoriteUseCase {
  BookDto execute(Book book);
}

class ToggleFavoriteUseCaseImpl implements ToggleFavoriteUseCase {
  final FavoriteRepositoryImpl favoriteRepository;

  ToggleFavoriteUseCaseImpl({
    required this.favoriteRepository,
  });

  @override
  BookDto execute(Book book) {
    final newBook = favoriteRepository.toogleFavorite(book.toDto());
    return newBook;
  }
}
