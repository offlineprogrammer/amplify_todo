import 'package:amplify_todo/models/Todo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;

  const TodoCard({Key key, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
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
        color: Color(0xffFABB27),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListTile(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.check_circle,
              size: 35,
              color: Colors.green[900],
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
          title: Text(
            todo.name,
            style: TextStyle(
              color: Colors.white,
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
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
