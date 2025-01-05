import 'package:get/get.dart';

import '../controllers/reaction_controller.dart';


class ReactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReactionController>(
      () => ReactionController(),
    );
  }
}
