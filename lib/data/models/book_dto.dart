class BookDto {
  int id;
  String title;
  String author;
  String cover_url;
  String download_url;
  bool isFavorite;

  BookDto({
    required this.id,
    required this.title,
    required this.author,
    required this.cover_url,
    required this.download_url,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'cover_url': cover_url,
      'download_url': download_url,
    };
  }

  factory BookDto.fromJson(Map<String, dynamic> data) {
    return BookDto(
      id: data['id'],
      title: data['title'],
      author: data['author'],
      cover_url: data['cover_url'],
      download_url: data['download_url'],
    );
  }
}
