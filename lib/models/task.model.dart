class Task {
  String content;
  bool isCompleted;

  Task(this.content, this.isCompleted);

  // Преобразование объекта в Map для хранения в Hive
  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'isCompleted': isCompleted,
    };
  }

  // Создание объекта из Map
  factory Task.fromMap(Map<dynamic, dynamic> map) {
    return Task(
      map['content'] as String,
      map['isCompleted'] as bool,
    );
  }
}
