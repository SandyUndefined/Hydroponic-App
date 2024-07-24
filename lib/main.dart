import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ThingSpeak App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<WebViewController> _webViewControllers = [];
  final List<String> _urls = [
    'https://thingspeak.com/channels/2596664/charts/1?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&round=1&title=Temperature&type=line&yaxis=Celsius',
    'https://thingspeak.com/channels/2596664/charts/2?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&round=1&title=Humidity&type=line&yaxis=%25',
    'https://thingspeak.com/channels/2596664/charts/3?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&round=1&title=Light+Intensity&type=line&yaxis=Lux',
    'https://thingspeak.com/channels/2596664/charts/4?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&title=CO2&type=line&yaxis=ppm',
    'https://thingspeak.com/channels/2596664/charts/5?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&round=1&title=Water+Temperature&type=line&yaxis=Celsius',
    'https://thingspeak.com/channels/2596664/charts/6?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&title=TDS&type=line&yaxis=ppm',
    'https://thingspeak.com/channels/2596664/charts/7?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&title=EC&type=line&yaxis=uS%2Fcm',
    'https://thingspeak.com/channels/2596664/charts/8?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&title=Water+Level&type=line&yaxis=Level'
  ];

  @override
  void initState() {
    super.initState();

    for (String url in _urls) {
      final WebViewController controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (String url) {
              print("Page started loading: $url");
            },
            onPageFinished: (String url) {
              print("Page finished loading: $url");
            },
            onWebResourceError: (WebResourceError error) {
              print("Error loading page: ${error.description}");
            },
          ),
        )
        ..loadRequest(Uri.dataFromString(url));
      _webViewControllers.add(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ThingSpeak Data'),
      ),
      body: ListView.builder(
        itemCount: _webViewControllers.length,
        itemBuilder: (context, index) {
          return Container(
            height: 300,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: WebViewWidget(controller: _webViewControllers[index]),
          );
        },
      ),
    );
  }
}
