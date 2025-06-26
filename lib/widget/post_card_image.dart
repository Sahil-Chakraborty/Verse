import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verse/models/post_model.dart';
import 'package:verse/route/route_names.dart';

import 'package:verse/utils/helper.dart';

class PostCardImage extends StatelessWidget {
  final PostModel post;
  final String url;
  const PostCardImage({required this.url,required this.post,super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(constraints: BoxConstraints(
                      maxHeight: context.height *0.60,
                      maxWidth: context.width *0.80,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: GestureDetector
                      (
                        onTap: () => Get.toNamed(RouteNames.showThread,arguments: post.id),
                        child: Image.network(getS3Url(url),fit: BoxFit.cover,alignment: Alignment.topCenter,)),
                    ),);
  }
}