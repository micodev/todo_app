import 'package:flutter/material.dart';

class EmptyTodoWidget extends StatelessWidget {
  const EmptyTodoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No todos yet.',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }
}
