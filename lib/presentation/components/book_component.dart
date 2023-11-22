import 'package:flutter/material.dart';

import '../stores/books_store.dart';

class BookComponent extends StatelessWidget {
  final BooksStore booksStore;
  final int index;
  final bool isBookFavorite;

  const BookComponent({
    Key? key,
    required this.booksStore,
    required this.index,
    required this.isBookFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(booksStore.books[index].cover_url,
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
        Positioned(
          left: 60,
          top: -4,
          child: IconButton(
            onPressed: () => booksStore.toogleFavorite(booksStore.books[index]),
            icon: Icon(
              isBookFavorite ? Icons.bookmark_outlined : Icons.bookmark_outline,
              color: isBookFavorite ? Colors.red : const Color(0xff7A7DD3),
              size: 50,
            ),
          ),
        )
      ],
    );
  }
}
