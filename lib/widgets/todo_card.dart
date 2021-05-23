import 'package:amplify_todo/controllers/todoController.dart';
import 'package:amplify_todo/models/Todo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  const TodoCard({Key key, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TodoController _todocontroller = Get.find();
    return Dismissible(
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.startToEnd) {
          _todocontroller.removeTodo(todo);
        } else {
          print('Remove item');
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
      child: Card(
        //   color: Color(0xffFABB27),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListTile(
          leading: Checkbox(
            value: todo.isDone,
            onChanged: (newValue) {
              _todocontroller.setToDoDone(todo, newValue);
            },
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
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
                DateFormat.yMMMMEEEEd().format(
                    DateTime.fromMillisecondsSinceEpoch(
                        todo.createdAt.toSeconds() * 1000)),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
