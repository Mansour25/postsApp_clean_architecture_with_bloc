part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
}

class PostsInitial extends PostsState {
  @override
  List<Object> get props => [];
}

//3 state

class LoadingPostsState extends PostsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadedPostsState extends PostsState {
 final List<Post> posts;
  const LoadedPostsState(this.posts);



  @override
  List<Object?> get props => [posts];
}

class ErrorPostsState extends PostsState {
  final String error;
  const ErrorPostsState(this.error);

  @override
  List<Object?> get props => [error];
}
