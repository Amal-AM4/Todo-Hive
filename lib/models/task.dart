import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.createdAtDate,
    required this.createdAtTime,
    required this.isCompleted,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String subTitle;
  @HiveField(3)
  DateTime createdAtTime;
  @HiveField(4)
  DateTime createdAtDate;
  @HiveField(5)
  bool isCompleted;

  // create a new task
  factory Task.create({
    required String? title,
    required String? subTitle,
    DateTime? createdAtTime,
    DateTime? createdAtDate,
  }) => Task(
    id: const Uuid().v4(),
    title: title ?? '',
    subTitle: subTitle ?? '',
    createdAtDate: createdAtDate ?? DateTime.now(),
    createdAtTime: createdAtTime ?? DateTime.now(),
    isCompleted: false,
  );
}
