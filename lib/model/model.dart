
import 'package:statemanagementprovider/db/db_functions.dart';

class Student {
  final int? id;
  final String name;
  final int age;
  final String place;
  final String course;
  final String image;
  final String phone;
  final String pincode;

  Student({
    this.id,
    required this.name,
    required this.age,
    required this.place,
    required this.course,
    required this.image,
    required this.phone,
    required this.pincode,
  });

Map<String, dynamic> toMap() {
  return {
    DatabaseHelper.columnId: id,
    DatabaseHelper.columnName: name,
    DatabaseHelper.columnAge: age,
    DatabaseHelper.columnPlace: place,
    DatabaseHelper.columnCourse: course,
    DatabaseHelper.columnImage: image,
    DatabaseHelper.columnPhone: phone,
    DatabaseHelper.columnPincode: pincode,
  };
}


  Student copyWith({
    int? id,
    String? name,
    int? age,
    String? place,
    String? course,
    String? image,
    String? phone,
    String? pincode,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      place: place ?? this.place,
      course: course ?? this.course,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      pincode: pincode ?? this.pincode,
    );
  }
}
