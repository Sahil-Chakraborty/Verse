import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:verse/controllers/thread_controller.dart';
import 'package:verse/sevices/navigation_service.dart';
import 'package:verse/sevices/supabase_service.dart';

class AddThreadAppbar extends StatelessWidget {
   AddThreadAppbar({super.key});
  final ThreadController controller=Get.find<ThreadController>();

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(
                color: Colors.grey,
              ))
            ),
            child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
              children: [
                
                Row(
                  children: [
                    IconButton(onPressed: (){
                      Get.find<NavigationService>().backToPrevPage();
                    }, icon:Icon(Icons.close),),
                SizedBox(width: 10,),
                Text("New Verse",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  ],
                ),
                
                Obx(
                  ()=> TextButton(onPressed: (){
                    if(controller.content.value.isNotEmpty)
                    {
                      controller.store(Get.find<SupabaseService>().currentUser.value!.id);
                    }
                  }, child:controller.loading.value? const SizedBox(height: 16,width: 16,): Text("Post",style: TextStyle(fontSize: 20,fontWeight: controller.content.value.isNotEmpty? FontWeight.bold:FontWeight.normal),
                  ),
                  ),
                )
              ],
            ),
          );
  }
}