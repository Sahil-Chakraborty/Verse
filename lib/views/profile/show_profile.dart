import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:verse/controllers/profile_controller.dart';
import 'package:verse/route/route_names.dart';
import 'package:verse/views/profile/profile.dart';
import 'package:verse/widget/cirlcle_image.dart';
import 'package:verse/widget/loading.dart';
import 'package:verse/widget/post_card.dart';
import 'package:verse/widget/reply_card.dart';

class ShowProfile extends StatefulWidget {
  const ShowProfile({super.key});

  @override
  State<ShowProfile> createState() => _ProfileState();
}

class _ProfileState extends State<ShowProfile> {
  final String userId = Get.arguments;
  final ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    controller.fetchUser(userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(RouteNames.settings),
              icon: const Icon(Icons.sort))
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 100,
                collapsedHeight: 100,
                automaticallyImplyLeading: false,
                flexibleSpace: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () => controller.userLoading.value
                                    ? const Loading()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller
                                                .user.value!.metadata!.name!,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                            ),
                                          ),
                                          SizedBox(
                                            width: context.width * 0.60,
                                            child: Text( 
                                              controller.user.value!
                                                .metadata!.description??""),
                                          ),
                                        ],
                                      ),
                              ),
                              Obx(
                                () => CirlcleImage(
                                  url: controller.user.value?.metadata?.image,
                                  radius: 40,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SliverPersistentHeader(
                floating: true,
                pinned: true,
                delegate: SliverAppBarDelegate(
                  const TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Tab(text: 'Threads'),
                      Tab(text: 'Replies'),
                    ],
                  ),
                ),
              )
            ];
          },
          body: TabBarView(
            children: [
              Obx(
                () => SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      if (controller.postLoading.value)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else if (controller.posts.isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.posts.length,
                          itemBuilder: (context, index) =>
                              PostCard(post: controller.posts[index],isAuthCard: true,),
                        )
                      else
                        const Center(
                          child: Text("No Post found"),
                        )
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: Obx(
                  () => controller.replyLoading.value
                      ? const Loading()
                      : Column(
                          children: [
                            const SizedBox(height: 10),
                            if (controller.replies.isNotEmpty)
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.replies.length,
                                itemBuilder: (context, index) => ReplyCard(
                                    reply: controller.replies[index]!),
                              )
                            else
                              const Center(
                                child: Text("No reply found"),
                              )
                          ],
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