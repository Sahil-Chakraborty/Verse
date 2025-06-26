import 'package:flutter/material.dart';

import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:verse/controllers/notification_controller.dart';
import 'package:verse/route/route_names.dart';
import 'package:verse/sevices/navigation_service.dart';
import 'package:verse/sevices/supabase_service.dart';
import 'package:verse/utils/helper.dart';
import 'package:verse/widget/cirlcle_image.dart';
import 'package:verse/widget/loading.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final NotificationController controller = Get.put(NotificationController());

  @override
  void initState() {
    controller.fetchNotifications(Get.find<SupabaseService>().currentUser.value!.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      leading: IconButton(onPressed: ()=> Get.find<NavigationService>().backToPrevPage(), icon: Icon(Icons.close)),  
      title: Text("Notification"),),
      body: SingleChildScrollView(
        child: Obx(
          ()=> controller.loading.value? Loading(): Column(
            children: [
             if(controller.notifications.isNotEmpty)
             ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: controller.notifications.length,
              itemBuilder:(context,index)=>ListTile(
                onTap:() =>{
                  Get.toNamed(RouteNames.showThread,arguments: controller.notifications[index]?.postId)
                },
                leading: CirlcleImage(
                  url: controller.notifications[index]?.user?.metadata?.image,
                ),
                title: Text(controller.notifications[index]!.user!.metadata!.name!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                trailing: Text(formateDateFromNow(controller.notifications[index]!.createdAt!)),
                subtitle: Text(controller.notifications[index]!.notification!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              ) ,
             )
             else
             Center(child: Text("No Notifications Found!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
            ],
          ),
        )
      ),
    );
  }
}