import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:verse/controllers/profile_controller.dart';
import 'package:verse/route/route_names.dart';
import 'package:verse/sevices/supabase_service.dart';
import 'package:verse/utils/button_styles.dart';
import 'package:verse/widget/cirlcle_image.dart';
import 'package:verse/widget/reply_card.dart';
import 'package:verse/widget/loading.dart';
import 'package:verse/widget/post_card.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ProfileController controller= Get.put(ProfileController());
  final SupabaseService supabaseService= Get.find<SupabaseService>();

  @override
  void initState() {
    if(supabaseService.currentUser.value?.id !=null)
    {
      controller.fetchUserThreads(supabaseService.currentUser.value!.id);
      controller.fetchReplies(supabaseService.currentUser.value!.id);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Icon(Icons.language),
      centerTitle: false,
      actions: [
        IconButton(onPressed: ()=>Get.toNamed(RouteNames.settings), icon: Icon(Icons.sort))
      ],
      ),
      body: DefaultTabController(length: 2, 
      child: NestedScrollView
      (
        headerSliverBuilder: (context,innerBoxIsScrolled)
        {
          return<Widget>
          [
            SliverAppBar(
              expandedHeight: 160,
              collapsedHeight: 160,
              automaticallyImplyLeading: false,
              flexibleSpace: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                           ()=> Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(supabaseService.currentUser.value!.userMetadata?["name"], style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                                  SizedBox(width: 4,),
                                  Icon(Icons.verified_rounded,color: Colors.blue,size: 20,),
                                ],
                              ),
                              
                              SizedBox(
                                width: context.width * 0.70,
                                child: Text(supabaseService.currentUser.value?.userMetadata?["description"]??"Verse.",style: TextStyle(fontSize: 16),)),
                            ],
                          ),
                        ),
                        CirlcleImage(
                          radius: 45,
                          url: supabaseService.currentUser.value?.userMetadata?["image"],
                        )
                        
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      
                      children: [
                        Expanded(child: 
                        OutlinedButton(onPressed: ()=> Get.toNamed(RouteNames.editProfile), style: customOutlineStyle(),
                        child:const 
                        Text("Edit Profile"),
                        )
                        ),
                        SizedBox(width: 18,),

                        Expanded(child: 
                        OutlinedButton(onPressed: (){},style: customOutlineStyle(), 
                        child: const
                        Text("Share Profile"),
                        )
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SliverPersistentHeader
            (
             floating: true,
             pinned: true, 
            delegate: SliverAppBarDelegate
            (
              
              const TabBar
              (
                indicatorSize: TabBarIndicatorSize.tab,
              tabs: 
              [
                 Tab(icon: Icon(Icons.grid_on),),
                 Tab(icon: Icon(Icons.mode_comment_outlined,),),
              ],),
            ),
            ),
          ];
        }, body: TabBarView
        (
          children: [
            Obx(()=> 
            SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      if (controller.postLoading.value)
                        const Loading()
                      else if (controller.posts.isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.posts.length,
                          itemBuilder: (context, index) => PostCard(
                            post: controller.posts[index],isAuthCard: true,callback: controller.deleteReply,
                            
                          ),
                        )
                      else
                        const Center(
                          child: Text("No Post found"),
                        ),
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
                                  reply: controller.replies[index]!,
                                  
                                ),
                              )
                            else
                              const Center(
                                child: Text("No reply found"),
                              )
                          ],
                        ),
                ),
            ),
          ]
        ),
      ),
      ),
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate
{
  final TabBar _tabBar;
  SliverAppBarDelegate(this._tabBar);

  @override
  
  double get maxExtent => _tabBar.preferredSize.height;



  @override
  
  double get minExtent => _tabBar.preferredSize.height;



  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    
    return Container(
      color: Colors.black,
      child: _tabBar,
    );
  }

  

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    
   return false;
  }
  
}