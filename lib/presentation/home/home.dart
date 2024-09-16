import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statemanagementprovider/core/colors.dart';
import 'package:statemanagementprovider/core/constants.dart';
import 'package:statemanagementprovider/core/widgets/showdailouge.dart';
import 'package:statemanagementprovider/presentation/addpage/add_student.dart';
import 'package:statemanagementprovider/presentation/search/search_page.dart';
import 'package:statemanagementprovider/provider/home_page_provider.dart';


class Homepage extends StatelessWidget {
  const Homepage({super.key});

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Exit'),
            content: const Text('Do you want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => exit(0),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final homeprovider = Provider.of<HomePageProvider>(context, listen: false);
    homeprovider.refreshStudentList();
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('Student app'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.search),
              ),
            ),
          ],
        ),
        body: Consumer<HomePageProvider>(
          builder: (context, homeprovider, child) {
            return ListView.separated(
              separatorBuilder: (context, index) => kheight10,
              itemCount: homeprovider.students.length,
              itemBuilder: (context, index) {
                var student = homeprovider.students[index];
                return InkWell(
                    onTap: () {
                      StudentDialog.showStudentDialog(context, student);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: backgroundcolor,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(File(student.image)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 36),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      student.name,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        color: kwhite,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Course: ${student.course}',
                                      style: const TextStyle(
                                        color: kwhite,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Age: ${student.age}',
                                      style: const TextStyle(
                                        color: kwhite,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ));
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 152, 169, 238),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddStudents(),
              ),
            ).then(
              (value) => homeprovider.refreshStudentList(),
            );
          },
          child: const Icon(Icons.add, color: kwhite),
        ),
      ),
    );
  }
}
