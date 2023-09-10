import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:posts_clean_arcitecture/core/error/app-error.dart';

import '../../../../../core/constant/strings/error-messages.dart';
import '../../../domain/entities/posts.dart';
import '../../../domain/use_case/get-all-posts.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAlPostsUseCase;

  PostsBloc({required this.getAlPostsUseCase}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAlPostsUseCase();
        emit(mapFailureOrPostsToState(failureOrPosts));
       } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());

        final failureOrPosts = await getAlPostsUseCase();
        emit(mapFailureOrPostsToState(failureOrPosts));
      } else {

      }
    });
  }

  PostsState mapFailureOrPostsToState(Either<Failure, List<Post>> value) {
    return value.fold(
      (failure) => ErrorPostsState(failureToMessage(failure)),
      (posts) => LoadedPostsState(posts),
    );
  }

  String failureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case EmptyCacheFailure:
        return emptyCacheFailureMessage;
      case OfflineFailure:
        return offlineFailureMessage;
      default:
        return 'Unexpected Error, Please try again later.';
    }
  }
}
