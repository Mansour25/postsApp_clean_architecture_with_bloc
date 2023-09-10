part of 'add_update_delete_post_bloc.dart';

abstract class AddUpdateDeletePostEvent extends Equatable {
  const AddUpdateDeletePostEvent();
}

class AddPostEvent extends AddUpdateDeletePostEvent {
  final Post post;

  const AddPostEvent({required this.post});

  @override
  List<Object?> get props => [post];
}

class DeletePostEvent extends AddUpdateDeletePostEvent {
  final int postId;

  const DeletePostEvent({required this.postId});

  @override
  List<Object?> get props => [postId];
}

class UpdatepostEvent extends AddUpdateDeletePostEvent {
  final Post post;

  const UpdatepostEvent(this.post);

  @override
  List<Object?> get props => [post];
}
