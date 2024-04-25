import 'package:aiseek/core/commons/globals.dart';
import 'package:flutter/material.dart';
import 'package:aiseek/core/commons/app_constants.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../widgets/bottom_navigation.dart';

class GenericWebviewPage extends StatefulWidget {
  final String url;
  final String title;
  final String showBack;

  const GenericWebviewPage({Key? key, this.url = '', this.title = '', this.showBack = 'true'}) : super(key: key);

  @override
  State<GenericWebviewPage> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<GenericWebviewPage> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    // if (Platform.isIOS) WebView.platform = CupertinoWebView();
  }

  @override
  Widget build(BuildContext context) {


    Globals.printDebug(inText: 'werdf' + widget.url.toString());
    final defaultColorScheme = Theme.of(context).colorScheme;

    
    
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(defaultColorScheme.background)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            // Globals.printDebug(inText: widget.url.toString());
            Globals.printDebug(inText: progress.toString());
            // if (progress == 100) {
            //   // setState(() {
            //   //   isLoading = false;
            //   // });
            // }
          },
          onPageStarted: (String url) {
            Globals.printDebug(inText: 'onPageStarted WebView onPageStarted url = $url');
          },
          onPageFinished: (String url) {
            isLoading = false;
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.url.toString()));
    

    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: Text(widget.title, style: TextStyle(
            color: defaultColorScheme.onBackground,
            fontSize: 18,
            fontWeight: FontWeight.bold
          )),
        flexibleSpace: Container(decoration: BoxDecoration(color: defaultColorScheme.background)),
        centerTitle: true,
        leading: (widget.showBack == 'true') ? IconButton(
          icon: Icon(Icons.arrow_back, color: defaultColorScheme.onBackground),
          onPressed: () {
            return context.pop();
          },
        ) : null,
      ),
      bottomNavigationBar: BottomNavWidget(),
      body: Container(
        decoration: BoxDecoration(color: defaultColorScheme.background),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  WebViewWidget(controller: controller),
                  // isLoading
                  //     ? Center(
                  //         child: CircularProgressIndicator(),
                  //       )
                  //     : Stack(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // _loadHtmlFromAssets() async {
  //   String fileText = await rootBundle.loadString(url);
  //   wv_controller.loadUrl(Uri.dataFromString(fileText, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString());
  // }
}
