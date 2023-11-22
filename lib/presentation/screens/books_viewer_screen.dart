import 'package:book_reader/main.dart';
import 'package:book_reader/presentation/components/book_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../stores/books_store.dart';

class BooksViewerScreen extends StatefulWidget {
  final BooksStore booksStore;
  const BooksViewerScreen({super.key, required this.booksStore});

  @override
  State<BooksViewerScreen> createState() => _BooksViewerScreenState();
}

class _BooksViewerScreenState extends State<BooksViewerScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    widget.booksStore.loadBooks().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Observer(
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          )
        : Observer(
            builder: (context) => GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2 / 3.6,
              ),
              itemCount: widget.booksStore.books.length,
              itemBuilder: (context, index) {
                bool isFavorite = widget.booksStore.books[index].isFavorite;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: BookComponent(
                      booksStore: booksStore,
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
