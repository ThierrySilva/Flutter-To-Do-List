import 'package:flutter/cupertino.dart';
import 'package:to_do_list/models/task_model.dart';

class TaskController extends ChangeNotifier {
  List<TaskModel> tasks = [
    TaskModel(tarefa: "Homework", descricao: "Do the homework"),
    TaskModel(tarefa: "Sleep", descricao: "Sleep little")
  ];

  checkFavorite(TaskModel model) {
    model.eFavorita = !model.eFavorita!;
    notifyListeners();
  }

  checkConcluded(TaskModel model) {
    model.concluida = !model.concluida!;
    notifyListeners();
  }

  addMore(TaskModel model) {
    tasks.add(model);
    notifyListeners();
    return true;
  }

  delete(TaskModel model) {
    tasks.remove(model);
    notifyListeners();
  }
}
