import 'package:dartz/dartz.dart';
import 'package:posts_clean_arcitecture/features/posts/domain/entities/posts.dart';
import 'package:posts_clean_arcitecture/features/posts/domain/respositories/posts-repositories.dart';

import '../../../../core/error/app-error.dart';

class AddPostUseCase {
  final PostsRepositories postsRepositories;

  AddPostUseCase(this.postsRepositories);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await postsRepositories.addPost(post);
  }
}


