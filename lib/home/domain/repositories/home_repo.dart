import 'package:daldart/core/errors/api_error_handler.dart';
import 'package:daldart/core/errors/general_error_message.dart';
import 'package:daldart/home/data/data_source/api/api_helper.dart';
import 'package:daldart/home/data/data_source/api/endpoints.dart';
import 'package:daldart/home/data/models/posts_model.dart';
import 'package:dartz/dartz.dart';

class HomeRepo {
  final DioImpl dioImpl = DioImpl();

  Future<Either<ErrorMessage, PostsResponse>> getPosts(
      String? after, int tabIndex) async {
    try {
      dynamic json = await dioImpl.get(
          endPoint: _defineSourceEndPoint(tabIndex),
          query: {'after': after, 'limit': 10});
      return Right(PostsResponse.fromMap(json));
    } on PrimaryServerException catch (e) {
      return Left(ErrorMessage(message: e.message, status: false));
    } catch (e) {
      return Left(ErrorMessage(message: "fail to load Data", status: false));
    }
  }

  _defineSourceEndPoint(int srcIndex) {
    switch (srcIndex) {
      case 0:
        return Endpoints.hotPosts;
      case 1:
        return Endpoints.newPosts;

      default:
        return Endpoints.risingPosts;
    }
  }
}
