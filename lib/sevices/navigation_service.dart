import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:verse/views/home/home_page.dart';
import 'package:verse/views/notification/notifications.dart';
import 'package:verse/views/profile/profile.dart';
import 'package:verse/views/search/search.dart';
import 'package:verse/views/thread/add_thread.dart';

class NavigationService extends GetxService
{
  var currentIndex=0.obs;
  var previousIndex = 0.obs;



  List<Widget> pages(){
    return[
        HomePage(),
       const Search(),
        AddThread(),
       const Notifications(),
       const Profile(),
    ];
  }


  void updateIndex(int index)
  {
   previousIndex.value=currentIndex.value;
   currentIndex.value= index;
  }

  void backToPrevPage() {
    currentIndex.value = previousIndex.value;
  }

}