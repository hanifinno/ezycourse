import 'package:ezycourse/app/modules/post_reaction/models/reaction_model.dart';
import 'package:ezycourse/app/services/api_communication.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../models/api_response.dart';

class ReactionController extends GetxController {
  int feedId = 0;
  late ApiCommunication _apiCommunication;
  RxList<ReactionModel> reactionList = <ReactionModel>[].obs;

RxBool isReactionLoding = false.obs;

  void getReactions(int postId) async {

     isReactionLoding.value = true;

    final ApiResponse response = await _apiCommunication.doGetRequest(
      apiEndPoint: 'app/teacher/community/getAllReactionType?feed_id=$postId',
    );
    if (response.isSuccessful) {
      reactionList.value = (response.data as List)
          .map((element) => ReactionModel.fromMap(element))
          .toList();
      debugPrint('ok');
      isReactionLoding.value = false;
    }
  }

  @override
  void onInit() {
    _apiCommunication=ApiCommunication();
    feedId =Get.arguments;
    getReactions(feedId);
    super.onInit();
  }


}
