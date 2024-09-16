import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statemanagementprovider/presentation/home/home.dart';
import 'package:statemanagementprovider/provider/add_page_provider.dart';
import 'package:statemanagementprovider/provider/details_page_provider.dart';
import 'package:statemanagementprovider/provider/home_page_provider.dart';


void main()async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:[
      ChangeNotifierProvider(create: (_)=>AddPageProvider()),
      ChangeNotifierProvider(create: (_)=>HomePageProvider()),
      ChangeNotifierProvider(create: (_)=>StudentDetailProvider())
    ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Homepage()
      ),
    );
  }
}
