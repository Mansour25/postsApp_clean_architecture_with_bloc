import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_clean_arcitecture/core/constant/strings/messages.dart';
import 'package:posts_clean_arcitecture/features/posts/domain/use_case/delete-post.dart';
import 'package:posts_clean_arcitecture/features/posts/domain/use_case/updat-post.dart';

import '../../../../../core/constant/strings/error-messages.dart';
import '../../../../../core/error/app-error.dart';
import '../../../domain/entities/posts.dart';
import '../../../domain/use_case/add-post.dart';

part 'add_update_delete_post_event.dart';

part 'add_update_delete_post_state.dart';

class AddUpdateDeletePostBloc
    extends Bloc<AddUpdateDeletePostEvent, AddUpdateDeletePostState> {
  final AddPostUseCase addPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final UpdatePostUseCase updatePostUseCase;

  AddUpdateDeletePostBloc({
    required this.addPostUseCase,
    required this.deletePostUseCase,
    required this.updatePostUseCase,
  }) : super(AddUpdateDeletePostInitial()) {
    on<AddUpdateDeletePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePostState());

        final failureOrDoneMessage = await addPostUseCase(event.post);
        emit(eitherDoneOrErrorMessageState(failureOrDoneMessage,addSuccessMessage));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());

        final failureOrDoneMessage = await deletePostUseCase(event.postId);

        emit(eitherDoneOrErrorMessageState(failureOrDoneMessage,deleteSuccessMessage));
      } else if (event is UpdatepostEvent) {
        emit(LoadingAddDeleteUpdatePostState());

        final failureOrDoneMessage = await updatePostUseCase(event.post);
        emit(eitherDoneOrErrorMessageState(failureOrDoneMessage,updateSuccessMessage));
      }
    });
  }

  AddUpdateDeletePostState eitherDoneOrErrorMessageState(
      Either<Failure, Unit> failureOrDoneMessage,String message) {
    return failureOrDoneMessage.fold(
      (l) {
        return ErrorAddDeleteUpdatePostState(failureToMessage(l));
      },
      (_) {
        return  SuccessAddDeleteUpdatePostState(message);
      },
    );
  }

  String failureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case OfflineFailure:
        return offlineFailureMessage;
      default:
        return 'Unexpected Error, Please try again later.';
    }
  }
}
