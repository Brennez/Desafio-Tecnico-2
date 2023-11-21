import 'dart:convert';

import '../../shared/consts/api_endpoint.dart';
import '../../shared/http/client_http.dart';
import '../../shared/http/errors.dart';

import '../models/book_dto.dart';
import 'book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final HttpClient client;

  BookRepositoryImpl({
    required this.client,
  });

  @override
  Future<List<BookDto>> getBooks() async {
    final response = await client.get(url: Endpoint.books);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<BookDto> books = body.map((book) => BookDto.fromJson(book)).toList();

      return books;
    } else if (response.statusCode == 404) {
      throw NotFoundError(message: 'URL não encontrada');
    } else {
      throw Exception('Erro inesperado');
    }
  }
}
