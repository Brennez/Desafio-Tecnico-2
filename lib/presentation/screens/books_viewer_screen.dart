import 'dart:io';

import 'package:book_reader/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

import '../stores/books_store.dart';

class BooksViewerScreen extends StatefulWidget {
  final BooksStore booksStore;
  const BooksViewerScreen({super.key, required this.booksStore});

  @override
  State<BooksViewerScreen> createState() => _BooksViewerScreenState();
}

class _BooksViewerScreenState extends State<BooksViewerScreen> {
  final platform = MethodChannel('my_channel');

  bool isLoading = true;
  bool loading = false;

  String filePath = "";
  String bookName = "";
  String downloadUrl = "";

  Dio dio = Dio();

  @override
  void initState() {
    super.initState();

    widget.booksStore.loadBooks().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<String?> getAndroidVersion() async {
    try {
      final String version = await platform.invokeMethod('getAndroidVersion');
      return version;
    } on PlatformException catch (e) {
      print("FAILED TO GET ANDROID VERSION: ${e.message}");
      return null;
    }
  }

  Future<void> fetchAndroidVersion() async {
    final String? version = await getAndroidVersion();
    if (version != null) {
      String? firstPart;
      if (version.toString().contains(".")) {
        int indexOfFirstDot = version.indexOf(".");
        firstPart = version.substring(0, indexOfFirstDot);
      } else {
        firstPart = version;
      }
      int intValue = int.parse(firstPart);
      if (intValue >= 13) {
        await startDownload();
      } else {
        final PermissionStatus status = await Permission.storage.request();
        if (status == PermissionStatus.granted) {
          await startDownload();
        } else {
          await Permission.storage.request();
        }
      }
      print("ANDROID VERSION: $intValue");
    }
  }

  Future<void> download() async {
    if (Platform.isIOS) {
      final PermissionStatus status = await Permission.storage.request();
      if (status == PermissionStatus.granted) {
        await startDownload();
      } else {
        await Permission.storage.request();
      }
    } else if (Platform.isAndroid) {
      await fetchAndroidVersion();
    } else {
      PlatformException(code: '500');
    }
  }

  startDownload() async {
    setState(() {
      loading = true;
    });
    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    String path = '${appDocDir!.path}/$bookName.epub';
    File file = File(path);

    if (!File(path).existsSync()) {
      await file.create();
      if (downloadUrl.isNotEmpty) {
        await dio.download(
          downloadUrl,
          path,
          deleteOnError: true,
          onReceiveProgress: (receivedBytes, totalBytes) {
            print('Download --- ${(receivedBytes / totalBytes) * 100}');
            setState(() {
              loading = true;
            });
          },
        ).whenComplete(() {
          setState(() {
            loading = false;
            filePath = path;
          });
        });
      }
    } else {
      setState(() {
        loading = false;
        filePath = path;
      });
    }
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
                    onTap: () async {
                      bookName = booksStore.books[index].title;
                      downloadUrl = booksStore.books[index].download_url;

                      print("=====filePath======$filePath");

                      if (filePath == "") {
                        download();
                      } else {
                        VocsyEpub.setConfig(
                          themeColor: Theme.of(context).primaryColor,
                          identifier: "iosBook",
                          scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
                          allowSharing: true,
                          enableTts: true,
                          nightMode: true,
                        );

                        // get current locator
                        VocsyEpub.locatorStream.listen((locator) {
                          print('LOCATOR: $locator');
                        });

                        VocsyEpub.open(
                          filePath,
                          lastLocation: EpubLocator.fromJson({
                            "bookId": "2239",
                            "href": "/OEBPS/ch06.xhtml",
                            "created": 1539934158390,
                            "locations": {
                              "cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"
                            }
                          }),
                        );
                      }
                    },
                    child: Stack(
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
                        Positioned(
                          left: 60,
                          top: -4,
                          child: IconButton(
                            onPressed: () => booksStore
                                .toggleFavorite(booksStore.books[index]),
                            icon: Icon(
                              isFavorite
                                  ? Icons.bookmark_outlined
                                  : Icons.bookmark_outline,
                              color: isFavorite
                                  ? Colors.red
                                  : const Color(0xff7A7DD3),
                              size: 50,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
