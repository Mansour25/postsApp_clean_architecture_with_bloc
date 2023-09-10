import 'package:dartz/dartz.dart';
import 'package:posts_clean_arcitecture/features/posts/domain/respositories/posts-repositories.dart';

import '../../../../core/error/app-error.dart';

class DeletePostUseCase {
  final PostsRepositories postsRepositories;

  DeletePostUseCase(this.postsRepositories);

  Future<Either<Failure, Unit>> call(int id) async {
    return await postsRepositories.deletePost(id);
  }
}
