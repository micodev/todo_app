import 'package:isar/isar.dart';
part 'todo.g.dart';

@collection
class Todo {
  Todo(
      {required this.title,
      required this.done,
      required this.description,
      required this.createdAt})
      : id = Isar.autoIncrement;

  Id id;

  String title;
  String description;
  bool done;
  DateTime createdAt;
  DateTime? completedAt;
}
