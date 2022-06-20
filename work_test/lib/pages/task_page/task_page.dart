import 'package:flutter/material.dart';
import 'package:work_test/pages/add_task_page/add_task_page.dart';

import '../../models/task_model.dart';
import '../../utils/images_name.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key, required this.list, required this.parentSetState})
      : super(key: key);
  static const String routeName = '/';
  final void Function() parentSetState;
  final Future<List<TaskModel>>? list;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.list,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _menu(context, snapshot.data as List<TaskModel>);
          } else if (snapshot.hasError) {
            String error = '${snapshot.error}';
            return Center(
              child: Text('Error!$error'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _menu(BuildContext context, List<TaskModel> models) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Board',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'All',
                ),
                Tab(
                  text: 'Completed',
                ),
                Tab(
                  text: 'Uncompleted',
                ),
                Tab(
                  text: 'Favorite',
                ),
              ],
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black26,
              indicatorColor: Colors.black,
            ),
          ),
          body: TabBarView(
            children: [
              _all(models),
              _completed(models),
              _uncompleted(models),
              Container(),
            ],
          ),
        ));
  }

  Widget _all(List<TaskModel> models) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: models.length + 1,
          itemBuilder: (context, index) {
            if (index == models.length) {
              return _addButton(models);
            } else {
              return Card(
                child: ListTile(
                  title: Text(
                    models[index].title,
                    style: TextStyle(color: _choiceColor(models[index].status)),
                  ),
                  leading: _choiceImage(models[index].status),
                ),
              );
            }
          }),
    );
  }

  Color _choiceColor(String status) {
    switch (status) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  Image _choiceImage(String status) {
    switch (status) {
      case 'completed':
        return Image.asset(ImagesName.i2);
      default:
        return Image.asset(ImagesName.i1);
    }
  }

  Widget _completed(List<TaskModel> models) {
    List<TaskModel> completedModels = getCompletedModels(models);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: completedModels.length + 1,
          itemBuilder: (context, index) {
            if (index == completedModels.length) {
              return _addButton(models);
            } else {
              return Card(
                child: ListTile(
                  title: Text(
                    completedModels[index].title,
                    style: TextStyle(
                        color: _choiceColor(completedModels[index].status)),
                  ),
                  leading: _choiceImage(completedModels[index].status),
                ),
              );
            }
          }),
    );
  }

  Widget _uncompleted(List<TaskModel> models) {
    List<TaskModel> uncompletedModels = getUncompletedModels(models);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: uncompletedModels.length + 1,
          itemBuilder: (context, index) {
            if (index == uncompletedModels.length) {
              return _addButton(models);
            } else {
              return Card(
                child: ListTile(
                  title: Text(
                    uncompletedModels[index].title,
                    style: TextStyle(
                        color: _choiceColor(uncompletedModels[index].status)),
                  ),
                  leading: _choiceImage(uncompletedModels[index].status),
                ),
              );
            }
          }),
    );
  }

  List<TaskModel> getCompletedModels(List<TaskModel> models) {
    List<TaskModel> completedModels = [];
    for (TaskModel model in models) {
      if (model.status == 'completed') {
        completedModels.add(model);
      }
    }
    return completedModels;
  }

  List<TaskModel> getUncompletedModels(List<TaskModel> models) {
    List<TaskModel> uncompletedModels = [];
    for (TaskModel model in models) {
      if (model.status == 'pending') {
        uncompletedModels.add(model);
      }
    }
    return uncompletedModels;
  }

  Widget _addButton(List<TaskModel> models) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddTaskPage(
                      parentSetState: widget.parentSetState, models: models)));
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green),
          side: MaterialStateProperty.all(const BorderSide(width: 1)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          minimumSize: MaterialStateProperty.all(const Size(400, 50))
        ),
        child: const Text('Add a task'),
      ),
    );
  }
}
