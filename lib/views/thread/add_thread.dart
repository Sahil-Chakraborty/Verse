import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:verse/controllers/thread_controller.dart';

import 'package:verse/sevices/supabase_service.dart';
import 'package:verse/widget/add_thread_appbar.dart';
import 'package:verse/widget/cirlcle_image.dart';
import 'package:verse/widget/thread_image_priview.dart';

class AddThread extends StatefulWidget {

  const AddThread({super.key});

 
 


  @override
  State<AddThread> createState() => _AddThreadState();
}

class _AddThreadState extends State<AddThread> {
  final ThreadController controller = Get.put(ThreadController());
  final SupabaseService supabaseService= Get.find<SupabaseService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SafeArea(child: 
     SingleChildScrollView(
      child: Column(
        children: [
          AddThreadAppbar(),
         SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(()=> CirlcleImage(radius: 25,
                 url: supabaseService.currentUser.value?.userMetadata?["image"],
                ),
                ),
                
                SizedBox(width: 10,),
                SizedBox(width: context.width *0.80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(supabaseService.currentUser.value!.userMetadata?["name"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    TextField(
                            autofocus: true,
                            controller: controller.textEditingController,
                            onChanged: (value) =>
                                controller.content.value = value,
                            style: const TextStyle(fontSize: 16),
                            maxLines: 10,
                            minLines: 1,
                            maxLength: 1000,
                            decoration: const InputDecoration(
                              hintText: 'type a thread',
                              border: InputBorder.none, // Remove border
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>controller.pickImage(),
                            child: Icon(Icons.add_box_outlined),),
                            Obx(
                              ()=> Column(
                                children: [
                                  if(controller.image.value != null)
                                  ThreadImagePriview(),
                                ],
                              ),
                            )
                  ],
                ),
                
                ),
                
            
            
              ],
            ),
          )
        ],
      ),
     )),
    );
  }
}