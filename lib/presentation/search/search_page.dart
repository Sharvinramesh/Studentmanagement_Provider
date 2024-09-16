import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statemanagementprovider/core/colors.dart';
import 'package:statemanagementprovider/core/constants.dart';
import 'package:statemanagementprovider/core/widgets/showdailouge.dart';
import 'package:statemanagementprovider/model/model.dart';
import 'package:statemanagementprovider/provider/home_page_provider.dart';


class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomePageProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Search Students'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoSearchTextField(
              onChanged: (value) {
                homeProvider.filterStudents(value);
              },
            ),
          ),
          Expanded(
            child: Selector<HomePageProvider, bool>(
              selector: (context, provider) => provider.noResult,
              builder: (context, noResult, child) {
                if (noResult) {
                  return const Center(
                    child: Text(
                      'No items found',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  );
                }
                return Selector<HomePageProvider, List<Student>>(
                  selector: (context, provider) => provider.filteredStudents,
                  builder: (context, filteredStudents, child) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => kheight10,
                      itemCount: filteredStudents.length,
                      itemBuilder: (context, index) {
                        var student = filteredStudents[index];
                        return GestureDetector(
                          onTap: () {
                            StudentDialog.showStudentDialog(context, student);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
