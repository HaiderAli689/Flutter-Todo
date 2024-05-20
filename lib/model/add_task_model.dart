// To parse this JSON data, do
//
//     final addlTodosModel = addlTodosModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AddlTodosModel addlTodosModelFromJson(String str) => AddlTodosModel.fromJson(json.decode(str));

String addlTodosModelToJson(AddlTodosModel data) => json.encode(data.toJson());

class AddlTodosModel {
  final String todo;
  final bool completed;
  final int userId;

  AddlTodosModel({
    required this.todo,
    required this.completed,
    required this.userId,
  });

  factory AddlTodosModel.fromJson(Map<String, dynamic> json) => AddlTodosModel(
    todo: json["todo"],
    completed: json["completed"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "todo": todo,
    "completed": completed,
    "userId": userId,
  };
}
