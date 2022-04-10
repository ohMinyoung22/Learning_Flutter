import 'package:calendar/datebase/drift_database.dart';
import 'package:calendar/model/category_color.dart';
import 'package:calendar/screen/home_screen.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

const DEFAULT_COLORS = [
  'F44336',
  'FF9800',
  'FF2B3B',
  'FCAF50',
  '2196F3',
  '3F51B5',
  '9C27B0'
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //플러터 준비까지 기다림

  await initializeDateFormatting();

  final database = LocalDatabase();

  GetIt.I.registerSingleton<LocalDatabase>(database);
  
  final colors = await database.getCategoryColors();

  if (colors.isEmpty) {
    for (String hex in DEFAULT_COLORS) {
      await database.createCategoryColor(
        CategoryColorsCompanion(hexCode: Value(hex)),
      );
    }
  }

  runApp(MaterialApp(home: HomeScreen()));
}
