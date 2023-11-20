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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'cover_url': cover_url,
      'download_url': download_url,
    };
  }

  factory Book.fromJson(Map<String, dynamic> data) {
    return Book(
      id: data['id'],
      title: data['title'],
      author: data['author'],
      cover_url: data['cover_url'],
      download_url: data['download_url'],
    );
  }
}
