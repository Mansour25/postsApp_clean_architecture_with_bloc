import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posts_clean_arcitecture/features/posts/presentation/screens/details-post-screen.dart';

import '../../../domain/entities/posts.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;

  const PostListWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(posts[index].id.toString()),
          title: Text(
            posts[index].title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            posts[index].body,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 10,
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailsPostScreen(
                    post: posts[index],
                  ),
                ));
          },
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.black,
          thickness: 0.5,
        );
      },
      itemCount: 10,
    );
  }
}
