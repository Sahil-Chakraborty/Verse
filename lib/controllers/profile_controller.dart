
import 'dart:io';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:verse/models/comment_model.dart';
import 'package:verse/models/post_model.dart';
import 'package:verse/models/user_model.dart';
import 'package:verse/sevices/supabase_service.dart';
import 'package:verse/utils/env.dart';
import 'package:verse/utils/helper.dart';

class ProfileController extends GetxController
{
  
  Rx<File?> image = Rx<File?>(null);
  var loading = false.obs;
  RxList<PostModel> posts = RxList<PostModel>();
   var postLoading = false.obs;
   var replyLoading = false.obs;
  RxList<ReplyModel?> replies = RxList<ReplyModel?>();
  var userLoading = false.obs;
  Rx<UserModel?> user = Rx<UserModel?>(null);

 

  Future<void> updateProfile (String userId,String description) async{
    try{
      loading.value=true;
      var uploadedPath="";
      if(image.value!=null && image.value!.existsSync()){
        final String dir = "$userId/profile.jpg";
      var path = await SupabaseService.client.storage.from(Env.s3Bucket).upload(dir, image.value!,fileOptions:FileOptions(upsert: true),);
      uploadedPath=path;
      }
     await SupabaseService.client.auth.updateUser(UserAttributes(
      data: {
        "description":description,
        "image":uploadedPath.isNotEmpty?uploadedPath:null,
      }
     ));

     loading.value=false;
     Get.back();
     showSnackBar("Success", "Srofile updated successfully.");
    }on StorageException catch(error)
    {
      loading.value=false;
       showSnackBar("Error", error.message);
    }on AuthApiException catch(error)
    {
      loading.value=false;
      showSnackBar("Error", "Something went wrong, please try again.");

    }
  }





  void pickImage() async
  {
     File? file= await pickImageFromGallery();
     if( file != null)
     {
      image.value= file;
     }
  }

   Future<void> fetchUserThreads(String userId) async {
    try{
      postLoading.value = true;
    final List<dynamic> response=
        await SupabaseService.client.from("posts").select('''id ,content ,image ,created_at ,comment_count,like_count,user:user_id (email , metadata) , likes:likes (user_id ,post_id)''').eq("user_id", userId).order("id", ascending: false);

    postLoading.value = false;
    if (response.isNotEmpty) {
      posts.value = [for (var item in response) PostModel.fromJson(item)];
    }
    }catch(e)
    {
      postLoading.value=false;
      showSnackBar("Error","Something went wrong" );
    }
    
  }

   Future<void> fetchReplies(String userId) async {
    try{
      replyLoading.value = true;
    final List<dynamic> response =
        await SupabaseService.client.from("comments").select('''id ,user_id ,post_id ,reply ,created_at ,user:user_id (email , metadata)''').eq("user_id", userId).order("id", ascending: false);
       
    replyLoading.value = false;
    
    if(response.isNotEmpty)
    {
      replies.value = [for (var item in response) ReplyModel.fromJson(item)];
    }
    }catch(e)
    {
      replyLoading.value=false;
      showSnackBar("Error", "Something went wrong");
    }
    
  }

  Future<void> deleteThread(int postId) async {
    try {
      
      await SupabaseService.client.from("posts").delete().eq("id", postId);

      posts.removeWhere((element) => element.id == postId);
      if (Get.isDialogOpen == true) Get.back();
      
      
      showSnackBar("Success", "thread deleted successfully!");
    } catch (e) {
      
      showSnackBar("Error", "Something went wrong.pls try again.");
    }
  }

  // * Delete thread
  Future<void> deleteReply(int replyId) async {
    try {
      
      await SupabaseService.client.from("comments").delete().eq("id", replyId);

      replies.removeWhere((element) => element?.id == replyId);
      if (Get.isDialogOpen == true) Get.back();
        
      
      
      showSnackBar("Success", "Reply deleted successfully!");
    } catch (e) {
      
      showSnackBar("Error", "Something went wrong.pls try again.");
    }
  }


  


  Future<void> fetchUser(String userId) async {
    userLoading.value = true;
    var response = await SupabaseService.client
        .from("users")
        .select("*")
        .eq("id", userId)
        .single();
    userLoading.value = false;
    user.value = UserModel.fromJson(response);

    // * Fetch posts and comments
    fetchPosts(userId);
    fetchComments(userId);
  }


   Future<void> fetchPosts(String userId) async {
    postLoading.value = true;
    final List<dynamic> data =
        await SupabaseService.client.from("posts").select('''
    id ,content , image ,created_at ,comment_count,like_count,
    user:user_id (email , metadata) , likes:likes (user_id ,post_id)
''').eq("user_id", userId).order("id", ascending: false);

    postLoading.value = false;
    if (data.isNotEmpty) {
      posts.value = [for (var item in data) PostModel.fromJson(item)];
    }
  }

  // * Fetch user replies
  Future<void> fetchComments(String userId) async {
    replyLoading.value = true;
    final List<dynamic> data =
        await SupabaseService.client.from("comments").select('''
        id , user_id , post_id ,reply ,created_at ,user:user_id (email , metadata)
''').eq("user_id", userId).order("id", ascending: false);
    replyLoading.value = false;
    replies.value = [for (var item in data) ReplyModel.fromJson(item)];
  }
}