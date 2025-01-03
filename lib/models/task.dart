class Task {
  final String id;
  final String title;
  bool isDone;
  final DateTime date;
  Task({required this.id, required this.title, required this.date, this.isDone = false});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(id: json['id'], title: json['title'], date: DateTime.parse(json['date']), isDone: json['isDone']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'title': title, 'isDone': isDone, 'date': date.toIso8601String()};

  Task copywith({String? id, String? title, bool? isDone, DateTime? date}) => Task(id: id ?? this.id, title: title ?? this.title, date: date ?? this.date, isDone: isDone ?? this.isDone);
}