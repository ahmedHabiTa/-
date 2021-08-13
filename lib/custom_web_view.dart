import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'package:web_view_polytech/home_page.dart';
import 'package:web_view_polytech/local/shared_pref_helper.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'no_internet.dart';

class CustomWebView extends StatefulWidget {
  static const routeName = '/CustomWebView';

  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  bool _isLoading;

  bool webRefreshed = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = true;
  }
  final _key = UniqueKey();
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  void _onRefresh() {
    setState(() {
      webRefreshed = false;
    });
    setState(() {
      webRefreshed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var initialUrl;
    if (webRefreshed) {
      initialUrl = ModalRoute.of(context).settings.arguments;
    } else {
      initialUrl = SharedPrefsHelper.getData(key: 'initialUrl');
    }
    return SafeArea(
      child: Scaffold(
        body: webRefreshed
            ? RefreshIndicator(
                backgroundColor: Colors.blue,
                color: Colors.redAccent,
                onRefresh: () async {
                  var connectivityResult =
                      await (Connectivity().checkConnectivity());
                  if (connectivityResult == ConnectivityResult.none) {
                    return Navigator.of(context)
                        .pushReplacementNamed(NoInternetScreen.routeName);
                  } else {
                    _onRefresh();
                  }
                },
                child: Stack(
                  children: <Widget>[
                    WebView(
                      onPageStarted: (start) {
                        setState(() {
                          _isLoading = true;
                        });
                      },
                      allowsInlineMediaPlayback: true,
                      initialMediaPlaybackPolicy:
                          AutoMediaPlaybackPolicy.always_allow,
                      debuggingEnabled: true,
                      key: _key,
                      initialUrl: initialUrl.toString(),
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (WebViewController webViewController) {
                        _controller.complete(webViewController);
                      },
                      onPageFinished: (finish) {
                        setState(() {
                          _isLoading = false;
                        });
                      },
                    ),
                    if (_isLoading)
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.transparent,
                        height: 50,
                        width: 100,
                        child: ListView(),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
        floatingActionButton: ElevatedButton(
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed(HomePage.routeName),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.orange[300]),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          child: Text(
            'القائمه الرئيسيه',
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
