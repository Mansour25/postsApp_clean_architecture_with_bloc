import 'package:dartz/dartz.dart';
import 'package:posts_clean_arcitecture/core/error/app-error.dart';
import 'package:posts_clean_arcitecture/features/posts/domain/entities/posts.dart';
import 'package:posts_clean_arcitecture/features/posts/domain/respositories/posts-repositories.dart';

class GetAllPostsUseCase {
  final PostsRepositories repositories;
  GetAllPostsUseCase(this.repositories);
  Future<Either<Failure, List<Post>>> call() async {
    return await repositories.getAllPosts();
  }
}
