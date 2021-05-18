import 'package:amplify_todo/controllers/authController.dart';
import 'package:amplify_todo/controllers/todoController.dart';
import 'package:amplify_todo/controllers/userController.dart';
import 'package:amplify_todo/widgets/todo_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomePage extends StatelessWidget {
  //final TodoController _todocontroller = Get.put(TodoController());
  TodoController _todocontroller = Get.find();
  AuthController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: GetX<UserController>(
            initState: (_) async {
              await Get.find<UserController>().getCurrUser();
            },
            builder: (_) {
              if (_.user.email != null) {
                return Text("Welcome " + _.user.email);
              } else {
                return Text("loading...");
              }
            },
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.lightbulb),
              onPressed: () {
                if (Get.isDarkMode) {
                  Get.changeTheme(ThemeData.light());
                } else {
                  Get.changeTheme(ThemeData.dark());
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                controller.signOut();
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Add Todo Here:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Card(
                margin: EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _todocontroller.todovalueController,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () async {
                          if (_todocontroller.todovalueController.text != "") {
                            await _todocontroller.addTodo();
                            _todocontroller.todovalueController.clear();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),

              Text(
                "Your Todos",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    itemCount: _todocontroller.todoList.length,
                    itemBuilder: (_, index) {
                      return TodoCard(todo: _todocontroller.todoList[index]);

                      // ListTile(
                      //   title: Text(
                      //     _todocontroller.todoList[index].id.toString(),
                      //     style: TextStyle(color: Colors.black),
                      //   ),
                      // );
                    },
                  ),
                ),
              ),
              // GetX<TodoController>(
              //   initState: (_) async {
              //     await Get.find<TodoController>().getTodos();
              //   },
              //   builder: (TodoController todoController) {
              //     if (todoController != null &&
              //         todoController.todoList != null) {
              //       return Expanded(
              //         child: ListView.builder(
              //           itemCount: todoController.todoList.length,
              //           itemBuilder: (_, index) {
              //             return ListTile(
              //               title: Text(todoController.todoList[index].createdAt
              //                   .toString()),
              //             );
              //           },
              //         ),
              //       );
              //     } else {
              //       return Text("loading...");
              //     }
              //   },
              // )
            ],
          ),
        ));
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder(
//         init: TodoController(),
//         builder: (todoController) {
//           return Scaffold(
//               appBar: AppBar(
//                 title: GetX<UserController>(
//                   initState: (_) async {
//                     await Get.find<UserController>().getCurrUser();
//                   },
//                   builder: (_) {
//                     if (_.user.email != null) {
//                       return Text("Welcome " + _.user.email);
//                     } else {
//                       return Text("loading...");
//                     }
//                   },
//                 ),
//                 centerTitle: true,
//                 actions: [
//                   IconButton(
//                     icon: Icon(Icons.lightbulb),
//                     onPressed: () {
//                       if (Get.isDarkMode) {
//                         Get.changeTheme(ThemeData.light());
//                       } else {
//                         Get.changeTheme(ThemeData.dark());
//                       }
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.logout),
//                     onPressed: () {
//                       controller.signOut();
//                     },
//                   ),
//                 ],
//               ),
//               floatingActionButton: FloatingActionButton(
//                 onPressed: () {
//                   todoController.addTodo();
//                 },
//                 //backgroundColor: ColorConstants.appBarColor,
//                 child: Icon(Icons.add),
//               ),
//               body: ListView.builder(
//                   itemCount: todoController.todoList.value.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return ListTile(
//                       title: Text(todoController.todoList.value[index].createdAt
//                           .toString()),
//                     );

//                     //TodoListTile(todoTitle: todoController.todoItems[index]);
//                   }));
//         });
//   }
// }

//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: GetX<UserController>(
//             initState: (_) async {
//               await Get.find<UserController>().getCurrUser();
//             },
//             builder: (_) {
//               if (_.user.email != null) {
//                 return Text("Welcome " + _.user.email);
//               } else {
//                 return Text("loading...");
//               }
//             },
//           ),
//           centerTitle: true,
//           actions: [
//             IconButton(
//               icon: Icon(Icons.lightbulb),
//               onPressed: () {
//                 if (Get.isDarkMode) {
//                   Get.changeTheme(ThemeData.light());
//                 } else {
//                   Get.changeTheme(ThemeData.dark());
//                 }
//               },
//             ),
//             IconButton(
//               icon: Icon(Icons.logout),
//               onPressed: () {
//                 controller.signOut();
//               },
//             ),
//           ],
//         ),
//         body: Padding(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             //mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 "Add Todo Here:",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Card(
//                 margin: EdgeInsets.all(20),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: TextFormField(
//                           controller: _todocontroller.todoController,
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.add),
//                         onPressed: () {
//                           if (_todocontroller.todoController.text != "") {
//                             _todocontroller.addTodo();
//                             _todocontroller.todoController.clear();
//                           }
//                         },
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               Text(
//                 "Your Todos",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               GetX<TodoController>(
//                 init: Get.put<TodoController>(TodoController()),
//                 builder: (TodoController todoController) {
//                   if (todoController != null && todoController.todos != null) {
//                     return Expanded(
//                       child: ListView.builder(
//                         itemCount: todoController.todoList.value.length,
//                         itemBuilder: (_, index) {
//                           return ListTile(
//                             title: Text(todoController
//                                 .todoList.value[index].createdAt
//                                 .toString()),
//                           );
//                         },
//                       ),
//                     );
//                   } else {
//                     return Text("loading...");
//                   }
//                 },
//               )
//             ],
//           ),
//         ));
//   }
// }