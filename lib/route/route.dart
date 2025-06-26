


import 'package:get/route_manager.dart';
import 'package:verse/route/route_names.dart';
import 'package:verse/views/auth/login.dart';
import 'package:verse/views/auth/register.dart';
import 'package:verse/views/home.dart';
import 'package:verse/views/profile/edit_profile.dart';
import 'package:verse/views/profile/show_profile.dart';
import 'package:verse/views/replies/add_reply.dart';
import 'package:verse/views/settings/setting.dart';
import 'package:verse/views/thread/show_image.dart';
import 'package:verse/views/thread/show_thread.dart';

class Routes {
  static final pages = [
    GetPage(name: RouteNames.home, page: () => Home()),
    GetPage(name: RouteNames.login, page: () => Login(),transition: Transition.fadeIn),
    GetPage(name: RouteNames.register, page: () => Register(),transition: Transition.fadeIn),
    GetPage(name: RouteNames.editProfile, page: () => EditProfile(),transition: Transition.leftToRight),
    GetPage(name: RouteNames.settings, page: ()=> Setting(),transition: Transition.rightToLeft),
    GetPage(name: RouteNames.addReply, page: ()=> AddReply(),transition: Transition.downToUp),
    GetPage(name: RouteNames.showThread, page: ()=> ShowThread(),transition: Transition.leftToRight),
    GetPage(name: RouteNames.showImage, page: ()=> ShowImage(),transition: Transition.leftToRight),
     GetPage(
      name: RouteNames.showProfile, page: () => const ShowProfile(),
      transition: Transition.leftToRight,
    ),
  ];
}