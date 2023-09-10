import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_clean_arcitecture/core/network/network-info.dart';
import 'package:posts_clean_arcitecture/features/posts/data/data_sources/post-local-data-source.dart';
import 'package:posts_clean_arcitecture/features/posts/data/data_sources/post-remote-data-source.dart';
import 'package:posts_clean_arcitecture/features/posts/data/repositories/post-repositories-implement.dart';
import 'package:posts_clean_arcitecture/features/posts/domain/respositories/posts-repositories.dart';
import 'package:posts_clean_arcitecture/features/posts/domain/use_case/add-post.dart';
import 'package:posts_clean_arcitecture/features/posts/domain/use_case/delete-post.dart';
import 'package:posts_clean_arcitecture/features/posts/domain/use_case/get-all-posts.dart';
import 'package:posts_clean_arcitecture/features/posts/domain/use_case/updat-post.dart';
import 'package:posts_clean_arcitecture/features/posts/presentation/bloc/add-delete-update-post/add_update_delete_post_bloc.dart';
import 'package:posts_clean_arcitecture/features/posts/presentation/bloc/get-refresh-post/posts_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // features - posts

  // Bloc

  sl.registerFactory(
    () => PostsBloc(
      getAlPostsUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => AddUpdateDeletePostBloc(
      addPostUseCase: sl(),
      deletePostUseCase: sl(),
      updatePostUseCase: sl(),
    ),
  );

  // UseCases

  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));

  //Repositories

  sl.registerLazySingleton<PostsRepositories>(() => PostRepositoriesImp(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  //DataSources

  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImp(sl()));
  sl.registerLazySingleton<PostLocalDataSource>(() => PostLocalDataSourceImp());

  // Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
