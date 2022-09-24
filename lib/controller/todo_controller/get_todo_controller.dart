import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/model/isar/todo.dart';
import 'package:isar/isar.dart';
import '../../service/isar_service.dart';
import '../../view/components/todo_component/add_edit_todo_widget.dart';
import 'add_todo_controller.dart';

class GetTodoController extends GetxController with StateMixin<List<Todo>> {
  static GetTodoController get con => Get.isRegistered<GetTodoController>()
      ? Get.find<GetTodoController>()
      : Get.put(GetTodoController(), permanent: true);
  final RxList<Todo> todos = <Todo>[].obs;
  final isar = Get.find<IsarService>().isar;
  int skip = 0;
  final limit = 50;
  final isLoading = false.obs;
  final isFinished = false.obs;

  final todoScrollController = ScrollController();
  @override
  void onInit() async {
    super.onInit();
    //infinite scroll configuration
    todoScrollController.addListener(() async {
      // nextPageTrigger will have a value equivalent to 80% of the list size.
      var nextPageTrigger = 0.8 * todoScrollController.position.maxScrollExtent;
      if (todoScrollController.position.pixels > nextPageTrigger) {
        isLoading.value = true;
        if (status.isLoading == false &&
            status.isLoadingMore == false &&
            status.isError == false) {
          await getTodos();
        }
      }
    });
    await getTodos();
  }

  void addTodo(Todo todo) async {
    try {
      await isar.writeTxn(() async => await isar.todos.put(todo));
      todos.insert(0, todo);
      showSnackbarOnOperation('Todo added successfully', Colors.green);
      change(todos, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void editTodo(Todo todo) async {
    try {
      await isar.writeTxn(() async => await isar.todos.put(todo));
      todos[todos.indexWhere((element) => element.id == todo.id)] = todo;
      showSnackbarOnOperation('Todo edited successfully', Colors.green);
      change(todos, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void toggleDone(Todo todo) async {
    try {
      final index = todos.indexWhere((element) => element.id == todo.id);
      todo.done = !todo.done;
      await isar.writeTxn(() async => await isar.todos.put(todo));
      todos[index] = todo;
      change(todos, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> getTodos() async {
    if (skip == 0) {
      change(null, status: RxStatus.loading());
    } else {
      change(todos, status: RxStatus.loadingMore());
    }
    try {
      todos
          .addAll(await isar.todos.where().offset(skip).limit(limit).findAll());
      if (todos.isEmpty) {
        change(null, status: RxStatus.empty());
        return;
      }
      skip += limit;
      change(todos, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void deleteTodo(Todo todo) {
    try {
      isar.writeTxn(() async => await isar.todos.delete(todo.id));
      todos.removeWhere((element) => element.id == todo.id);
      showSnackbarOnOperation('Todo deleted successfully', Colors.green);
      if (todos.isEmpty) {
        change(null, status: RxStatus.empty());
      } else {
        change(todos, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void showSnackbarOnOperation(String text, Color color) {
    if (Get.isSnackbarOpen) Get.back();
    Get.rawSnackbar(
        message: text,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: color);
  }

  void openAddTodoForm() async {
    await Get.bottomSheet(
      AddEditTodoWidget(),
    );
    Get.delete<AddTodoController>();
  }
}
