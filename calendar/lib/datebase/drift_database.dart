import 'dart:io';

import 'package:calendar/model/category_color.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../model/schedule.dart'; //private 값 불러오기 X

part 'drift_database.g.dart';

@DriftDatabase(
  tables: [Schedules, CategoryColors],
)
class LocalDatabase extends _$LocalDatabase {
  // _$LocalDatabase : Drift가 만들어줌 -> drift_datavase.g.dart에 생성
  LocalDatabase() : super(_openConnection());

  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  Future<int> createCategoryColor(CategoryColorsCompanion data) =>
      into(categoryColors).insert(data);

  Future<List<CategoryColor>> getCategoryColors() =>
      select(categoryColors).get();

  Stream<List<Schedule>> watchSchedules(DateTime date) {
    final query = select(schedules);
    query.where((tbl) => tbl.date.equals(date));
    return query.watch();
  }

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
