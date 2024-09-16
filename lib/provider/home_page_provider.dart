import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:statemanagementprovider/db/db_functions.dart';
import 'package:statemanagementprovider/model/model.dart';


class HomePageProvider extends ChangeNotifier {
  late DatabaseHelper databaseHelper;
  List<Student> students = [];
 List<Student> filteredStudents = [];
  bool noResult = false;
  String? profileImagePath;
  XFile? image;
   Student? currentStudent;

  HomePageProvider() {
    databaseHelper = DatabaseHelper();
  }


  Future<void> updateStudent(Student updatedStudent) async {
    await databaseHelper.updateStudent(updatedStudent);
    await refreshStudentList();
  }

  void filterStudents(String query) {
    final lowerCaseQuery = query.toLowerCase();
    if (lowerCaseQuery.isEmpty) {
      filteredStudents = List.from(students);
      noResult = false;
    } else {
      filteredStudents = students.where((student) {
        return student.name.toLowerCase().contains(lowerCaseQuery);
      }).toList();
      noResult = filteredStudents.isEmpty;
    }
    notifyListeners();
  }

    Future<void> refreshStudentList() async {
    final studentList = await databaseHelper.getStudents();
    students = studentList;
      filteredStudents = students;
    noResult = false;
    notifyListeners();
  }


  void setImage(XFile? img) {
    image = img;
    profileImagePath = img?.path;
    notifyListeners();
  }

  void clearImage() {
    image = null;
    profileImagePath = null;
    notifyListeners();
  }

}
