import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import 'package:get/route_manager.dart';
import 'package:verse/controllers/thread_controller.dart';
import 'package:verse/models/post_model.dart';
import 'package:verse/route/route_names.dart';
import 'package:verse/sevices/supabase_service.dart';

class PostCardBottomBar extends StatefulWidget {
  final PostModel post;
  const PostCardBottomBar({required this.post,super.key});

  @override
  State<PostCardBottomBar> createState() => _PostCardBottomBarState();
}

class _PostCardBottomBarState extends State<PostCardBottomBar> {
 final ThreadController controller = Get.put(ThreadController());
  final SupabaseService supabaseService = Get.find<SupabaseService>();
 String likeStatus = "";

  void likeDislike(String status) async {
    setState(() {
      likeStatus = status;
    });
    if (likeStatus == "0") {
      widget.post.likes = [];
    }
    await controller.likeDislike(status, widget.post.id!, widget.post.userId!,
        supabaseService.currentUser.value!.id);
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
                      children: [
                        likeStatus == "1" || widget.post.likes!.isNotEmpty ?
                 IconButton(
                    onPressed: () {
                      likeDislike("0");
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red[700]!,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      likeDislike("1");
                    },
                    icon: const Icon(Icons.favorite_outline),
                  ),
                        IconButton(onPressed: (){
                          Get.toNamed(RouteNames.addReply,arguments: widget.post);
                        }, 
                        icon: Icon(Icons.chat_bubble_outline),
                        
                        ),
                        IconButton(onPressed: (){}, 
                        icon: Icon(Icons.send_outlined),
                        
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Text("  ${widget.post.likeCount} Likes",style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(width: 10,),
                        Text("${widget.post.commentCount} replies",style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
      ],
    );
  }
}