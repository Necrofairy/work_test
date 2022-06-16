import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/task_model.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage(
      {Key? key, required this.parentSetState, required this.models})
      : super(key: key);
  final void Function() parentSetState;
  final List<TaskModel> models;

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _titleController = TextEditingController();
  final _deadlineController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _remindController = TextEditingController();
  final _repeatController = TextEditingController();
  bool isActive = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _deadlineController.dispose();
    _startTimeController.dispose();
    _remindController.dispose();
    _repeatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Add task',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            _titleForm(),
            _deadlineForm(),
            _startTimeForm(),
            _remindForm(),
            _repeatForm(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _createButton(),
            )
          ],
        ),
      ),
    );
  }

  Widget _titleForm() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: 'Title', hintText: 'Design team meeting'),
      controller: _titleController,
      validator: (val) {
        if (val != null) {
          return val.isEmpty ? 'Title is required' : null;
        }
        return null;
      },
    );
  }

  Widget _deadlineForm() {
    return TextFormField(
      decoration:
          const InputDecoration(labelText: 'Deadline', hintText: '2021-02-28'),
      keyboardType: TextInputType.datetime,
      controller: _deadlineController,
      validator: (val) {
        if (val != null) {
          return _validateDeadline(val)
              ? null
              : 'Deadline is ####-##-## format';
        }
        return null;
      },
    );
  }

  Widget _startTimeForm() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: 'Start time',
          hintText: '11:00 Am',
          suffixIcon: Icon(Icons.access_time)),
      controller: _startTimeController,
      validator: (val) {
        if (val != null) {
          return _validateStartTime(val)
              ? null
              : 'Start time is ##:## Am/Pm format';
        }
        return null;
      },
    );
  }

  Widget _remindForm() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: 'Remind', hintText: '10 minutes early'),
      controller: _remindController,
      validator: (val) {
        if (val != null) {
          return val.isEmpty ? 'Remind is required' : null;
        }
        return null;
      },
    );
  }

  Widget _repeatForm() {
    return TextFormField(
      decoration:
          const InputDecoration(labelText: 'Repeat', hintText: 'Weekly'),
      controller: _repeatController,
      validator: (val) {
        if (val != null) {
          return val.isEmpty ? 'Repeat is required' : null;
        }
        return null;
      },
    );
  }

  Widget _createButton() {
    if (isActive) {
      return ElevatedButton(
        onPressed: () {
          _createTask();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
            minimumSize: MaterialStateProperty.all(const Size(400, 50)),
            side: MaterialStateProperty.all(const BorderSide(width: 1)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)))),
        child: const Text('Create a task'),
      );
    } else {
      return ElevatedButton(
        onPressed: null,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
            minimumSize: MaterialStateProperty.all(const Size(400, 50)),
            side: MaterialStateProperty.all(const BorderSide(width: 1)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)))),
        child: const Text('Create a task'),
      );
    }
  }

  void _createTask(){
    if (_formKey.currentState!.validate()) {
      TaskModel model = TaskModel(
          id: 1,
          userId: 1,
          title: _titleController.text,
          dueOn: _deadlineController.text,
          status: 'pending');
      if  (!widget.models.contains(model)) {
        widget.models.add(model);
      } else {
        _pause();
        return;
      }
      widget.parentSetState();
      Navigator.pop(context);
    } else {
      _pause();
    }
  }

  void _pause() async {
    isActive = false;
    setState(() {});
    await Future.delayed(const Duration(seconds: 2));
    isActive = true;
    setState(() {});
  }

  bool _validateDeadline(String val) {
    final _deadlineExp = RegExp(r'^\d\d\d\d\-\d\d\-\d\d$');
    return _deadlineExp.hasMatch(val);
  }

  bool _validateStartTime(String val) {
    final _startTimeExp = RegExp(r'^\d\d\:\d\d\D\D\D$');
    return _startTimeExp.hasMatch(val);
  }
}
