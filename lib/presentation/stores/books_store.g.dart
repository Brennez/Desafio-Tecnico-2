// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BooksStore on _BooksStore, Store {
  Computed<ObservableList<Book>>? _$favoriteBooksComputed;

  @override
  ObservableList<Book> get favoriteBooks => (_$favoriteBooksComputed ??=
          Computed<ObservableList<Book>>(() => super.favoriteBooks,
              name: '_BooksStore.favoriteBooks'))
      .value;
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

  late final _$_favoriteBooksAtom =
      Atom(name: '_BooksStore._favoriteBooks', context: context);

  @override
  ObservableList<Book> get _favoriteBooks {
    _$_favoriteBooksAtom.reportRead();
    return super._favoriteBooks;
  }

  @override
  set _favoriteBooks(ObservableList<Book> value) {
    _$_favoriteBooksAtom.reportWrite(value, super._favoriteBooks, () {
      super._favoriteBooks = value;
    });
  }

  late final _$loadBooksAsyncAction =
      AsyncAction('_BooksStore.loadBooks', context: context);

  @override
  Future<List<Book>> loadBooks() {
    return _$loadBooksAsyncAction.run(() => super.loadBooks());
  }

  late final _$toggleFavoriteAsyncAction =
      AsyncAction('_BooksStore.toggleFavorite', context: context);

  @override
  Future<void> toggleFavorite(Book book) {
    return _$toggleFavoriteAsyncAction.run(() => super.toggleFavorite(book));
  }

  late final _$_BooksStoreActionController =
      ActionController(name: '_BooksStore', context: context);

  @override
  void loadFavorites() {
    final _$actionInfo = _$_BooksStoreActionController.startAction(
        name: '_BooksStore.loadFavorites');
    try {
      return super.loadFavorites();
    } finally {
      _$_BooksStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favoriteBooks: ${favoriteBooks},
books: ${books}
    ''';
  }
}
