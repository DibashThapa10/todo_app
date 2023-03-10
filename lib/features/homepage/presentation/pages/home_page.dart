import 'dart:convert';


import 'dart:math';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/features/homepage/data/models/todo.dart';
import 'package:todo_app/features/homepage/presentation/pages/todo_view.dart';

import '../widgets/menu_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 

  // final todosList = ToDO.todoList();
  // List<ToDO> _foundToDo = [];
  // final todoController = TextEditingController();
  late SharedPreferences prefs;
  List todos = [];
  setupTodo() async {
    prefs = await SharedPreferences.getInstance();
    String? stringTodo = prefs.getString('todo');
    List todoList = jsonDecode(stringTodo!);
    for (var todo in todoList) {
      setState(() {
        todos.add(Todo().fromJson(todo));
      });
    }
  }

  void saveTodo() {
    List items = todos.map((e) => e.toJson()).toList();
    prefs.setString('todo', jsonEncode(items));
  }

  @override
  void initState() {
    // _foundToDo = todosList;

    super.initState();
    setupTodo();
  }

  Color appcolor = const Color.fromRGBO(58, 66, 86, 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolor,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Todo App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      drawer: MenuDrawer(appcolor: appcolor),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                elevation: 8.0,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(64, 75, 96, .9),
                  ),
                  child: InkWell(
                    onTap: () async {
                      Todo t = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TodoView(todo: todos[index])));
                      setState(() {
                        todos[index] = t;
                      });
                      saveTodo();
                    },
                    child: makeListTile(todos[index], index),
                  ),
                ));
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black12,
        onPressed: () {
          addTodo();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  addTodo() async {
    int id = Random().nextInt(30);
    Todo t = Todo(id: id, title: '', description: '', status: false);
    Todo returnTodo = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TodoView(todo: t)));
    setState(() {
      todos.add(returnTodo);
    });
    saveTodo();
  }

  makeListTile(Todo todo, index) {
    return ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: const EdgeInsets.only(right: 12.0),
          decoration: const BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.white24))),
          child: CircleAvatar(
            backgroundColor: Colors.black26,
            child: Text("${index + 1}"),
          ),
        ),
        title: Row(
          children: [
            Text(
              todo.title.toString(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 10,
            ),
            todo.status ?? false
                ? const Icon(
                    Icons.done,
                    color: Colors.greenAccent,
                  )
                : Container()
          ],
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Wrap(
          children: <Widget>[
            Text(todo.description.toString(),
                overflow: TextOverflow.clip,
                maxLines: 1,
                style: const TextStyle(color: Colors.white))
          ],
        ),
        trailing: InkWell(
            onTap: () {
              delete(todo);
            },
            child: const Icon(Icons.delete, color: Colors.white, size: 30.0)));
  }

  delete(Todo todo) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text("Alert"),
              content: const Text("Are you sure to delete"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text("No")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        todos.remove(todo);
                      });
                      Navigator.pop(ctx);
                      saveTodo();
                    },
                    child: const Text("Yes"))
              ],
            ));
  }
}

  // return Scaffold(
  //   appBar: AppBar(
  //     backgroundColor: Colors.white10,
  //     elevation: 0,
  //     title: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: const [
  //         Icon(
  //           Icons.menu,
  //           color: Colors.black,
  //           size: 30,
  //         ),
  //         Text(
  //           "ToDo App",
  //           style: TextStyle(
  //             color: Colors.black,
  //             fontWeight: FontWeight.bold,
  //             fontSize: 20,
  //           ),
  //         ),
  //         CircleAvatar(
  //           backgroundImage: AssetImage("assets/birthday.jpg"),
  //         ),
  //       ],
  //     ),
  //   ),
  //   body: Stack(
  //     children: [
  //       Container(
  //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  //         child: Column(
  //           children: [
  //             Container(
  //               padding: const EdgeInsets.symmetric(horizontal: 15),
  //               decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(20),
  //                   border: Border.all(color: Colors.black12)),
  //               child: TextField(
  //                 onChanged: (value) => _runFilter(value),
  //                 decoration: const InputDecoration(
  //                   contentPadding: EdgeInsets.all(0),
  //                   prefixIcon: Icon(
  //                     Icons.search,
  //                     color: Colors.black,
  //                     size: 20,
  //                   ),
  //                   prefixIconConstraints:
  //                       BoxConstraints(maxHeight: 20, minWidth: 25),
  //                   border: InputBorder.none,
  //                   hintText: "Search...",
  //                   hintStyle: TextStyle(color: Colors.grey),
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: ListView(
  //                 children: [
  //                   Container(
  //                     margin: const EdgeInsets.only(top: 50, bottom: 20),
  //                     child: const Text(
  //                       "All ToDos",
  //                       style: TextStyle(
  //                           fontSize: 30, fontWeight: FontWeight.w500),
  //                     ),
  //                   ),
  //                   for (ToDO todos in _foundToDo.reversed)
  //                     ToDoItem(
  //                       todo: todos,
  //                       onToDoChanged: _handleToDoChange,
  //                       onDeleteItem: _deleteToDoItem,
  //                     ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       Align(
  //         alignment: Alignment.bottomCenter,
  //         child: Row(
  //           children: [
  //             Expanded(
  //                 child: Container(
  //               padding:
  //                   const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
  //               margin:
  //                   const EdgeInsets.only(bottom: 20, right: 20, left: 20),
  //               decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   boxShadow: const [
  //                     BoxShadow(
  //                         color: Colors.grey,
  //                         offset: Offset(0.0, 0.0),
  //                         blurRadius: 10.0,
  //                         spreadRadius: 0.0)
  //                   ],
  //                   borderRadius: BorderRadius.circular(10)),
  //               child: TextField(
  //                 controller: todoController,
  //                 decoration: const InputDecoration(
  //                     hintText: "Add new todo item",
  //                     border: InputBorder.none),
  //               ),
  //             )),
  //             Container(
  //               margin: const EdgeInsets.only(bottom: 20, right: 20),
  //               child: ElevatedButton(
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: Colors.blue,
  //                   minimumSize: const Size(60, 60),
  //                   elevation: 10,
  //                 ),
  //                 child: const Text(
  //                   "+",
  //                   style: TextStyle(
  //                     fontSize: 40,
  //                   ),
  //                 ),
  //                 onPressed: () {
  //                   _addToDoItem(todoController.text);
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
  //       )
  //     ],
  //   ),
  // );

  // void _handleToDoChange(ToDO todo) {
  //   setState(() {
  //     todo.isdone = !todo.isdone;
  //   });
  // }

  // void _deleteToDoItem(String id) {
  //   setState(() {
  //     todosList.removeWhere((item) => item.id == id);
  //   });
  // }

  // void _addToDoItem(String todo) async {
  //   setState(() {
  //     todosList.add(ToDO(
  //         id: DateTime.now().millisecondsSinceEpoch.toString(),
  //         todotext: todo));
  //   });

  //   todoController.clear();
  // }

  // void _runFilter(String enteredKeyword) {
  //   List<ToDO> results = [];
  //   if (enteredKeyword.isEmpty) {
  //     results = todosList;
  //   } else {
  //     results = todosList
  //         .where((item) => item.todotext!
  //             .toLowerCase()
  //             .contains(enteredKeyword.toLowerCase()))
  //         .toList();
  //   }
  //   setState(() {
  //     _foundToDo = results;
  //   });
  // }




