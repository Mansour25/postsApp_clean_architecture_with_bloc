import 'package:flutter/material.dart';

class TextFeildAddUpdate extends StatelessWidget {
  final TextEditingController controller;

  final String title;

  final bool isBody;

  const TextFeildAddUpdate({
    super.key,
    required this.controller,
    required this.title,
    required this.isBody,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return '$title Cant’t be empty';
          }
          return null;
        },
        decoration: InputDecoration(
            hintText: title, border: const OutlineInputBorder()),
        maxLines: isBody ? 6 : null,
      ),
    );
  }
}
