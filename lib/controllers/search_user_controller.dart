import 'dart:async';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:verse/models/user_model.dart';
import 'package:verse/sevices/supabase_service.dart';

class SearchUserController extends GetxController {
  var loading = false.obs;
  var notFound = false.obs;
  RxList<UserModel?> users = RxList<UserModel?>();
  Timer? _debounce;

  Future<void> searchUser(String name) async {
    loading.value = true;
    notFound.value = false;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (name.isNotEmpty) {
        final List<dynamic> data = await SupabaseService.client
            .from("users")
            .select("*")
            .ilike("metadata->>name", "%$name%");
        loading.value = false;
        if (data.isNotEmpty) {
          users.value = [for (var item in data) UserModel.fromJson(item)];
        } else {
          notFound.value = true;
        }
      }
      loading.value = false;
    });
  }
}