import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPageLogin extends StatefulWidget {
  final String initialUrl;
  final Function(String url)? onUrlChanged;
  final VoidCallback? onPageDispose;

  const WebViewPageLogin({Key? key, required this.initialUrl, this.onUrlChanged, this.onPageDispose}) : super(key: key);

  @override
  _WebViewPageLoginState createState() => _WebViewPageLoginState();
}

class _WebViewPageLoginState extends State<WebViewPageLogin> {

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
            zoomEnabled: false,
            gestureNavigationEnabled: true,
            //gestureRecognizers: Set()..add(Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer())),
            debuggingEnabled: kDebugMode,
            initialUrl: widget.initialUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: !Platform.isIOS ? _onPageFinished : null,
            navigationDelegate: Platform.isIOS ? _onWebViewUrlChange : null
        ),
      ),
    );
  }

  NavigationDecision _onWebViewUrlChange(NavigationRequest request) {
    if (widget.onUrlChanged != null) {
      widget.onUrlChanged!.call(request.url);
    }
    return NavigationDecision.navigate;
  }

  void _onPageFinished(String url) {
    if (widget.onUrlChanged != null) {
      widget.onUrlChanged!.call(url);
    }
  }


  @override
  void dispose() {
    if (widget.onPageDispose != null) {
      widget.onPageDispose!.call();
    }
    super.dispose();
  }
}
