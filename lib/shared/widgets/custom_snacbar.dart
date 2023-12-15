import 'package:get/get.dart';

void buildCustomSnackbar(String err) {
  Get.showSnackbar(GetSnackBar(
    duration: const Duration(seconds: 2),
    title: "ops",
    message: err,
  ));
}
