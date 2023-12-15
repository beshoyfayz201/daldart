import 'package:daldart/home/domain/entity/posts_entity.dart';

class PostsModel extends PostsEntity {
  PostsModel(
      {required super.title, required super.selftext, required super.url});
  factory PostsModel.fromJson(Map<String, dynamic> json) {
    return PostsModel(
      url: json['url'],
      title: json['title'],
      selftext: json['selftext'],
    );
  }
}

class PostsResponse {
  List<PostsModel> posts;
  String after;
  PostsResponse({
    required this.posts,
    required this.after,
  });

  factory PostsResponse.fromMap(Map<String, dynamic> map) {
    return PostsResponse(
      posts: List<PostsModel>.from(
          map['data']['children']?.map((x) => PostsModel.fromJson(x['data']))),
      after: map['data']['after'] ?? '',
    );
  }
}
