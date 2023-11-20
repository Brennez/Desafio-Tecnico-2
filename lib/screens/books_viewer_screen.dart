import 'package:book_reader/stores/books_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
    widget.booksStore.getBooks().then((_) {
      setState(() => isLoading = false);
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
                                widget.booksStore.books[index].cover_url,
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                            width: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.booksStore.books[index].title,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  widget.booksStore.books[index].author,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
