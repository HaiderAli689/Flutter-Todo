
import 'dart:convert';
import 'dart:ffi';

import 'package:flutterdummytest/model/add_task_model.dart';
import 'package:flutterdummytest/model/get_all_tasks_model.dart';
import 'package:flutterdummytest/model/get_todos_id_model.dart';
import 'package:flutterdummytest/model/update_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
class TaskHelper{

  Future<GetTodosByIdModel> getAllTask() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('id');
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    final url = Uri.parse("${Config.getTodosUrl}$id"); // Ensure Config.todosUrl is defined and correct

      final response = await http.get(url, headers: requestHeaders);

      if (response.statusCode == 200) {
        print('<<<<<<Fetched>>>>>>');
        var getTask = getTodosByIdModelFromJson(response.body);
        print("get All Task : $getTask");
        return getTask;
      } else {
        print('Failed to load tasks. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load todos');
      }

  }



  Future<bool> addTask(AddlTodosModel model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    final url = Uri.parse(Config.addTodosUrl);
    final response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200){

      var data = getTodosByIdModelFromJson(response.body);
      print(data.todos);
      return true;
    } else {
     throw Exception('Failed');
    }

  }

  Future<bool> updateTask(UpdateModel model,int id ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    final url = Uri.parse("https://dummyjson.com/todos/$id");
    final response = await http.put(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200){

      return true;
    } else {
      return false;
    }

  }

  Future<bool> deleteTask(int id) async {

    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    final url = Uri.parse("https://dummyjson.com/todos/$id");
    final response = await http.delete(
      url,
      headers: requestHeaders,
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200){

      return true;
    } else {
      return false;
    }

  }

  Future<AllTaskModel> fetchTasks({int limit = 10, int skip =0}) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    final url = Uri.parse("https://dummyjson.com/todos?limit=$limit&skip=$skip");
    final response = await http.get(
      url,
      headers: requestHeaders,
    );
    print("All Task : ${response.statusCode}");
    print("All Task : ${response.body}");
    if (response.statusCode == 200) {
      return allTaskModelFromJson(response.body);
    } else {
      throw Exception('Failed to load tasks');
    }
  }

}