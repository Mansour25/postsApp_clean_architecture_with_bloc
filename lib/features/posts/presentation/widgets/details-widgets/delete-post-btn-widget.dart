import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_arcitecture/core/util/snakBar-message.dart';
import 'package:posts_clean_arcitecture/core/widget/loading-widget.dart';
import 'package:posts_clean_arcitecture/features/posts/presentation/bloc/add-delete-update-post/add_update_delete_post_bloc.dart';
import 'package:posts_clean_arcitecture/features/posts/presentation/screens/posts-screen.dart';
import 'package:posts_clean_arcitecture/features/posts/presentation/widgets/details-widgets/post-details-widget.dart';

class DeletePostBtnWidget extends StatelessWidget {
  final int postId;

  const DeletePostBtnWidget({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return elevatedButton(
      title: 'Delete',
      icon: Icons.delete,
      color: Colors.red.shade500,
      context: context,
      function: () {
        deleteDialog(context, postId);
        // Navigator.pop(context);
      },
    );
  }

  void deleteDialog(BuildContext context, int postId) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<AddUpdateDeletePostBloc, AddUpdateDeletePostState>(
          listener: (context, state) {
            if (state is SuccessAddDeleteUpdatePostState) {
              SnackBarMessage().showSuccessSnackBar(
                  message: state.message, context: context);

              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const PostsScreen(),
                  ),
                  (route) => false);
            } else if (state is ErrorAddDeleteUpdatePostState) {
              Navigator.of(context).pop();
              SnackBarMessage()
                  .showErrorSnackBar(message: state.message, context: context);
            }
          },
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdatePostState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: const LoadingWidget(),
              );
            }
            return DeleteDialogWidget(postId: postId);
          },
        );
      },
    );
  }
}

class DeleteDialogWidget extends StatelessWidget {
  final int postId;

  const DeleteDialogWidget({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text("Are you Sure ?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "No",
          ),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<AddUpdateDeletePostBloc>(context).add(
              DeletePostEvent(postId: postId),
            );
          },
          child: const Text("Yes"),
        ),
      ],
    );
  }
}
