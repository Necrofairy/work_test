import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/task_model.dart';


class ApiGorest {
  static const uri = 'https://gorest.co.in/public/v2/todos';

  Future<List<TaskModel>> getApiTask() async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.parse(uri));
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      var models = _getModels(decodedResponse);
      return models;
    } finally {
      client.close();
    }
  }

  List<TaskModel> _getModels(Object? data) {
    List<TaskModel> models = [];
    List<dynamic> dataList = data as List<dynamic>;
    for (var el in dataList) {
      TaskModel model = TaskModel.fromJson(el as Map<String, dynamic>);
      if (!models.contains(model)) {
        models.add(model);
      }
    }
    return models;
  }
}
