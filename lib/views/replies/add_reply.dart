import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:verse/controllers/reply_controller.dart';
import 'package:verse/models/post_model.dart';
import 'package:verse/sevices/supabase_service.dart';

import 'package:verse/widget/cirlcle_image.dart';

import 'package:verse/widget/post_card_image.dart';

class AddReply extends StatelessWidget {
   AddReply({super.key});
  final PostModel post = Get.arguments;
  final ReplyController controller= Get.put(ReplyController());
  final SupabaseService supabaseService= Get.find<SupabaseService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      leading: IconButton(onPressed: ()=> Get.back(), icon: Icon(Icons.close),
      
      ),
      title: Text("Reply"),
      actions: [
        Obx(
          ()=> TextButton(onPressed: (){
            if(controller.reply.isNotEmpty)
            {
              controller.addReply(supabaseService.currentUser.value!.id, post.id!, post.userId!);
            }
          }, child:controller.loading.value ? SizedBox(height: 16,width: 16,child: CircularProgressIndicator(),) :Text("Reply", style: TextStyle(fontWeight: controller.reply.isNotEmpty ? FontWeight.bold:FontWeight.normal),),),
        )
      ],
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
         Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: context.width *0.12,
            child: CirlcleImage(url: post.user?.metadata!.image,),
            ),
            SizedBox(width: 10,),
            SizedBox(
              width: context.width *0.80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.user!.metadata!.name!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  Text(post.content!,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  if(post.image!=null)
                  PostCardImage(url: post.image!,post: post,),

                  TextField(
                    autofocus: true,
                    controller: controller.replyController,
                    onChanged: (value)=>controller.reply.value= value,
                    style: TextStyle(fontSize: 16),
                    maxLines: 10,
                    minLines: 1,
                    maxLength: 1000,
                    decoration: InputDecoration(
                      hintText: "Add reply",
                      border: InputBorder.none,
                    ),
                  )
                ],
              ),
            )
          ],
         )
        ],
      ),
    ),
    );
  }
}