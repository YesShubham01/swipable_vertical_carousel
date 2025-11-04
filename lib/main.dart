import 'package:cred_assignment_by_shubham_puhal/presentation/screens/home_screen.dart';
import 'package:cred_assignment_by_shubham_puhal/provider/bill_section_provider.dart';
import 'package:cred_assignment_by_shubham_puhal/provider/controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BillsSectionProvider()..fetchBills(),
        ),
        ChangeNotifierProvider(create: (_) => ControllerProvider()),
      ],
      child: MaterialApp(
        title: 'Swipable Vertical Carousal',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
