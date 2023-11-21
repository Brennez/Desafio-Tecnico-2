import '../../data/models/book_dto.dart';

class Book {
  int id;
  String title;
  String author;
  String cover_url;
  String download_url;
  bool isFavorite;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.cover_url,
    required this.download_url,
    this.isFavorite = false,
  });

  factory Book.fromDto(BookDto bookdto) {
    return Book(
      id: bookdto.id,
      title: bookdto.title,
      author: bookdto.author,
      cover_url: bookdto.cover_url,
      download_url: bookdto.download_url,
      isFavorite: bookdto.isFavorite,
    );
  }

  BookDto toDto() {
    return BookDto(
      id: id,
      title: title,
      author: author,
      cover_url: cover_url,
      download_url: download_url,
      isFavorite: isFavorite,
    );
  }
}
