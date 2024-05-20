import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutterdummytest/model/add_task_model.dart';
import 'package:flutterdummytest/model/update_model.dart';
import 'package:flutterdummytest/services/helper/taks_helper.dart';
import 'package:get/get.dart';

class GetAllTaskController extends ChangeNotifier{

  getAllTodos(){
  var getTask =  TaskHelper().getAllTask();
  return getTask;
  }

  addTodos(AddlTodosModel model) {
    TaskHelper().addTask(model).then((response) async {
      if (response) {

        Get.snackbar('Todos Successfully Added', 'Enjoy your Todos app.',
            colorText: Colors.white,
            backgroundColor: Colors.blue,
            icon: Icon(Icons.check_circle));
      }
      else if(!response)
      {
        Get.snackbar('Todos Failed', 'Please check your credentials',
            colorText: Colors.white,
            backgroundColor: Colors.red,
            icon: Icon(Icons.add_alert));
      }
    });
  }updateTodos(UpdateModel model,int id ) {
    TaskHelper().updateTask(model, id).then((response) async {
      if (response) {

        Get.snackbar('Todos Successfully Updated', 'Enjoy your Todos app.',
            colorText: Colors.white,
            backgroundColor: Colors.blue,
            icon: Icon(Icons.check_circle));
      }
      else if(!response)
      {
        Get.snackbar('Todos Failed', 'Please check your credentials',
            colorText: Colors.white,
            backgroundColor: Colors.red,
            icon: Icon(Icons.add_alert));
      }
    });
  }

  deleteTodos(int id ) {
    TaskHelper().deleteTask(id).then((response) async {
      if (response) {

        Get.snackbar('Todos Successfully Deleted', 'Enjoy your Todos app.',
            colorText: Colors.white,
            backgroundColor: Colors.blue,
            icon: Icon(Icons.check_circle));
      }
      else if(!response)
      {
        Get.snackbar('Todos Failed', 'Please check your credentials',
            colorText: Colors.white,
            backgroundColor: Colors.red,
            icon: Icon(Icons.add_alert));
      }
    });
  }


}