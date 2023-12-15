
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RetryWidget extends StatelessWidget {
  final Future<void> Function() onRetry;
  const RetryWidget({
    required this.onRetry,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: 
           EdgeInsets.all(Get.size.width * 0.35),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 3),
          shape: BoxShape.circle,
          color: Colors.white),
      child: IconButton(
          onPressed: () async {
            await onRetry();
          },
          icon:const Icon(
            Icons.repeat_sharp,
            size: 45,
          )),
    );
  }
}
