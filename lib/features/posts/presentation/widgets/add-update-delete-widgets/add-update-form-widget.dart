import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_arcitecture/features/posts/presentation/bloc/add-delete-update-post/add_update_delete_post_bloc.dart';
import 'package:posts_clean_arcitecture/features/posts/presentation/widgets/add-update-delete-widgets/FormSubmitBtn.dart';
import 'package:posts_clean_arcitecture/features/posts/presentation/widgets/add-update-delete-widgets/text-feild-add-update.dart';
import '../../../domain/entities/posts.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatepost;

  final Post? post;

  const FormWidget({
    super.key,
    this.post,
    required this.isUpdatepost,
  });

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {

    // TODO: implement initState
    if (widget.isUpdatepost) {

      titleController.text = widget.post!.title;
      bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFeildAddUpdate(
            controller: titleController,
            title: 'Title',
            isBody: false,
          ),
          TextFeildAddUpdate(
            controller: bodyController,
            title: 'Body',
            isBody: true,
          ),
          FormSubmitBtn(
            isUpdatepost: widget.isUpdatepost,
            function: (){
              validateFormThenUpdateOrAddPost();
            },
          ),
        ],
      ),
    );
  }

  void validateFormThenUpdateOrAddPost() {
    print('Hi');
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      final Post post = Post(
        id: widget.isUpdatepost ? widget.post!.id : null,
        title: titleController.text,
        body: bodyController.text,
      );

      if (widget.isUpdatepost) {
        BlocProvider.of<AddUpdateDeletePostBloc>(context)
            .add(UpdatepostEvent(post));
      } else {
        BlocProvider.of<AddUpdateDeletePostBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }
}
