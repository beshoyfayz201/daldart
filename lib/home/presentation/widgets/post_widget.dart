import 'package:daldart/home/data/models/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostWidget extends StatelessWidget {
  final PostsModel postsModel;
  const PostWidget({super.key, required this.postsModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 5,
            color: const Color.fromRGBO(255, 235, 59, 1),
          ),
          Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: Get.width * 0.9,
              child: Text(
                postsModel.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(15),
              width: Get.width * 0.9,
              child: Text(
                postsModel.selftext,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              )),
        ],
      ),
    );
  }
}
