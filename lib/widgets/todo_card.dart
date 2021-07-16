import 'package:amplify_todo/controllers/todoController.dart';
import 'package:amplify_todo/models/Todo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  const TodoCard({required this.todo});

  @override
  Widget build(BuildContext context) {
    TodoController _todocontroller = Get.find();
    return _buildContent(_todocontroller);
  }

  Dismissible _buildContent(TodoController _todocontroller) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.startToEnd) {
          _todocontroller.removeTodo(todo);
        }
      },
      background: Container(
        alignment: Alignment.centerLeft,
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      key: ValueKey(todo.id),
      child: _buildCard(_todocontroller),
    );
  }

  Card _buildCard(TodoController _todocontroller) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: Checkbox(
          value: todo.isDone,
          onChanged: (newValue) {
            _todocontroller.setToDoDone(todo, newValue!);
          },
        ),
        title: Text(
          todo.name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMMEEEEd()
                  .format(todo.createdAt!.getDateTimeInUtc()),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
