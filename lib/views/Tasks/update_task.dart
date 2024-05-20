import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdummytest/model/update_model.dart';
import 'package:provider/provider.dart';

import '../../common/custom_btn.dart';
import '../../common/custom_textfield.dart';
import '../../controllers/get_all_taks_controller.dart';

class UpdateTask extends StatefulWidget {
  const UpdateTask({super.key, this.id, this.hintText});

  final id;
  final hintText;

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {

  TextEditingController controller =TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
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
                      hintText: widget.hintText,
                      keyboardType: TextInputType.text),

                  SizedBox(
                    height: 24,
                  ),
                  CustomButton(
                    text: 'U P D A T E',
                    onTap: () {
                      UpdateModel data = UpdateModel(
                        completed: true,
                        todo: controller.text,
                        userId: widget.id.toString(),
                      );
                      final id = widget.id;
                      print(id);
                      addTaskNotifier.updateTodos(data, widget.id);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
