import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/todo_controller/add_todo_controller.dart';

class AddEditTodoWidget extends StatelessWidget {
  AddEditTodoWidget({super.key});
  final addTodoController = AddTodoController.con;
  @override
  Widget build(BuildContext context) {
    final isEdit =
        addTodoController.operationType.value == TodoOperationType.edit;
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).bottomAppBarColor),
      padding: const EdgeInsets.all(20),
      child: Form(
        key: addTodoController.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Text(
                  'Create new todo',
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
            TextFormField(
              controller: addTodoController.title,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.title),
                hintText: 'Todo title',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else if (value.length > 50) {
                  return 'Title must be less than 50 characters';
                }
                return null;
              },
            ),
            TextFormField(
              controller: addTodoController.description,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.description),
                hintText: 'Todo description',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else if (value.length > 256) {
                  return 'Description must be less than 256 characters';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (addTodoController.formKey.currentState!.validate()) {
                  if (isEdit) {
                    addTodoController.editTodo();
                  } else {
                    addTodoController.addTodo();
                  }
                  Get.back();
                }
              },
              child: Text(isEdit ? 'Edit' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }
}
