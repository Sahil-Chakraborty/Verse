import 'package:flutter/material.dart';

import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:verse/controllers/home_controller.dart';
import 'package:verse/widget/loading.dart';
import 'package:verse/widget/post_card.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomeController controller= Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(10),
      child: RefreshIndicator(
        onRefresh: () => controller.fetchThreads(),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Padding(padding: const EdgeInsets.only(top:10),
              child: Image.asset("assets/images/logo.png",width: 50,height: 50,),
              ),centerTitle: true,
              
            ),
            SliverToBoxAdapter(
              child: Obx(()=> controller.loading.value? Loading():ListView.builder
              (
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: controller.posts.length ,
                itemBuilder: (context,index) => PostCard(post: controller.posts[index],isAuthCard: false,),
        
                ),
                ),
            )
          ],
        ),
      ),
      ),
    );
  }
}