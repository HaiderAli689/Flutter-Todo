import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdummytest/common/app_style.dart';
import 'package:flutterdummytest/common/custom_btn.dart';
import 'package:flutterdummytest/common/reusable_text.dart';
import 'package:flutterdummytest/constants/app_constants.dart';
import 'package:flutterdummytest/controllers/get_all_taks_controller.dart';
import 'package:flutterdummytest/controllers/login_controller.dart';
import 'package:flutterdummytest/model/get_todos_id_model.dart';
import 'package:flutterdummytest/views/Tasks/add_tasks.dart';
import 'package:flutterdummytest/views/Tasks/complete_todo_task.dart';
import 'package:flutterdummytest/views/auth/login_screen.dart';
import 'package:flutterdummytest/views/home/get_all_task.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Tasks/update_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GetAllTaskController>(context);
    final loginController = Provider.of<LoginController>(context);
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CustomButton(
          text: 'Add Task',
          onTap: () {
            Get.to(() => AddTaskTasks());
          },
        ),
      ),
      appBar: AppBar(
        title: ReusableText(
          text: 'Home',
          style: appstyle(20, kDark, FontWeight.w600),
        ),
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(()=> ToDoListScreen());
            },
            child: Container(
              height: 40.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: kbg,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: ReusableText(
                  text: 'Offline Tasks',
                  style: appstyle(12, kDark, FontWeight.w500),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w,),
          GestureDetector(
            onTap: () {
              Get.to(() => GetAllTaskScreen());
            },
            child: Container(
              height: 40.h,
              width: 110.w,
              decoration: BoxDecoration(
                  color: kbg, borderRadius: BorderRadius.circular(8.r)),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableText(
                        text: 'All Tasks',
                        style: appstyle(12, kDark, FontWeight.w500),
                      ),
                      Icon(CupertinoIcons.arrow_right_circle),
                    ],
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              loginController.userLogout();
              Get.offAll(() => LoginScreen());
            },
            icon: Icon(Icons.login_outlined),
          ),
        ],
      ),
      body: FutureBuilder<GetTodosByIdModel>(
        future: GetAllTaskController().getAllTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.todos.isEmpty) {
            return Center(child: Text('No todos found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.todos.length,
              itemBuilder: (context, index) {
                Todo todo = snapshot.data!.todos[index];
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  child: Container(
                    height: 100.h,
                    width: width,
                    decoration: BoxDecoration(
                        color: kPrimary,
                        borderRadius: BorderRadius.circular(12.r)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                todo.completed
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                color:
                                    todo.completed ? Colors.green : Colors.red,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              ReusableText(
                                text: todo.todo,
                                style: appstyle(12, kLight, FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      controller.deleteTodos(todo.id);
                                    });
                                  },
                                  child: Container(
                                    height: 40.h,
                                    width: width,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(32.r),
                                    ),
                                    child: Center(
                                        child: ReusableText(
                                      text: 'Delete',
                                      style:
                                          appstyle(14, kLight, FontWeight.w500),
                                    )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      Get.to(() => UpdateTask(
                                            id: todo.id,
                                            hintText: todo.todo,
                                          ));
                                    });
                                  },
                                  child: Container(
                                    height: 40.h,
                                    width: width,
                                    decoration: BoxDecoration(
                                      color: kLight,
                                      borderRadius: BorderRadius.circular(32.r),
                                    ),
                                    child: Center(
                                        child: ReusableText(
                                      text: 'Edit',
                                      style:
                                          appstyle(14, kDark, FontWeight.w500),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
