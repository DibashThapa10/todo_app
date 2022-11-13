class ToDO {
  final String id;
  final String todotext;
  final bool isdone;

  ToDO({
    required this.id,
    required this.todotext,
    this.isdone = false,
  });

  static List<ToDO> todoList() {
    return [
      ToDO(id: '01', todotext: 'Wake Up', isdone: true),
      ToDO(id: '02', todotext: 'Running', isdone: true),
      ToDO(
        id: '03',
        todotext: 'Buy Groceries',
      ),
      ToDO(
        id: '04',
        todotext: 'Brush Teeth',
      ),
      ToDO(id: '05', todotext: 'Have Breakfast', isdone: true),
      ToDO(
        id: '06',
        todotext: 'Ready For School',
      ),
    ];
  }
}
