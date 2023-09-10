import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_arcitecture/features/posts/presentation/bloc/get-refresh-post/posts_bloc.dart';
import 'package:posts_clean_arcitecture/core/widget/loading-widget.dart';
import 'package:posts_clean_arcitecture/features/posts/presentation/screens/add-update-post-screen.dart';

import '../widgets/posts-widget/message-display-widget.dart';
import '../widgets/posts-widget/posts-list-widget.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      floatingActionButton: buildFloatingBtn(context),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.black,
      title: const Text(
        'Posts App',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return const LoadingWidget();
          } else if (state is LoadedPostsState) {
            return RefreshIndicator(
                onRefresh: () async {
                  onRefresh(context);
                },
                child: PostListWidget(posts: state.posts));
          } else if (state is ErrorPostsState) {
            return MessageDisplayWidget(message: state.error);
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Future<void> onRefresh(context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }

  Widget buildFloatingBtn(context) {
    return FloatingActionButton(
      backgroundColor: Colors.black,
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const AddUpdatePostScreen(isUpdatePost: false),
            ));
      },
      child: const Icon(Icons.add),
    );
  }
}
