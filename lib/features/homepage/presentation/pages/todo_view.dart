import 'package:flutter/material.dart';

import '../../data/models/todo.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key, required this.todo});
  final Todo todo;

  @override
  State<TodoView> createState() => _TodoViewState(todo: todo);
}

class _TodoViewState extends State<TodoView> {
  Todo todo;
  _TodoViewState({required this.todo});
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void dismissKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      return currentFocus.unfocus();
    }
  }

  @override
  void initState() {
    super.initState();
    titleController.text = todo.title!;
    descriptionController.text = todo.description!;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: dismissKeyboard,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          centerTitle: true,
          elevation: 2,
          backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
          title: const Text("Create Todo List"),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                    child: colorOverride(TextField(
                  onChanged: (data) {
                    todo.title = data;
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.white),
                    labelText: "Title",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    //fillColor: Colors.green
                  ),
                  controller: titleController,
                ))),
                const SizedBox(
                  height: 25,
                ),
                Container(
                    child: colorOverride(TextField(
                  maxLines: 5,
                  onChanged: (data) {
                    todo.description = data;
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.white),
                    labelText: "Description",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    //fillColor: Colors.green
                  ),
                  controller: descriptionController,
                ))),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 55.0,
          child: BottomAppBar(
            color: const Color.fromRGBO(58, 66, 86, 1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                title: const Text("Alert"),
                                content: Text(
                                    "Mark this todo as ${todo.status ?? false ? 'not done' : 'done'}  "),
                                actions: <Widget>[
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text("No"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        todo.status = !todo.status!;
                                      });
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text("Yes"),
                                  )
                                ],
                              ));
                    },
                    child: Text(
                      "${todo.status ?? false ? 'Mark as not done' : 'Mark as done'} ",
                      style: const TextStyle(color: Colors.white),
                    )),
                const VerticalDivider(
                  color: Colors.white,
                ),
                IconButton(
                  icon: const Icon(Icons.save, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context, todo);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget colorOverride(Widget child) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.white,
        hintColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
      ),
      child: child,
    );
  }
}
