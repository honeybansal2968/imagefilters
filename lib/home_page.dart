import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostFiltersPage extends StatelessWidget {
  final String imageUrl;

  const PostFiltersPage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 23.h,
            ),
            FutureBuilder<ImageInfo>(
              future: _getImageInfo(imageUrl),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    ImageInfo imageInfo = snapshot.data!;
                    BoxFit fit = _getBoxFit(
                        imageInfo.image.width, imageInfo.image.height);
                    return Container(
                      width: 1.sw,
                      constraints: BoxConstraints(maxHeight: 415.h),
                      child: Image.asset(
                        "assets/images/6981c251f5c5b623f800b011553762e3.jpg",
                        fit: fit,
                      ),
                    );
                  } else {
                    return const Text('Failed to load image');
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<ImageInfo> _getImageInfo(String url) async {
    final Completer<ImageInfo> completer = Completer();
    final Image image =
        Image.asset("assets/images/6981c251f5c5b623f800b011553762e3.jpg");
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(info);
      }),
    );
    return completer.future;
  }

  BoxFit _getBoxFit(int width, int height) {
    if (width > height) {
      return BoxFit.fitWidth; // Landscape
    } else if (height > width) {
      return BoxFit.fitWidth; // Portrait
    } else {
      return BoxFit.cover; // Square
    }
  }

  double _getAspectRatio(int width, int height) {
    if (width > height) {
      return 16 / 9; // Landscape
    } else if (height > width) {
      return 4 / 5; // Portrait
    } else {
      return 1; // Square
    }
  }
}
