import 'package:flutter/material.dart';
import 'package:todo_app/widget/todo_list.dart';

import '../widget/new_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(
              Icons.menu,
              color: Colors.black,
              size: 30,
            ),
            Text(
              "ToDo App",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            CircleAvatar(
              backgroundImage: AssetImage("assets/profile.png"),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            const SearchBox(),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50, bottom: 20),
                    child: const Text(
                      "All ToDos",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const ToDoItem(),
                  const ToDoItem(),
                  const ToDoItem(),
                  const ToDoItem(),
                  const ToDoItem(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
