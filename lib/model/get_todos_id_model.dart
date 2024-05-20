import 'dart:convert';

GetTodosByIdModel getTodosByIdModelFromJson(String str) => GetTodosByIdModel.fromJson(json.decode(str));

String getTodosByIdModelToJson(GetTodosByIdModel data) => json.encode(data.toJson());

class GetTodosByIdModel {
  final List<Todo> todos;
  final int total;
  final int skip;
  final int limit;

  GetTodosByIdModel({
    required this.todos,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory GetTodosByIdModel.fromJson(Map<String, dynamic> json) => GetTodosByIdModel(
    todos: json["todos"] != null
        ? List<Todo>.from(json["todos"].map((x) => Todo.fromJson(x)))
        : [],
    total: json["total"] ?? 0,
    skip: json["skip"] ?? 0,
    limit: json["limit"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "todos": List<dynamic>.from(todos.map((x) => x.toJson())),
    "total": total,
    "skip": skip,
    "limit": limit,
  };
}

class Todo {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  Todo({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: json["id"],
    todo: json["todo"],
    completed: json["completed"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "todo": todo,
    "completed": completed,
    "userId": userId,
  };
}
