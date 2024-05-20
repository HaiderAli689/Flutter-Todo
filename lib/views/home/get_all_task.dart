import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdummytest/constants/app_constants.dart';
import 'package:flutterdummytest/services/helper/taks_helper.dart';

import '../../model/get_all_tasks_model.dart';


class GetAllTaskScreen extends StatefulWidget {
  @override
  _GetAllTaskScreenState createState() => _GetAllTaskScreenState();
}

class _GetAllTaskScreenState extends State<GetAllTaskScreen> {
  final TaskHelper _apiService = TaskHelper();
  final ScrollController _scrollController = ScrollController();

  List<Todo> _tasks = [];
  int _skip = 0;
  bool _isLoading = false;
  bool _hasMore = true;
  bool _isReloading = false;

  @override
  void initState() {
    super.initState();
    _fetchTasks();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && _hasMore) {
        _fetchTasks();
      }
    });
  }

  Future<void> _fetchTasks() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final newTasks = await _apiService.fetchTasks(skip: _skip);
      setState(() {
        _skip += newTasks.todos.length;
        _tasks.addAll(newTasks.todos);
        _hasMore = newTasks.todos.length == 10;
      });

      if (!_isReloading && _tasks.every((task) => task.completed)) {
        _isReloading = true;
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _reloadSecondPage() async {
    final newTasks = await _apiService.fetchTasks(limit: 10, skip: 0);
    setState(() {
      _tasks.clear();
      _tasks.addAll(newTasks.todos);
      _skip = newTasks.todos.length;
      _isReloading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Task List'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _isReloading ? null : _reloadSecondPage,
          ),
        ],
      ),
      body: _tasks.isEmpty
          ? Center(child: _isLoading ? Center(child: CircularProgressIndicator()) : Text('No tasks available'))
          : ListView.builder(
        controller: _scrollController,
        itemCount: _tasks.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _tasks.length) {
            return Center(child: CircularProgressIndicator());
          }
          final task = _tasks[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 80.h,
              width: width,
              decoration: BoxDecoration(
                color: kbg,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: ListTile(
                title: Text(task.todo),
                trailing: Checkbox(
                  value: task.completed,
                  onChanged: (bool? value) {},
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
