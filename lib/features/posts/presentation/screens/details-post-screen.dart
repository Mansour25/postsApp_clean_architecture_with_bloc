import 'package:flutter/material.dart';
import 'package:posts_clean_arcitecture/features/posts/domain/entities/posts.dart';

import '../widgets/details-widgets/post-details-widget.dart';

class DetailsPostScreen extends StatelessWidget {
  final Post post;

  const DetailsPostScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      title: const Text(
        'Post Details',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildBody() {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: PostDetailsWidget(post: post),
    ));
  }
}
