import 'package:flutter/material.dart';
import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:hydrophonic/utils/color_palette.dart';

class StatusCard extends StatefulWidget {
  final String title;
  final List<Map<String, String>> statusData;
  final String updateTime;
  final String videoUrl; // URL for the timelapse video
  final String photoFolder; // Path to the photo folder in assets

  const StatusCard({
    Key? key,
    required this.title,
    required this.statusData,
    required this.updateTime,
    required this.videoUrl,
    required this.photoFolder,
  }) : super(key: key);

  @override
  _StatusCardState createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard> {
  late CachedVideoPlayerPlusController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController =
        CachedVideoPlayerPlusController.networkUrl(Uri.parse(widget.videoUrl))
          ..initialize().then((_) {
            _videoController.play();
            setState(() {}); // Ensure the first frame is shown
          });
  }

  @override
  void dispose() {
    _videoController
        .dispose(); // Dispose of the video controller to free resources
    super.dispose();
  }

  void _showVideoPlayer(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_videoController.value.isInitialized)
                  AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: CachedVideoPlayerPlus(_videoController),
                  )
                else
                  const CircularProgressIndicator(),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPhotoCarousel(BuildContext context) {
    // Here we assume you have a list of image paths in the folder
    final List<String> imagePaths = [
      '${widget.photoFolder}/image1.jpg',
      '${widget.photoFolder}/image2.jpg',
      // Add more images as needed
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 300, // Adjust height as needed
                  child: PageView.builder(
                    itemCount: imagePaths.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        widget.photoFolder,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
            image: AssetImage('assets/images/statusCardBg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                widget.updateTime,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              itemCount: widget.statusData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio:
                    1.5, // Adjusted the aspect ratio to increase height
              ),
              itemBuilder: (context, index) {
                final data = widget.statusData[index];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        data['value']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Flexible(
                      child: Text(
                        data['label']!, // The label part
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold, // Bold the label
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset('assets/images/video.png'),
                  ), // Use your timelapse icon here
                  onPressed: () {
                    _showVideoPlayer(context);
                  },
                ),
                IconButton(
                  icon: SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset('assets/images/image.png'),
                  ), // Use your photos icon here
                  onPressed: () {
                    _showPhotoCarousel(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
