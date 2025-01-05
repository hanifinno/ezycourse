import 'package:ezycourse/app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/reaction_controller.dart';

class ReactionView extends GetView<ReactionController> {
  const ReactionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Reactions",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor:PRIMARY_COLOR
      ),
      body: Obx(
        () => controller.reactionList.isEmpty
            ? const Center(
                child: Text(
                  "No Reactions Found",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: controller.reactionList.value.length,
                itemBuilder: (context, index) {
                  final reaction = controller.reactionList[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        reaction.reactionType?.substring(0, 1) ?? "-",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      reaction.reactionType ?? "Unknown",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${reaction.totalLikes ?? 0} Likes",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
