import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:hydrophonic/screens/home_tab.dart';
import 'package:hydrophonic/screens/plants_tab.dart';
import 'package:hydrophonic/screens/statistics_tab.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'controls_tab.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabItems = [
    const HomeTab(),
    const PlantsTab(),
    const StatisticsTab(),
    const ControlsTab(),
  ];



  List<dynamic> predictions = [];

  void _showSuccessDialog(String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Your Image'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.file(File(imagePath)), // Display the captured image
              SizedBox(height: 10),
              Text(
                predictions.isNotEmpty && predictions[0]['class'] != null
                    ? predictions[0]['class']
                    : 'Can not detect.'
              ),            ],
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }




  final ImagePicker _picker = ImagePicker();

  Future<void> _takePictureAndUpload() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo == null) return;

    File imageFile = File(photo.path);

    // Convert to JPG
    final image = img.decodeImage(imageFile.readAsBytesSync());
    final jpg = img.encodeJpg(image!);

    // Get temporary directory
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/temp_image.jpg');

    // Write the JPG image to a file
    await tempFile.writeAsBytes(jpg);

    // Read the file as base64 encoded string (without the MIME type prefix)
    String base64Image = base64Encode(await tempFile.readAsBytes());

    // Prepare the request URL with API key as query parameter
    final url = Uri.parse('https://detect.roboflow.com/lettuce-disease-detection-zdd8k/1?api_key=NDsh01m71LfhdiPoxXcb');

    // Make the POST request
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: base64Image,  // Send the raw base64 string as body
    );

    _showSuccessDialog(tempFile.path);

    if (response.statusCode == 200) {
      print('Upload successful: ${response.body}');
      final result = jsonDecode(response.body);
      setState(() {
        predictions = result['predictions'];
        print(predictions);
      });
    } else {
      print('Upload failed: ${response.statusCode} ${response.body}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hydroponic'),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () async {

              var id = await OneSignal.User.getOnesignalId();
              print(id!);

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Notifications'),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                            'Your Notification ID:\n'+id,
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                          Text("\nNo New Notifications!")
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                    ],
                  );
                },
              );

            },
          ),

          IconButton(onPressed: (){

            _takePictureAndUpload();

          }, icon: Icon(Icons.camera_alt, color: Colors.black))
        ],
      ),

      body: _tabItems[_selectedIndex],
      bottomNavigationBar: FlashyTabBar(
        animationCurve: Curves.linear,
        selectedIndex: _selectedIndex,
        iconSize: 30,
        showElevation: false, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.local_florist),
            title: const Text('Plants'),
          ),
          FlashyTabBarItem(
              icon: const Icon(Icons.bar_chart),
              title: const Text('Statistics')),
          FlashyTabBarItem(
              icon: const Icon(Icons.games_outlined),
              title: const Text('Controls')),

        ],
      ),
    );
  }
}
