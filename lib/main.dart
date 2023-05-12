import 'package:flutter/material.dart';

import './screens/home.dart';
import './screens/create.dart';
import './screens/details.dart';
import './screens/edit.dart';
import 'models/member.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Aplikasi dimulai dengan MaterialApp
    return MaterialApp(
      // Nama aplikasi
      title: 'Member JKT 48',
      // Rute awal
      initialRoute: '/',
      // Daftar rute pilihan
      routes: {
        // Home screen
        '/': (context) => Home(refreshMemberList: () {}, key: UniqueKey()),
        // Create screen
        '/create': (context) => Create(refreshMemberList: () {}),
        // Details screen dengan data Member yang telah disiapkan
        '/details': (context) => Details(member: Member(id: 1, name: 'Feni Fetriati', age: 25)),
        // Edit screen dengan data Member yang telah disiapkan dan fungsi untuk refresh listMember
        '/edit': (context) => Edit(member: Member(id: 1, name: 'Feni Fetriati', age: 25), refreshMemberList: (){},),
      },
    );
  }
}
