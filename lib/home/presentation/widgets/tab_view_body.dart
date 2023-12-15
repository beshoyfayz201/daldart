import 'package:daldart/home/presentation/controller/home_controller.dart';
import 'package:daldart/home/presentation/widgets/post_widget.dart';
import 'package:daldart/shared/widgets/retry_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class TabViewBody extends GetView<HomeController> {
  const TabViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller.scrollController,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Obx(() => controller.isLoading.value &&
                  controller.getCurrentList().value == null
              ? Padding(
                  padding: EdgeInsets.all(Get.width * 0.2),
                  child: const CircularProgressIndicator(
                    color: Colors.green,
                  ),
                )
              : controller.getCurrentList().value == null
                  ? RetryWidget(
                      onRetry: () async {
                        controller.getPosts();
                      },
                    )
                  : Column(children: [
                      Obx(() => (controller.isLoading.value &&
                              controller.getCurrentList().value == null)
                          ? Padding(
                              padding: EdgeInsets.all(Get.width * 0.2),
                              child: const CircularProgressIndicator(
                                color: Colors.green,
                              ),
                            )
                          : controller.getCurrentList().value == null
                              ? RetryWidget(
                                  onRetry: () async {
                                    controller.getPosts();
                                  },
                                )
                              : Column(children: [
                                  ...controller
                                      .getCurrentList()
                                      .value!
                                      .posts
                                      .map((e) => PostWidget(postsModel: e))
                                      .toList(),
                                  if (controller.isLoading.value &&
                                      controller.getCurrentList().value != null)
                                    SizedBox(
                                        height: Get.height * 0.01,
                                        width: Get.width * 0.85,
                                        child: const LinearProgressIndicator(
                                          minHeight: 5,
                                          color: Colors.amber,
                                        )),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  )
                                ]))
                    ]))
        ],
      ),
    );
  }
}
