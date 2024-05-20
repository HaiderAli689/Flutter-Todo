import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  List<String> _todoItems = [];

  @override
  void initState() {
    super.initState();
    _loadTodoItems();
  }

  _loadTodoItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _todoItems = prefs.getStringList('todoItems') ?? [];
    });
  }

  _saveTodoItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('todoItems', _todoItems);
  }

  _addTodoItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _todoItems.add(task);
      });
      _saveTodoItems();
    }
  }

  _removeTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
    _saveTodoItems();
  }

  _editTodoItem(int index, String newTask) {
    if (newTask.isNotEmpty) {
      setState(() {
        _todoItems[index] = newTask;
      });
      _saveTodoItems();
    }
  }

  void _addTodoTaskItem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: Text('New task'),
          content: TextField(
            controller: controller,
            autofocus: true,
          ),
          actions: <Widget>[
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('Cancel')),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                _addTodoItem(controller.text);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _editTodoTaskItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController();
        controller.text = _todoItems[index];
        return AlertDialog(
          title: Text('Edit task'),
          content: TextField(
            controller: controller,
            autofocus: true,
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                _editTodoItem(index, controller.text);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildTodoItem(String task, int index) {
    return ListTile(
      title: Text(task),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _editTodoTaskItem(index),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _removeTodoItem(index),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todoItems.length,
      itemBuilder: (context, index) {
        return _buildTodoItem(_todoItems[index], index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preferenece Todo List'),
        centerTitle: true,
        elevation: 0,
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodoTaskItem,
        tooltip: 'Add task',
        child: Icon(Icons.add),
      ),
    );
  }
}
