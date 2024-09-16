import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statemanagementprovider/model/model.dart';
import 'package:statemanagementprovider/presentation/home/home.dart';
import 'package:statemanagementprovider/provider/details_page_provider.dart';


class DeleteDialog {
  static Future<dynamic> deleteDialog(BuildContext context, Student student) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete'),
          titleTextStyle: const TextStyle(
            color: Color.fromARGB(255, 238, 43, 43),
            fontSize: 20,
            fontFamily: 'poppins',
            fontWeight: FontWeight.bold,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Provider.of<StudentDetailProvider>(context, listen: false).deleteStudent(student.id!);
                Navigator.of(context).pop(); 
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Homepage()),
                );
              },
              child: const Text(
                'YES',
                style: TextStyle(fontFamily: 'poppins', fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'NO',
                style: TextStyle(fontFamily: 'poppins', fontSize: 15),
              ),
            ),
          ],
        );
      },
    );
  }
}
