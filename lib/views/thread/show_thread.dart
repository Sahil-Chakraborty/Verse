import 'package:flutter/material.dart';

import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:verse/controllers/thread_controller.dart';

import 'package:verse/widget/loading.dart';
import 'package:verse/widget/post_card.dart';
import 'package:verse/widget/reply_card.dart';

class ShowThread extends StatefulWidget {
  const ShowThread({super.key});

  @override
  State<ShowThread> createState() => _ShowThreadState();
}

class _ShowThreadState extends State<ShowThread> {
  final int postId = Get.arguments;
  final ThreadController controller = Get.put(ThreadController());

  @override
  void initState() {
    
    controller.show(postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verse"),
      ),
      body: Obx(
        ()=> SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child:  controller.showThreadLoading.value
                ? const Loading()
                : Column(
                    children: [
                      PostCard(post:controller.post.value,isAuthCard: true,),
        
                      const SizedBox(height: 20),
                      // * load thread comments
                      if (controller.loading.value)
                        const Loading()
                      else if (controller.replies.isNotEmpty &&
                          controller.showReplyLoading.value == false)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.replies.length,
                          itemBuilder: (context, index) =>
                              ReplyCard(reply: controller.replies[index]),
                        )
                      else
                        Center(child: const Text("No replies"))
                    ],
                  ),
          
        ),
      ),
    );
  }
}