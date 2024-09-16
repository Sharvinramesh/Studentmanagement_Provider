import 'package:flutter/material.dart';
import 'package:statemanagementprovider/db/db_functions.dart';

class StudentDetailProvider extends ChangeNotifier {
  final DatabaseHelper db = DatabaseHelper();

  Future<void> deleteStudent(int studentId) async {
    await db.deleteStudent(studentId);
  }
}