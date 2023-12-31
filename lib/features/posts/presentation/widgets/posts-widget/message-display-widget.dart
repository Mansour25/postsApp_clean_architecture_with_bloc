import 'package:flutter/cupertino.dart';

class MessageDisplayWidget extends StatelessWidget {
  final String message;

  const MessageDisplayWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.33,
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
