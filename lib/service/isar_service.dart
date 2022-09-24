import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:todo_app/model/isar/todo.dart';

class IsarService extends GetxService {
  late Isar isar;
  Future<IsarService> init() async {
    isar = await Isar.open([TodoSchema]);
    return this;
  }
}
