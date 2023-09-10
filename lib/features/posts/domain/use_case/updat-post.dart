import 'package:dartz/dartz.dart';
import 'package:posts_clean_arcitecture/features/posts/domain/entities/posts.dart';
import 'package:posts_clean_arcitecture/features/posts/domain/respositories/posts-repositories.dart';

import '../../../../core/error/app-error.dart';

class UpdatePostUseCase {
  final PostsRepositories postsRepositories;

  UpdatePostUseCase(this.postsRepositories);

  Future<Either<Failure, Unit>> call(Post post) {
    return postsRepositories.updatePost(post);
  }
}
