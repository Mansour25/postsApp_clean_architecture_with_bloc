import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_clean_arcitecture/core/error/app-error.dart';
import 'package:posts_clean_arcitecture/core/error/exeption.dart';
import 'package:posts_clean_arcitecture/core/network/network-info.dart';
import 'package:posts_clean_arcitecture/features/posts/data/data_sources/post-local-data-source.dart';
import 'package:posts_clean_arcitecture/features/posts/data/data_sources/post-remote-data-source.dart';
import 'package:posts_clean_arcitecture/features/posts/data/models/post-model.dart';
import 'package:posts_clean_arcitecture/features/posts/domain/entities/posts.dart';
import 'package:posts_clean_arcitecture/features/posts/domain/respositories/posts-repositories.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();


class PostRepositoriesImp implements PostsRepositories {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostRepositoriesImp({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  InternetConnectionChecker connectionChecker = InternetConnectionChecker();

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        print('%%%%%%%%%%%%');
        print(remotePosts);
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerExeption {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localePosts = await localDataSource.getCachedPosts();
        return Right(localePosts);
      } on EmptyCacheExeption {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel = PostModel(
      // في حالة add post لا يتم اضافة id يدويا
      // id: post.id,
      title: post.title,
      body: post.body,
    );

    return handleMessage(
      deleteOrUpdateOrAddPost: () => remoteDataSource.addPost(postModel),
    );
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return handleMessage(
      deleteOrUpdateOrAddPost: () => remoteDataSource.deletePost(id),
    );
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );

    return handleMessage(
      deleteOrUpdateOrAddPost: () => remoteDataSource.updatePost(postModel),
    );
  }

  Future<Either<Failure, Unit>> handleMessage({
    required DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return const Right(unit);
      } on ServerExeption {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
