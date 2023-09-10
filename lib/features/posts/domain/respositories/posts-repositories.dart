// وظيفة هذا الملف
// أن domain layer and data layer يتم التواصل فيما بينهم عن طريق repositories

import 'package:dartz/dartz.dart';
import 'package:posts_clean_arcitecture/features/posts/domain/entities/posts.dart';

import '../../../../core/error/app-error.dart';

abstract class PostsRepositories {
  Future<Either<Failure, List<Post>>> getAllPosts();

  Future<Either<Failure, Unit>> deletePost(int id);

  Future<Either<Failure, Unit>> updatePost(Post post);

  Future<Either<Failure, Unit>> addPost(Post post);
}

//Unit -> يعني لا يرجع شيء
