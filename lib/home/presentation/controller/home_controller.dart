import 'package:daldart/home/data/models/posts_model.dart';
import 'package:daldart/home/domain/repositories/home_repo.dart';
import 'package:daldart/shared/widgets/custom_snacbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isLoading = RxBool(false);
  List<Rxn<PostsResponse?>> pagesData = [
    Rxn<PostsResponse?>(),
    Rxn<PostsResponse?>(),
    Rxn<PostsResponse?>()
  ];
  ScrollController scrollController = ScrollController();
  TabController? tabController;
  @override
  onInit() async {
    await getPosts();
    scrollController.addListener(() {
      scrollListener();
    });
    super.onInit();
  }

  checkIsPageInitalized(i) {
    if (getCurrentList().value == null) {
      getPosts();
    }
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      getPosts();
    }
  }

  Future<void> getPosts() async {
    String after = getPrevValue();
    isLoading.value = true;
    var response = await HomeRepo().getPosts(after, tabController?.index ?? 0);
    response.fold((err) {
      buildCustomSnackbar(err.message);
    }, (postsRes) {
      assignPostsValue(postsRes, after);
    });
    isLoading.value = false;
  }

  String getPrevValue() {
    if (tabController == null) return "";
    return pagesData[tabController?.index ?? 0].value?.after ?? "";
  }

  assignPostsValue(PostsResponse res, String? rev) {
    if (rev == "") {
      pagesData[tabController?.index ?? 0].value = res;
    } else {
      pagesData[tabController?.index ?? 0].value!.posts.addAll(res.posts);
      pagesData[tabController?.index ?? 0].value!.after = res.after;
    }
  }

  Rxn<PostsResponse?> getCurrentList() {
    return pagesData[tabController?.index ?? 0];
  }
}
