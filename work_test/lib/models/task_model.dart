class TaskModel {
  int id;
  int userId;
  String title;
  String dueOn;
  String status;

  TaskModel(
      {required this.id,
      required this.userId,
      required this.title,
      required this.dueOn,
      required this.status});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        id: json['id'],
        userId: json['user_id'],
        title: json['title'],
        dueOn: json['due_on'],
        status: json['status']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['title'] = title;
    data['due_on'] = dueOn;
    data['status'] = status;
    return data;
  }
}
