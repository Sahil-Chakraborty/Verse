import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:uuid/uuid.dart';
import 'package:verse/utils/env.dart';
import 'package:verse/widget/confirm_dialog.dart';


void showSnackBar(String title, String message)
{
  Get.snackbar(title, message,
  snackPosition: SnackPosition.BOTTOM,
  colorText: Colors.white,
  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
  snackStyle: SnackStyle.GROUNDED,
  margin: EdgeInsets.all(0),
  backgroundColor: const Color.fromARGB(255, 94, 93, 93)
  );
}
Future<File?> pickImageFromGallery() async
{
  const uuid=Uuid();
  final ImagePicker picker= ImagePicker();
  final XFile? file =await picker.pickImage(source: ImageSource.gallery);

  if(file==null)
  {
    return null;
  }
 final dir = Directory.systemTemp;
 final targetPath = "${dir.absolute.path}/${uuid.v6()}.jpg";
 File? image= await compressImage(File(file.path), targetPath);
 return image;
}

Future<File?> compressImage(File file, String targetPath) async{
 var result = await FlutterImageCompress.compressAndGetFile(file.path, targetPath,quality: 75);
 return File(result!.path);
}

String getS3Url(String path)
{
  return"${Env.supabaseUrl}/storage/v1/object/public/$path";
}

void confirmDialog(String title,String text,VoidCallback callback)
{
  Get.dialog(ConfirmDialog(title: title,text: text,callback: callback,));
}


String formateDateFromNow(String date) {
  // Parse UTC timestamp string to DateTime
  DateTime utcDateTime = DateTime.parse(date.split('+')[0].trim());

  // Convert UTC to IST (UTC+5:30 for Indian Standard Time)
  DateTime istDateTime = utcDateTime.add(const Duration(hours: 5, minutes: 30));

  // Format the DateTime using Jiffy
  return Jiffy.parseFromDateTime(istDateTime).fromNow();
}