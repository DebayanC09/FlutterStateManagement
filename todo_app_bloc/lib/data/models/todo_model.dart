class TodoModel {
  String? id;
  String? title;
  String? description;
  String? dateTime;
  String? priority;

  TodoModel({
    this.id,
    this.title,
    this.description,
    this.dateTime,
    this.priority,
  });

  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'].toString();
    title = json['title']?.toString();
    description = json['description']?.toString();
    dateTime = json['dateTime']?.toString();
    priority = json['priority']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['dateTime'] = dateTime;
    data['priority'] = priority;
    return data;
  }
}
