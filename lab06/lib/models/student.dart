class Student {
  final int id;
  final String name;
  final String major;
  final String course;

  const Student({
    required this.id,
    required this.name,
    required this.major,
    required this.course,
  });
}

const List<Student> students = [
  Student(
    id: 31,
    name: 'Гэрэл',
    major: 'Information Technology',
    course: '3-р курс',
  ),
  Student(
    id: 22,
    name: 'Мөнхзаяа',
    major: 'Information Technology',
    course: '2-р курс',
  ),
  Student(
    id: 10,
    name: 'Батцэцэг',
    major: 'Information Technology',
    course: '3-р курс',
  ),
  Student(
    id: 1,
    name: 'Баттогтох',
    major: 'Information Technology',
    course: '2-р курс',
  ),
];
