import 'package:flutter/material.dart';

class FormSubmitBtn extends StatelessWidget {
  final bool isUpdatepost;

  final Function() function;

  const FormSubmitBtn(
      {super.key, required this.isUpdatepost, required this.function});

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: MaterialStateProperty.all(Colors.black),
      ),
      onPressed: function,
      icon: isUpdatepost ? const Icon(Icons.edit) : const Icon(Icons.add),
      label: isUpdatepost ? const Text('Update') : const Text('Add'),
    );
  }
}
