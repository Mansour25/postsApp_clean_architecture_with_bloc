import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_arcitecture/core/util/snakBar-message.dart';
import 'package:posts_clean_arcitecture/core/widget/loading-widget.dart';
import 'package:posts_clean_arcitecture/features/posts/presentation/bloc/add-delete-update-post/add_update_delete_post_bloc.dart';
import 'package:posts_clean_arcitecture/features/posts/presentation/screens/posts-screen.dart';

import '../../domain/entities/posts.dart';
import '../widgets/add-update-delete-widgets/add-update-form-widget.dart';

class AddUpdatePostScreen extends StatelessWidget {
  final Post? post;

  final bool isUpdatePost;

  const AddUpdatePostScreen({
    super.key,
    this.post,
    required this.isUpdatePost,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        isUpdatePost ? 'Update Post' : 'Add Post',
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.black,
      centerTitle: true,
    );
  }

  Widget buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<AddUpdateDeletePostBloc, AddUpdateDeletePostState>(
          listener: (context, state) {
            if (state is SuccessAddDeleteUpdatePostState) {

              SnackBarMessage().showSuccessSnackBar(
                message: state.message,
                context: context,
              );

              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const PostsScreen(),
                  ),
                  (route) => false);
            }

            if (state is ErrorAddDeleteUpdatePostState) {
              SnackBarMessage().showErrorSnackBar(
                message: state.message,
                context: context,
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdatePostState) {
              return const LoadingWidget();
            }

            return FormWidget(post: post,isUpdatepost: isUpdatePost);
          },
        ),
      ),
    );
  }


}
