import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:verse/models/post_model.dart';
import 'package:verse/route/route_names.dart';
import 'package:verse/utils/helper.dart';
import 'package:verse/utils/type_def.dart';

class PostTopbar extends StatelessWidget {
  final PostModel post;
  final bool isAuthCard;
  final DeleteCallback? callback;
  const PostTopbar({required this.post, this.isAuthCard = false,this.callback,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector
                      
                      (onTap: () => Get.toNamed(RouteNames.showProfile , arguments:post.userId),
                        child: Text(post.user!.metadata!.name!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
                      Row(
                        children: [
                          Text(formateDateFromNow(post.createdAt!),style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14),),
                          SizedBox(width: 10,),
                          
                           isAuthCard? GestureDetector(onTap: ()  {
                            confirmDialog("Are you sure ?", "Once deleted , it won't be retrieved",() => callback!(post.id!));
                           },child: Icon(Icons.delete,color: Colors.red,),) : Icon(Icons.more_horiz)
                        ],
                      )
                    ],
                  );
  }
}