

import 'package:get/get.dart';

import 'package:verse/models/notification_model.dart';
import 'package:verse/sevices/supabase_service.dart';
import 'package:verse/utils/helper.dart';

class NotificationController extends GetxController
{
   RxList<NotificationModel?> notifications = RxList<NotificationModel?>();
  var loading=false.obs;
  Future<void> fetchNotifications (String userId) async{
  try{
    loading.value=true;
    final List<dynamic> response =await SupabaseService.client.from("notifications").select('''id, post_id, notification,created_at , user_id ,user:user_id (email , metadata)''').eq("to_user_id", userId).order("id", ascending: false);

  loading.value=false;
  if(response.isNotEmpty)
  {
    notifications.value=[
        for (var item in response) NotificationModel.fromJson(item),
      ];
  }
  } catch(e)
  {
    loading.value=false;
    showSnackBar("Error", "Something went wrong, try again!");
  }
  }
}