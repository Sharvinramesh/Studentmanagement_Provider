import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:statemanagementprovider/core/constants.dart';
import 'package:statemanagementprovider/core/widgets/custom_textformfield.dart';
import 'package:statemanagementprovider/db/db_functions.dart';
import 'package:statemanagementprovider/model/model.dart';
import 'package:statemanagementprovider/provider/add_page_provider.dart';


class AddStudents extends StatefulWidget {
  const AddStudents({
    super.key,
  });
  
  
  @override
  State<AddStudents> createState() => _AddStudentsState();

  
}


class _AddStudentsState extends State<AddStudents> {
  final nameEditingController = TextEditingController();
  final ageEditingController = TextEditingController();
  final placeEditingController = TextEditingController();
  final courseEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final pinEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final DatabaseHelper databaseHelper = DatabaseHelper();


    @override
  void initState() {
    super.initState();
    // Clear the image when the page is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AddPageProvider>(context, listen: false).clearImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Add Student',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<AddPageProvider>( 
                  builder: (context, addPageProvider, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: InkWell(
                          onTap: () async {
                            final image = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (image != null) {
                              addPageProvider.setImage(image);
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 69, 82, 134),
                            radius: 70,
                            backgroundImage:
                                addPageProvider.profileImgPath != null
                                    ? FileImage(
                                        File(addPageProvider.profileImgPath!))
                                    : null,
                            child: addPageProvider.profileImgPath != null &&
                                    addPageProvider.profileImgPath!.isEmpty
                                ? const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.white,
                                  )
                                : null,
                          )),
                    ),
                    kheight20,
                    CustomTextFormField(
                      controller: nameEditingController,
                      labelText: 'Name',
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name required';
                        }
                        if (RegExp(r'\d').hasMatch(value)) {
                          return 'Numbers are not allowed';
                        }
                        if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                          return 'Special characters are not allowed';
                        }
                        return null;
                      },
                    ),
                    kheight10,
                    CustomTextFormField(
                      controller: ageEditingController,
                      labelText: 'Age',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Age required';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Only numbers are allowed';
                        }
                        if (value.length >= 3 || value.length <= 1) {
                          return 'Enter valid age';
                        }

                        return null;
                      },
                    ),
                    kheight10,
                    CustomTextFormField(
                      controller: placeEditingController,
                      labelText: 'Place',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Place required';
                        }
                        if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                          return 'Special characters are not allowed';
                        }
                        return null;
                      },
                    ),
                    kheight10,
                    CustomTextFormField(
                      controller: pinEditingController,
                      labelText: 'pincode',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'pincode required';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Only numbers are allowed';
                        }
                        if (value.length < 6 || value.length > 6) {
                          return 'Enter valid pincode ';
                        }

                        return null;
                      },
                    ),
                    kheight10,
                    CustomTextFormField(
                      controller: courseEditingController,
                      labelText: 'Course',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Course required';
                        }
                        if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                          return 'Special characters are not allowed';
                        }
                        return null;
                      },
                    ),
                    kheight10,
                    CustomTextFormField(
                      controller: phoneEditingController,
                      labelText: 'Phone',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'phone required';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Only numbers are allowed';
                        }
                        if (value.length < 10 || value.length > 10) {
                          return 'Enter valid phone number';
                        }

                        return null;
                      },
                    ),
                    kheight10,
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (addPageProvider.profileImgPath!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select an image'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            addStudentButtonClicked();
                            Navigator.pop(context);
                          }
                        }
                      },
                      style: style,
                      child: const Text(
                        'Submit',
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ));
  }

  Future<void> addStudentButtonClicked() async {
    try {
      final name = nameEditingController.text.trim();
      final age = ageEditingController.text.trim();
      final place = placeEditingController.text.trim();
      final course = courseEditingController.text.trim();
      final phone = phoneEditingController.text.trim();
      final pincode = pinEditingController.text.trim();
      final profileImgPath =
          Provider.of<AddPageProvider>(context, listen: false).profileImgPath!;

      if (name.isEmpty ||
          age.isEmpty ||
          place.isEmpty ||
          course.isEmpty ||
          phone.isEmpty ||
          pincode.isEmpty) {
        return;
      }

      final student = Student(
        id: null,
        name: name,
        age: int.parse(age),
        place: place,
        course: course,
        image: profileImgPath,
        phone: phone,
        pincode: pincode,
      );

      await databaseHelper.insertStudent(student);

      nameEditingController.clear();
      ageEditingController.clear();
      placeEditingController.clear();
      courseEditingController.clear();
      phoneEditingController.clear();
      pinEditingController.clear();
      // ignore: use_build_context_synchronously
      Provider.of<AddPageProvider>(context, listen: false).clearImage();

      if (kDebugMode) {
        print('Student added successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding student: $e');
      }
    }
  }
}
