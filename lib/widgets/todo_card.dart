import 'package:amplify_todo/models/Todo.dart';
import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;

  const TodoCard({Key key, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                todo.name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Checkbox(
              value: false, //  todo.status,
              onChanged: (newValue) {
                // Database().updateTodo(newValue, uid, todo.todoId);
              },
            ),
          ],
        ),
      ),
    );
  }
}
