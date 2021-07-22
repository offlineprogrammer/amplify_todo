import 'package:amplify_todo/controllers/authController.dart';
import 'package:amplify_todo/controllers/todoController.dart';
import 'package:amplify_todo/controllers/userController.dart';
import 'package:amplify_todo/widgets/todo_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomePage extends GetWidget<UserController> {
  TodoController _todocontroller = Get.find();
  AuthController _authcontroller = Get.find();

  get kTransparentImage => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffE1E5E4),
        appBar: AppBar(
          title: GetX<UserController>(
            initState: (_) async {
              await Get.find<UserController>().getCurrUser();
            },
            builder: (_) {
              return Text(controller.user?.email ?? '',
                  style: TextStyle(fontSize: 12));
            },
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                _authcontroller.signOut();
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.dialog(AlertDialog(
              title: Text('Add Todo here'),
              content: TextFormField(
                controller: _todocontroller.todoTitleController,
                decoration: InputDecoration(hintText: "Title"),
              ),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () async {
                    if (_todocontroller.todoTitleController.text != "") {
                      await _todocontroller.addTodo();
                      _todocontroller.todoTitleController.clear();
                    }
                    Get.back();
                  },
                ),
              ],
            ));
          },
          child: Icon(Icons.add),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(
                () => (controller.imageUrl.value != null &&
                        controller.imageUrl.value.isEmpty == false)
                    ? Container(
                        height: 150,
                        child: controller.isLoading.value == true
                            ? const Center(child: CircularProgressIndicator())
                            : Image.network(controller.imageUrl.value))
                    : Container(
                        color: Color(0xffE1E5E4),
                        height: 150,
                        child: Image.asset(
                          'images/profile_image.png',
                          fit: BoxFit.contain,
                        ),
                      ),
              ),
              SizedBox(
                height: 8,
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new IconButton(
                    onPressed: () => controller.setUserImage(),
                    icon: Icon(Icons.camera_alt),
                  ),
                ],
              ),
              Text(
                "Your Todos",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    itemCount: _todocontroller.todoList.length,
                    itemBuilder: (_, index) {
                      return TodoCard(todo: _todocontroller.todoList[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
