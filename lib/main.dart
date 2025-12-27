import 'package:cred_assignment_by_shubham_puhal/data/repository/asset_bills_section_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cred_assignment_by_shubham_puhal/presentation/screens/home_screen.dart';
import 'package:cred_assignment_by_shubham_puhal/provider/bill_flipper_sync_provider.dart';
import 'package:cred_assignment_by_shubham_puhal/provider/bill_section_provider.dart';
import 'package:cred_assignment_by_shubham_puhal/provider/controller_provider.dart';

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
          create: (_) => BillsSectionProvider(
            repository: AssetBillsSectionRepositoryImpl(),
          )..fetchBills(),
        ),
        ChangeNotifierProvider(create: (_) => ControllerProvider()),
        ChangeNotifierProvider(create: (_) => FlipperSyncProvider()),
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
