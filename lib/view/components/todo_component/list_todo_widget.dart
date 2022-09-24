import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controller/todo_controller/get_todo_controller.dart';
import 'package:todo_app/view/components/todo_component/add_edit_todo_widget.dart';

import '../../../controller/todo_controller/add_todo_controller.dart';
import '../../../model/isar/todo.dart';

class ListTodoWidget extends StatelessWidget {
  final List<Todo> todos;
  const ListTodoWidget(this.todos, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              controller: GetTodoController.con.todoScrollController,
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return todoItemBuilder(context, todo);
              }),
        ),
        GetTodoController.con.status.isLoadingMore
            ? const Center(child: CircularProgressIndicator())
            : Container(),
      ],
    );
  }

  Widget todoItemBuilder(BuildContext context, Todo todo) {
    String createdAt = DateFormat('yyyy-MM-dd – kk:mm').format(todo.createdAt);
    return Dismissible(
      key: Key(todo.id.toString()),
      background: Container(
        color: Colors.red,
        child: Icon(Icons.delete, color: Theme.of(context).canvasColor),
      ),
      onDismissed: (direction) {
        GetTodoController.con.deleteTodo(todo);
      },
      child: ExpansionTile(
        title: Text(todo.title),
        subtitle: Text(todo.description),
        trailing: Checkbox(
          value: todo.done,
          onChanged: (value) {
            GetTodoController.con.toggleDone(todo);
          },
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('created at: $createdAt'),
                TextButton(
                  onPressed: () => onTodoPressed(todo),
                  child: const Text('Edit'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onTodoPressed(Todo todo) async {
    Get.put<AddTodoController>(AddTodoController()).editPreConfiguration(todo);

    await Get.bottomSheet(
      AddEditTodoWidget(),
    );
    Get.delete<AddTodoController>();
  }
}
