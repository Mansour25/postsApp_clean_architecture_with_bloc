import 'package:flutter/material.dart';
import 'package:posts_clean_arcitecture/features/posts/domain/entities/posts.dart';
import 'package:posts_clean_arcitecture/features/posts/presentation/screens/add-update-post-screen.dart';
import 'package:posts_clean_arcitecture/features/posts/presentation/widgets/details-widgets/delete-post-btn-widget.dart';

class PostDetailsWidget extends StatelessWidget {
  final Post post;

  const PostDetailsWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            post.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            height: 50,
            thickness: 0.5,
            color: Colors.black,
          ),
          Text(
            post.body,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Divider(
            height: 50,
            thickness: 0.5,
            color: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              elevatedButton(
                title: 'Edit',
                icon: Icons.edit,
                context: context,
                function: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AddUpdatePostScreen(
                          post: post,
                          isUpdatePost: true,
                        );
                      },
                    ),
                  );
                },
              ),
              DeletePostBtnWidget(postId: post.id!),
            ],
          ),
        ],
      ),
    );
  }
}

Widget elevatedButton({
  required String title,
  required IconData icon,
  Color? color = Colors.black,
  required BuildContext context,
  required Function() function,
}) {
  return ElevatedButton.icon(
    style: ButtonStyle(
      elevation: const MaterialStatePropertyAll(10),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
      ),
      backgroundColor: MaterialStateProperty.all(color),
    ),
    onPressed: function,
    icon: Icon(icon),
    label: Text(title),
  );
}
