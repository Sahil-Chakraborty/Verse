import 'dart:io';

import 'package:flutter/material.dart';
import 'package:verse/utils/helper.dart';

class CirlcleImage extends StatelessWidget {
  final double radius;
  final String? url;
  final File? file;
  const CirlcleImage({ this.url,this.file,this.radius=25,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
         if (file != null)
          CircleAvatar(
            radius: radius,
            backgroundImage: FileImage(file!),
          )
        else if (url != null)
          CircleAvatar(
            backgroundImage: NetworkImage(getS3Url(url!)),
            radius: radius,
          )
        else
        CircleAvatar(
          radius: radius,
          backgroundImage:AssetImage("assets/images/avatar.png"),
        )
        
      
      ],
      
    );
  }
}