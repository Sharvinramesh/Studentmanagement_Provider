import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:statemanagementprovider/core/constants.dart';
import 'package:statemanagementprovider/core/widgets/custom_textformfield.dart';
import 'package:statemanagementprovider/model/model.dart';
import 'package:statemanagementprovider/presentation/home/home.dart';
import 'package:statemanagementprovider/provider/home_page_provider.dart';


class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key, required this.student});
  final Student student;

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  late TextEditingController nameController =
      TextEditingController(text: widget.student.name);
  late TextEditingController ageController =
      TextEditingController(text: widget.student.age.toString());
  late TextEditingController placeController =
      TextEditingController(text: widget.student.place);
  late TextEditingController courseController =
      TextEditingController(text: widget.student.course);
  late TextEditingController phoneController =
      TextEditingController(text: widget.student.phone.toString());
 late String pickedimage=widget.student.image;

  bool photoRequiredError = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomePageProvider>(context);
homeProvider.refreshStudentList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Update Student',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: InkWell(
                    onTap: () async {
                      final pickedFile =
                          await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        
                          pickedimage = pickedFile.path;
                        
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 69, 82, 134),
                      radius: 70,
                      backgroundImage: pickedimage.isEmpty
                          ? const NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShyZWYPEncWdEfHARCCc_DcvFFf1f1qcAgxQ&s')
                          : FileImage(File(pickedimage)),
                    ),
                  ),
                ),
                if (photoRequiredError)
                  const Text(
                    'Photo required',
                    style: TextStyle(color: Colors.red),
                  ),
                kheight20,
                CustomTextFormField(
                  controller: nameController,
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
                  controller: ageController,
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
                  controller: placeController,
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
                  controller: courseController,
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
                  controller: phoneController,
                  labelText: 'Phone',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone required';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Only numbers are allowed';
                    }
                    if (value.length != 10) {
                      return 'Enter valid phone number';
                    }
                    return null;
                  },
                ),
                kheight10,
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (pickedimage.isEmpty) {
                       
                          photoRequiredError = true;
                  
                      } else {
                        Student updatedStudent = widget.student.copyWith(
                          name: nameController.text,
                          age: int.parse(ageController.text),
                          place: placeController.text,
                          course: courseController.text,
                          image: pickedimage,
                          phone: phoneController.text,
                        );

                        homeProvider.updateStudent(updatedStudent);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Homepage()),
                        );
                      }
                    }
                  },
                  style: style,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
