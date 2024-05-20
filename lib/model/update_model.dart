// To parse this JSON data, do
//
//     final updateModel = updateModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UpdateModel updateModelFromJson(String str) => UpdateModel.fromJson(json.decode(str));

String updateModelToJson(UpdateModel data) => json.encode(data.toJson());

class UpdateModel {
  final String todo;
  final bool completed;
  final String userId;

  UpdateModel({
    required this.todo,
    required this.completed,
    required this.userId,
  });

  factory UpdateModel.fromJson(Map<String, dynamic> json) => UpdateModel(
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
