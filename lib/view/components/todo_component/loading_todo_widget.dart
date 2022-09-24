import 'package:flutter/material.dart';

class LoadingTodoWidget extends StatelessWidget {
  const LoadingTodoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
