

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:verse/models/comment_model.dart';
import 'package:verse/models/post_model.dart';
import 'package:verse/models/user_model.dart';
import 'package:verse/sevices/supabase_service.dart';


class HomeController  extends GetxController{
  var loading=false.obs;
  RxList<PostModel> posts = RxList<PostModel>();
  var postLoading = false.obs;
  var replyLoading = false.obs;
  RxList<ReplyModel?> replies = RxList<ReplyModel?>();
  var userLoading = false.obs;
  Rx<UserModel?> user = Rx<UserModel?>(null);
  @override
  void onInit() async {
    await fetchThreads();
    listenChanges();
    super.onInit();
  }
 
  void listenChanges() async{
   SupabaseService.client.channel('public:posts').onPostgresChanges(
        event: PostgresChangeEvent.insert,
        schema: 'public',
        table: 'posts',
        callback: (payload) {
          print('Change received: ${payload.toString()}');
          final PostModel post=PostModel.fromJson(payload.newRecord);
          updateFeed(post);
        }).onPostgresChanges(
        event: PostgresChangeEvent.delete,
        schema: 'public',
        table: 'posts',
        callback: (payload) {
          posts.removeWhere((element) => element.id == payload.oldRecord['id']);
        })
    .subscribe();
  }

   void updateFeed(PostModel post) async {
    var user = await SupabaseService.client
        .from("users")
        .select("*")
        .eq("id", post.userId!)
        .single();

        post.likes = [];
    post.user = UserModel.fromJson(user);
    posts.insert(0, post);
    
  }

  



   
 Future<void> fetchThreads() async
  {
     loading=true.obs;
     final List<dynamic> response= await SupabaseService.client.from("posts").select('''
    id,content,image,created_at,comment_count,like_count,user_id,
    user:user_id (email,metadata) , likes:likes (user_id ,post_id)''').order("id", ascending: false);
loading.value=false;
if(response.isNotEmpty)
{
  posts.value=[
    for(var item in response)
    PostModel.fromJson(item),
  ];
}
  }
}