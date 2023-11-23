import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class OpenReaderUseCase {
  final platform = MethodChannel('my_channel');

  bool loading;
  String filePath = "";
  String bookName;
  String downloadUrl;
  String bookId;

  OpenReaderUseCase({
    this.loading = false,
    required this.bookName,
    required this.downloadUrl,
    required this.bookId,
  });

  Dio dio = Dio();

  Future<void> execute(BuildContext context) async {
    print("=====filePath======$filePath");

    if (filePath == "") {
      await download();
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
          "bookId": "${bookId}",
          "href": "/OEBPS/ch06.xhtml",
          "created": 1539934158390,
          "locations": {"cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"}
        }),
      );
    }
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

  download() async {
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
    loading = true;
    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    String path = appDocDir!.path + '/$bookName.epub';
    File file = File(path);

    if (!File(path).existsSync()) {
      await file.create();
      await dio.download(
        downloadUrl,
        path,
        deleteOnError: true,
        onReceiveProgress: (receivedBytes, totalBytes) {
          print('Download --- ${(receivedBytes / totalBytes) * 100}');
          loading = true;
        },
      ).whenComplete(() {
        loading = false;
        filePath = path;
      });
    } else {
      loading = false;
      filePath = path;
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
}
