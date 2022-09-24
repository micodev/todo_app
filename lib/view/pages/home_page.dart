import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/todo_controller/get_todo_controller.dart';
import '../components/todo_component/empty_todo_widget.dart';
import '../components/todo_component/error_todo_widget.dart';
import '../components/todo_component/list_todo_widget.dart';
import '../components/todo_component/loading_todo_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final getTodoController = GetTodoController.con;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: getTodoController.openAddTodoForm,
          child: const Icon(Icons.add),
        ),
        body: getTodoController.obx((state) => ListTodoWidget(state ?? []),
            onError: (error) => ErrorTodoWidget(error ?? ''),
            onLoading: const LoadingTodoWidget(),
            onEmpty: const EmptyTodoWidget()));
  }
}
