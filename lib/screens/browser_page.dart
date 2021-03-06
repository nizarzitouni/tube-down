import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../widgets/bottom_sheet.dart';
import '../services/downloader.dart';
import '../services/theme.dart';

class BrowserPage extends StatefulWidget {
  const BrowserPage({Key? key}) : super(key: key);

  @override
  State<BrowserPage> createState() => _BrowserPageState();
}

class _BrowserPageState extends State<BrowserPage> {
  final link = 'https://m.youtube.com/';
  WebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _webViewController!.canGoBack()) {
          _webViewController!.goBack();
        }
        return false;
      },
      child: Scaffold(
        body: WebView(
          initialUrl: link,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController controller) {
            setState(() {
              _webViewController = controller;
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: redish,
          onPressed: () async {
            //print(await _webViewController!.currentUrl());
            final url = await _webViewController!.currentUrl();
            final title = await _webViewController!.getTitle();

            if (url == "https://m.youtube.com/") {
              selectVidSnackBar();
              return;
            } else {
              _choseQuality(url!, title!);
            }
          },
          child: Icon(Icons.download),
        ),
      ),
    );
  }

  void _choseQuality(String url, String title) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 4),
          width: 200, //SizeConfig.screenWidth,
          height: 350, //SizeConfig.screenHeight * 0.8,

          color: Color(0xff202020),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  height: 6,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              BuiltBottomSheet(
                label: '360p',
                onTap: () {
                  //360p
                  Downloader().downloadVideo(url, title, 18);
                  Get.back();
                  _snackBBar();
                },
                clr: blueDatk,
              ),
              BuiltBottomSheet(
                label: '480',
                onTap: () {
                  //480
                  Downloader().downloadVideo(url, title, 83);
                  Get.back();
                  _snackBBar();
                },
                clr: blueDatk,
              ),
              BuiltBottomSheet(
                label: '720p',
                onTap: () {
                  //720p
                  Downloader().downloadVideo(url, title, 22);
                  Get.back();
                  _snackBBar();
                },
                clr: blueDatk,
              ),
              BuiltBottomSheet(
                label: '1080p',
                onTap: () {
                  //1080p
                  Downloader().downloadVideo(url, title, 37);
                  Get.back();
                  _snackBBar();
                },
                clr: blueDatk,
              ),
              Divider(
                color: Get.isDarkMode ? Colors.grey[600] : darkGreyClr,
              ),
              BuiltBottomSheet(
                label: 'Cancel',
                onTap: () {
                  Get.back();
                },
                clr: redish,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _snackBBar() {
    Get.snackbar(
      "SUCCESS",
      "Your Video is being downloading, Slide Down to see progress",
      icon: Icon(Icons.person, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      borderRadius: 10,
      margin: EdgeInsets.all(10),
    );
  }

  void selectVidSnackBar() {
    Get.snackbar(
      "Error",
      "Please Select A VideoFirst",
      icon: Icon(Icons.person, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: redish,
      colorText: Colors.white,
      borderRadius: 10,
      margin: EdgeInsets.all(10),
    );
  }
}
