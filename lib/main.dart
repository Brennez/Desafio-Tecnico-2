import 'package:book_reader/data/repositories/favorite_repository_impl.dart';
import 'package:book_reader/domain/use_cases/get_books_usecase.dart';
import 'package:book_reader/domain/use_cases/toggle_favorite_use_case.dart';
import 'package:book_reader/presentation/screens/books_viewer_screen.dart';
import 'package:book_reader/presentation/screens/favorite_books_screen.dart';
import 'package:book_reader/presentation/stores/books_store.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Reader',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff7A7DD3)),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

BooksStore booksStore = BooksStore(
  getBooksUseCase: GetBooksUseCaseImpl(),
  toggleFavoriteUseCase: ToggleFavoriteUseCaseImpl(
    favoriteRepository: FavoriteRepositoryImpl(),
  ),
);

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Widget> _tabs = [
    BooksViewerScreen(booksStore: booksStore),
    FavoriteBooksScreen(booksStore: booksStore),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff7A7DD3),
          elevation: 0,
          bottom: const TabBar(tabs: [
            Tab(
              child: Text(
                'Livros',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Tab(
              child: Text(
                'Favoritos',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            )
          ]),
        ),
        body: TabBarView(
          viewportFraction: 1.0,
          children: _tabs,
        ),
      ),
    );
  }
}
