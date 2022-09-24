import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/todo_controller/get_todo_controller.dart';
import 'package:todo_app/model/isar/todo.dart';
import 'package:todo_app/service/isar_service.dart';

enum TodoOperationType { add, edit }

class AddTodoController extends GetxController {
  static AddTodoController get con => Get.isRegistered<AddTodoController>()
      ? Get.find<AddTodoController>()
      : Get.put(AddTodoController());
  final Rx<TodoOperationType> operationType = TodoOperationType.add.obs;
  final isar = Get.find<IsarService>().isar;
  final title = TextEditingController();
  final description = TextEditingController();
  late Todo todo;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void addTodo() async {
    Todo todo = Todo(
        title: title.text,
        description: description.text,
        done: false,
        createdAt: DateTime.now());
    GetTodoController.con.addTodo(todo);
  }

  void editTodo() {
    todo
      ..title = title.text
      ..description = description.text;
    GetTodoController.con.editTodo(todo);
  }

  void editPreConfiguration(Todo todo) {
    this.todo = todo;
    title.text = todo.title;
    description.text = todo.description;
    operationType.value = TodoOperationType.edit;
  }
}
