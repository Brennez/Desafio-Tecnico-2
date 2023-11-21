import 'package:book_reader/domain/use_cases/get_books_usecase.dart';
import 'package:book_reader/domain/use_cases/toggle_favorite_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../stores/books_store.dart';

class BooksViewerScreen extends StatefulWidget {
  const BooksViewerScreen({super.key});

  @override
  State<BooksViewerScreen> createState() => _BooksViewerScreenState();
}

class _BooksViewerScreenState extends State<BooksViewerScreen> {
  late BooksStore booksStore;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    booksStore = BooksStore(
      getBooksUseCase: GetBooksUseCaseImpl(),
      toggleFavoriteUseCase: ToggleFavoriteUseCaseImpl(),
    );

    booksStore.loadBooks().then((value) {
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
              itemCount: booksStore.books.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        Container(
                          height: 180,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.network(
                                booksStore.books[index].cover_url,
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                booksStore.books[index].title,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                booksStore.books[index].author,
                                maxLines: 1,
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
