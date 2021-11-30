import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/controllers/task_controller.dart';
import 'package:to_do_list/views/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<TaskController>.value(value: TaskController()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          home: HomePage(),
        ));
  }
}
