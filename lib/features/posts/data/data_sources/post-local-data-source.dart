import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_clean_arcitecture/core/data-helper/hive-helper.dart';
import 'package:posts_clean_arcitecture/core/error/exeption.dart';
import 'package:posts_clean_arcitecture/features/posts/data/models/post-model.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();

  Future<Unit> cachePosts(List<PostModel> postModels);
}

class PostLocalDataSourceImp implements PostLocalDataSource {
  @override
  Future<Unit> cachePosts(List<PostModel> postModels) async {
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>(
          (postModel) => postModel.toJson(),
        )
        .toList();
    await HiveHelper.putData('cached_post', json.encode(postModels));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = HiveHelper.getData('cached_post');
    if (jsonString.isNutNull) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModel = decodeJsonData
          .map<PostModel>((postModel) => PostModel.fromJson(postModel))
          .toList();

      return Future.value(jsonToPostModel);
    } else {
      throw EmptyCacheExeption();
    }
  }
}

extension NutNull on dynamic {
  get isNutNull {
    if (this != null) {
      return true;
    } else {
      return false;
    }
  }
}
