import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/controllers/task_controller.dart';
import 'package:to_do_list/models/task_model.dart';
import 'package:flutter/src/rendering/box.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TaskModel? taskModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalformKey = new GlobalKey<FormState>();
  @override
  void initState() {
    taskModel = new TaskModel();
  }

  _salvarTask() {
    final form = globalformKey.currentState;
    if (form!.validate()) {
      form.save();
      TaskController taskController =
          Provider.of<TaskController>(context, listen: false);
      return taskController.addMore(taskModel!);
    }
    return false;
  }

  _buildList() {
    TaskController taskController = Provider.of<TaskController>(context);
    return ListView.builder(
        itemCount: taskController.tasks.length,
        itemBuilder: (context, index) {
          return _buildItems(taskController.tasks[index]);
        });
  }

  _buildItems(TaskModel taskModel) {
    TaskController taskController = Provider.of<TaskController>(context);
    return Column(
      children: [
        ListTile(
          title: Text(taskModel.tarefa!),
          onTap: () {},
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  highlightColor: Colors.amber,
                  onPressed: () {
                    taskController.checkConcluded(taskModel);
                  },
                  icon: Icon(taskModel.concluida!
                      ? Icons.verified
                      : Icons.verified_outlined)),
              IconButton(
                  onPressed: () {
                    taskController.checkFavorite(taskModel);
                  },
                  icon: Icon(
                      taskModel.eFavorita! ? Icons.star : Icons.star_border)),
              IconButton(
                  onPressed: () {
                    taskController.delete(taskModel);
                  },
                  icon: Icon(Icons.delete)),
            ],
          ),
        ),
      ],
    );
  }

  _modal() {
    return showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: 400,
              color: Colors.white60,
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                    Form(
                      key: globalformKey,
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: [
                            const Text(
                              'Add task',
                              style: TextStyle(fontSize: 25),
                            ),
                            SizedBox(height: 20),
                            new TextFormField(
                              decoration: InputDecoration(
                                labelText: "Task",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                prefixIcon: Icon(Icons.task),
                              ),
                              onSaved: (input) => taskModel!.tarefa = input,
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Description",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                prefixIcon: Icon(Icons.description),
                              ),
                              maxLines: 7,
                              minLines: 4,
                              onSaved: (input) => taskModel!.descricao = input,
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              child: const Text('Add  task'),
                              onPressed: () => {
                                if (_salvarTask())
                                  {
                                    Navigator.pop(context),
                                  }
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ])));
        });
  }

  _floatActionButton() {
    return FloatingActionButton(
      onPressed: () {
        return _modal();
      },
      child: Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('To do list'),
        ),
        body: Consumer<TaskController>(
          builder: (context, TaskController, widget) {
            return _buildList();
          },
        ),
        floatingActionButton: Consumer<TaskController>(
          builder: (context, TaskController, widget) {
            return _floatActionButton();
          },
        ));
  }
}
