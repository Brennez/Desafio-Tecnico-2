// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BooksStore on _BooksStore, Store {
  Computed<ObservableList<Book>>? _$booksComputed;

  @override
  ObservableList<Book> get books =>
      (_$booksComputed ??= Computed<ObservableList<Book>>(() => super.books,
              name: '_BooksStore.books'))
          .value;

  late final _$_booksAtom = Atom(name: '_BooksStore._books', context: context);

  @override
  ObservableList<Book> get _books {
    _$_booksAtom.reportRead();
    return super._books;
  }

  @override
  set _books(ObservableList<Book> value) {
    _$_booksAtom.reportWrite(value, super._books, () {
      super._books = value;
    });
  }

  late final _$getBooksAsyncAction =
      AsyncAction('_BooksStore.getBooks', context: context);

  @override
  Future<List<Book>> getBooks() {
    return _$getBooksAsyncAction.run(() => super.getBooks());
  }

  @override
  String toString() {
    return '''
books: ${books}
    ''';
  }
}
