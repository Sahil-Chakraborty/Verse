import 'package:flutter/material.dart';

import 'package:get/route_manager.dart';
import 'package:verse/utils/helper.dart';

class ShowImage extends StatelessWidget {
  final String image = Get.arguments;
  ShowImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.network(
          getS3Url(image),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}