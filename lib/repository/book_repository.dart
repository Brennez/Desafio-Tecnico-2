import 'dart:convert';

import 'package:book_reader/consts/api_endpoint.dart';
import 'package:book_reader/http/client_http.dart';
import 'package:book_reader/http/errors.dart';

import '../models/book.dart';

abstract class IBookRepository {
  Future<List<Book>> getBooks();
}

class BookRepository implements IBookRepository {
  final HttpClient client;

  BookRepository({
    required this.client,
  });

  @override
  Future<List<Book>> getBooks() async {
    final response = await client.get(url: Endpoint.books);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<Book> books = body.map((book) => Book.fromJson(book)).toList();

      return books;
    } else if (response.statusCode == 404) {
      throw NotFoundError(message: 'URL não encontrada');
    } else {
      throw Exception('Erro inesperado');
    }
  }
}
