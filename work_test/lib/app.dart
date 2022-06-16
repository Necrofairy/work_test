import 'package:flutter/material.dart';
import 'package:work_test/domain/api_gorest.dart';
import 'package:work_test/pages/add_task_page/add_task_page.dart';
import 'package:work_test/pages/task_page/task_page.dart';

import 'models/task_model.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Future<List<TaskModel>>? list;

  @override
  void initState() {
    super.initState();
    list = ApiGorest().getApiTask();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        TaskPage.routeName: (context) => TaskPage(
              parentSetState: () => setState(() {}),
              list: list,
            ),
      },
    );
  }
}
