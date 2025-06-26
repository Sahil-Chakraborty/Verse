import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verse/sevices/supabase_service.dart';
import 'package:verse/utils/helper.dart';


class ReplyController extends GetxController
{
  

   final TextEditingController replyController= TextEditingController(text: ""); 
   var loading = false.obs;
   var reply = "".obs;

   void addReply(String userId,int postId,String postUserId) async
   {
    try 
    {
      loading.value=true;

      await SupabaseService.client.rpc("comment_increment",params: {"count":1,"row_id": postId});


       await SupabaseService.client.from("notifications").insert({
        "user_id": userId,
        "notification": "replied on your post.",
        "to_user_id": postUserId,
        "post_id": postId,
      });

       await SupabaseService.client
          .from("comments")
          .insert({"post_id": postId, "user_id": userId, "reply": reply.value});
      loading.value = false;
      Get.back();
      showSnackBar("Success", "Replied successfully!");
       

    }catch(e)
    {
      loading.value = false;
      showSnackBar("Error", "Something went wrong.please try again!");
    }
   }
   @override
  void onClose() {
    replyController.dispose();
    super.onClose();
  }
}