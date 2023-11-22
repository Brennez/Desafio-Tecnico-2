import 'package:book_reader/presentation/stores/books_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../components/book_component.dart';

class FavoriteBooksScreen extends StatefulWidget {
  final BooksStore booksStore;

  const FavoriteBooksScreen({super.key, required this.booksStore});

  @override
  State<FavoriteBooksScreen> createState() => _FavoriteBooksScreenState();
}

class _FavoriteBooksScreenState extends State<FavoriteBooksScreen> {
  @override
  void initState() {
    super.initState();
    widget.booksStore.loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2 / 3.6,
        ),
        itemCount: widget.booksStore.favoriteBooks.length,
        itemBuilder: (context, index) {
          bool isFavorite = widget.booksStore.books[index].isFavorite;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {},
              child: BookComponent(
                booksStore: widget.booksStore,
                index: index,
                isBookFavorite: isFavorite,
              ),
            ),
          );
        },
      ),
    );
  }
}
