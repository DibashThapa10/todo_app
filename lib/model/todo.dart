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
    return [
      ToDO(
        id: '01',
        todotext: 'Wake Up',
      ),
      ToDO(
        id: '02',
        todotext: 'Running',
      ),
      ToDO(
        id: '03',
        todotext: 'Buy Groceries',
      ),
      ToDO(
        id: '04',
        todotext: 'Brush Teeth',
      ),
      ToDO(
        id: '05',
        todotext: 'Have Breakfast',
      ),
      ToDO(
        id: '06',
        todotext: 'Ready For School',
      ),
    ];
  }
}
