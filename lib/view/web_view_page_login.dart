import 'package:flutter/foundation.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
            debuggingEnabled: kDebugMode,
            initialUrl: widget.initialUrl,
            javascriptMode: JavascriptMode.unrestricted,
            navigationDelegate: _onWebViewUrlChange),
      ),
    );
  }

  NavigationDecision _onWebViewUrlChange(NavigationRequest request) {
    if (widget.onUrlChanged != null) {
      widget.onUrlChanged!.call(request.url);
    }
    return NavigationDecision.navigate;
  }

  @override
  void dispose() {
    if (widget.onPageDispose != null) {
      widget.onPageDispose!.call();
    }
    super.dispose();
  }
}
