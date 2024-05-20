import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdummytest/common/custom_btn.dart';
import 'package:flutterdummytest/common/custom_textfield.dart';
import 'package:flutterdummytest/controllers/get_all_taks_controller.dart';
import 'package:flutterdummytest/model/add_task_model.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AddTaskTasks extends StatefulWidget {
  const AddTaskTasks({super.key});

  @override
  State<AddTaskTasks> createState() => _AddTaskTasksState();
}

class _AddTaskTasksState extends State<AddTaskTasks> {
  TextEditingController controller = TextEditingController();

  String _randomId = '';

  void _generateRandomId() {
    var uuid = Uuid();
    setState(() {
      _randomId = uuid.v4();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetAllTaskController>(
        builder: (context, addTaskNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Get All Task'),
          elevation: 0,
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Column(
            children: [
              CustomTextField(
                  controller: controller,
                  hintText: "Enter some text",
                  keyboardType: TextInputType.text),
              SizedBox(
                height: 24,
              ),
              CustomButton(
                text: 'S U B M I T',
                onTap: ()async {
                  SharedPreferences prefs =await SharedPreferences.getInstance();
                  int? userId = prefs.getInt('id');
                  _generateRandomId();
                  AddlTodosModel model = AddlTodosModel(
                    completed: true,
                    todo: controller.text,
                    userId: userId!,
                  );
                  addTaskNotifier.addTodos(model);
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
