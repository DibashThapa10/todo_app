class Todo {
  int? id;
  String? title;
  String? description;
  bool? status;

  Todo({this.id, this.title, this.description, this.status}) {
    id = id;
    title = title;
    description = description;
    status = status;
  }

  toJson() {
    return {
      "id": id,
      "description": description,
      "title": title,
      "status": status
    };
  }

  fromJson(jsonData) {
    return Todo(
        id: jsonData['id'],
        title: jsonData['title'],
        description: jsonData['description'],
        status: jsonData['status']);
  }
}





// class ToDO {
//   String? id;
//   String? todotext;
//   bool isdone;

//   ToDO({
//     required this.id,
//     required this.todotext,
//     this.isdone = false,
//   });

//   static List<ToDO> todoList() {
//     return [];
//   }
// }
