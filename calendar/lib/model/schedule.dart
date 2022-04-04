import 'package:drift/drift.dart';

class Schedules extends Table {
  //PRIMARY KEY
  IntColumn get id => integer()();

  TextColumn get content => text()();

  DateTimeColumn get date => dateTime()();

  IntColumn get startTime => integer()();

  IntColumn get colorId => integer()();

  DateTimeColumn get createdAt => dateTime()();
}