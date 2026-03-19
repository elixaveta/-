void main() {

  List<String> students = ["Лера", "Маша", "Саша", "Никита", "Ваня", "Кирилл"];
  List<String> subjects = ["Математика", "Физика", "Информатика", "Литература", "Физра"];

  List<List<int>> grades = [
    // Матем Физика Информ Литерат Физра
    [5, 5, 5, 5, 5],  // Лера
    [3, 4, 4, 4, 5],  // Маша
    [4, 4, 3, 3, 4],  // Саша
    [5, 5, 5, 4, 5],  // Никита
    [2, 3, 2, 4, 3],  // Ваня
    [5, 4, 4, 5, 5],  // Кирилл
  ];

  print("=" * 60);
  print("АНАЛИТИКА УСПЕВАЕМОСТИ ГРУППЫ");
  print("=" * 60);

  // 1
  print("\n1. КАТЕГОРИИ СТУДЕНТОВ ПО СРЕДНЕМУ БАЛЛУ:");
  List<String> excellent = []; // отличники 
  List<String> good = [];      // хорошисты 
  List<String> others = [];    // остальные 

  for (int i = 0; i < students.length; i++) {
    double avgGrade = 0;
    for (int grade in grades[i]) {
      avgGrade += grade;
    }
    avgGrade = avgGrade / subjects.length;

    if (avgGrade >= 4.5) {
      excellent.add(students[i]);
    } else if (avgGrade >= 3.5) {
      good.add(students[i]);
    } else {
      others.add(students[i]);
    }
  }

  print("Отличники (средний >= 4.5): ${excellent.isNotEmpty ? excellent.join(', ') : 'нет'}");
  print("Хорошисты (3.5 <= средний < 4.5): ${good.isNotEmpty ? good.join(', ') : 'нет'}");
  print("Остальные (средний < 3.5): ${others.isNotEmpty ? others.join(', ') : 'нет'}");

  // 2
  print("\n2. СТАТИСТИКА ОЦЕНОК:");
  Map<int, int> gradeCounts = {2: 0, 3: 0, 4: 0, 5: 0};
  for (var studentGrades in grades) {
    for (int grade in studentGrades) {
      gradeCounts[grade] = gradeCounts[grade]! + 1;
    }
  }

  for (int grade in [2, 3, 4, 5]) {
    print("Оценка $grade: ${gradeCounts[grade]} раз(а)");
  }

  // 3
  print("\n3. СТУДЕНТЫ С ПЯТЁРКАМИ ПО ПРЕДМЕТАМ:");
  for (int j = 0; j < subjects.length; j++) {
    List<String> studentsWith5 = [];
    for (int i = 0; i < students.length; i++) {
      if (grades[i][j] == 5) {
        studentsWith5.add(students[i]);
      }
    }
    print("${subjects[j]}: ${studentsWith5.isNotEmpty ? studentsWith5.join(', ') : 'нет'}");
  }

  // 4
  print("\n4. ПРЕДМЕТЫ БЕЗ ДВОЕК:");
  List<String> subjectsWithout2 = [];
  for (int j = 0; j < subjects.length; j++) {
    bool has2 = false;
    for (int i = 0; i < students.length; i++) {
      if (grades[i][j] == 2) {
        has2 = true;
        break;
      }
    }
    if (!has2) {
      subjectsWithout2.add(subjects[j]);
    }
  }

  if (subjectsWithout2.isNotEmpty) {
    for (var subject in subjectsWithout2) {
      print(subject);
    }
  } else {
    print("Нет предметов без двоек");
  }

  // 5
  print("\n5. ПРЕДМЕТ С НАИБОЛЬШИМ КОЛИЧЕСТВОМ ДВОЕК:");
  List<MapEntry<String, int>> subject2Counts = [];
  for (int j = 0; j < subjects.length; j++) {
    int count2 = 0;
    for (int i = 0; i < students.length; i++) {
      if (grades[i][j] == 2) {
        count2++;
      }
    }
    subject2Counts.add(MapEntry(subjects[j], count2));
  }

  int maxCount = 0;
  for (var entry in subject2Counts) {
    if (entry.value > maxCount) {
      maxCount = entry.value;
    }
  }

  List<MapEntry<String, int>> maxSubjects = subject2Counts.where((entry) => entry.value == maxCount).toList();

  for (var entry in maxSubjects) {
    if (entry.value > 0) {
      print("${entry.key}: ${entry.value} двоек");
    } else {
      print("Нет предметов с двойками");
      break;
    }
  }

  // 6
  print("\n6. СТУДЕНТ(Ы) С НАИБОЛЬШИМ КОЛИЧЕСТВОМ ПЯТЁРОК:");
  List<MapEntry<String, int>> student5Counts = [];
  for (int i = 0; i < students.length; i++) {
    int count5 = 0;
    for (int grade in grades[i]) {
      if (grade == 5) {
        count5++;
      }
    }
    student5Counts.add(MapEntry(students[i], count5));
  }

  int max5 = 0;
  for (var entry in student5Counts) {
    if (entry.value > max5) {
      max5 = entry.value;
    }
  }

  List<MapEntry<String, int>> topStudents = student5Counts.where((entry) => entry.value == max5).toList();

  for (var entry in topStudents) {
    print("${entry.key}: ${entry.value} пятёрок");
  }

  // 7
  print("\n7. ПРЕДМЕТЫ С ОЦЕНКОЙ НИЖЕ 4 (ДЛЯ КАЖДОГО СТУДЕНТА):");
  for (int i = 0; i < students.length; i++) {
    List<String> lowGradeSubjects = [];
    for (int j = 0; j < subjects.length; j++) {
      if (grades[i][j] < 4) {
        lowGradeSubjects.add(subjects[j]);
      }
    }

    if (lowGradeSubjects.isNotEmpty) {
      print("${students[i]}: ${lowGradeSubjects.length} предмет(ов) - ${lowGradeSubjects.join(', ')}");
    } else {
      print("${students[i]}: нет предметов с оценкой ниже 4");
    }
  }

  // 8
  print("\n8. ВСЕ ПАРЫ 'СТУДЕНТ — ПРЕДМЕТ' С ОЦЕНКОЙ 5:");
  List<String> pairsWith5 = [];
  for (int i = 0; i < students.length; i++) {
    for (int j = 0; j < subjects.length; j++) {
      if (grades[i][j] == 5) {
        pairsWith5.add("${students[i]} — ${subjects[j]}");
      }
    }
  }

  for (var pair in pairsWith5) {
    print(pair);
  }
}
