import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onLoad; // Callback function to start loading the web view

  const HomeScreen({Key? key, required this.onLoad}) : super(key: key);
  @override
  State<HomeScreen> createState() => _WebAppState();
}

class _WebAppState extends State<HomeScreen> {
  late WebViewController _controller;
  // bool _isLoading = true;
  double progress = 0;


 bool isInternalLink(String url) {
    // Check if the URL starts with the specific internal domain
    return !url.startsWith('https://thescan.in/');
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      if (isInternalLink(url)) {
        // Load internal link in the app
        _controller.loadUrl(url);
      } else {
        // Open external link in the browser
        await launch(url, forceSafariVC: false, forceWebView: false);
      }
    } else {
      throw 'Could not launch $url';
    }
  }
  
  //Bottom bar
  //Links opening controller by the launchUrls function outside scaffold
   int _currentIndex = 0;
  final List<String> _links = [
    'https://teenpattimaster.site/',
    'https://teenpattimaster.site/privacy-policy/',
    
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          _controller.goBack();
          return false;
        } else {
          return false;
        }
      },
      child: SafeArea(
        child: Scaffold(
          
          
          body: RefreshIndicator(
            onRefresh: _refreshWebView,
            child: Stack(
              children: [
                Column(
                  children: [
                    LinearProgressIndicator(
                      value: progress,
                      color:const  Color.fromARGB(255, 243, 120, 243),
                      backgroundColor: Colors.black,
                    ),
                    Expanded(
                      child: WebView(
                        initialUrl: 'https://teenpattimaster.site/',
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (WebViewController webViewController) {
                          _controller = webViewController;
                        },
                       
                        onProgress: (progress) {
                          setState(() {
                            this.progress = progress / 100;
                          });
      
                        },
                        navigationDelegate: (NavigationRequest request) {
                          if (!isInternalLink(request.url)) {
                            launchURL(request.url);
                            return NavigationDecision.prevent;
                          }
                          return NavigationDecision.navigate;
                        },
                      ),
                    ),
                  ],
                ),
               
              ],
            ),
          ),
           bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.privacy_tip),
            label: 'Privacy Policy',
          ),
        ],
//
 currentIndex: _currentIndex,
        onTap: (index) {
          // Use the launch function from url_launcher to open the link
          launchURLS(_links[index]);
          
          
          setState(() {
            _currentIndex = index;
          });}),


        ),
      ),
    );
  }

  Future<void> _refreshWebView() async {
    await _controller.reload();
  }
  //
  //
  void launchURLS(String url) async {
  if (await canLaunch(url)) {
    if (isInternalLink(url)) {
      // Load internal link in the app
      _controller.loadUrl(url);
    } else {
      // Open external link in the browser
      await launch(url, forceSafariVC: false, forceWebView: true);
    }
  } else {
    throw 'Could not launch $url';
  }
}

}