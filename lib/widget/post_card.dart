import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verse/models/post_model.dart';
import 'package:verse/route/route_names.dart';
import 'package:verse/utils/type_def.dart';

import 'package:verse/widget/cirlcle_image.dart';
import 'package:verse/widget/post_bottom_bar.dart';
import 'package:verse/widget/post_card_image.dart';
import 'package:verse/widget/post_topbar.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final bool isAuthCard;
  final DeleteCallback? callback;
  const PostCard({required this.post, this.isAuthCard=false,this.callback,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: context.width * 0.12,
              child: CirlcleImage(url: post.user?.metadata?.image),
              ),
              const SizedBox(width: 10,),
              SizedBox(width:  context.width * 0.80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PostTopbar(post: post, isAuthCard: isAuthCard,callback: callback,),
                  GestureDetector(
                    onTap:() => Get.toNamed(RouteNames.showThread,arguments: post.id),
                    child: Text(post.content!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
                  const SizedBox(height: 10,),
                  if(post.image!=null)
                  
                    PostCardImage(url: post.image!,post: post),
                    PostCardBottomBar(post: post),
                  
                  
                ],
                
              ),
              ),
            ],
          ),Divider(color: Color(0xff242424),)
        ],
      ),
    );
  }
}