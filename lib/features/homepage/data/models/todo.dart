class ToDO {
  String? id;
  String? todotext;
  bool isdone;

  ToDO({
    required this.id,
    required this.todotext,
    this.isdone = false,
  });

  static List<ToDO> todoList() {
    return [];
  }
}
