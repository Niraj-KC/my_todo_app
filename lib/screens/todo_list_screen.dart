import 'package:flutter/material.dart';
import 'package:my_todo_app/screens/add_task_screen.dart';
import 'package:my_todo_app/screens/edit_task_screen.dart';
import '../models/task.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> todos = [];

  void _addTodo() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AddTaskScreen(),
    )).then((newTask) {
      if (newTask != null) {
        setState(() {
          todos.add(newTask);
        });
      }
    });
  }

  void _toggleTodoStatus(Task todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteTodo(Task todo) {
    setState(() {
      todos.remove(todo);
    });
  }

  void _editTodo(Task todo) async {
    final updatedTask = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditTaskScreen(task: todo),
        ),
      );

      if (updatedTask != null) {
        setState(() {
          final index = todos.indexOf(todo);
          todos[index] = updatedTask;
        });
      }}
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text(
              todo.title,
              style: TextStyle(
                  decoration: todo.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
            subtitle: Text(todo.date.toString()),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: todo.isDone,
                  onChanged: (_) => _toggleTodoStatus(todo),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteTodo(todo),
                ),
              ],
            ),
            onTap: () {
              _editTodo(todo);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: Icon(Icons.add),
      ),
    );
  }
}
