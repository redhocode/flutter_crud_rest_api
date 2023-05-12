import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../api/api.dart';
import '../models/member.dart';
import './details.dart';
import './create.dart';

class Home extends StatefulWidget {
  final Function refreshMemberList;

  Home({Key? key, required this.refreshMemberList}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late Future<List<Member>> members;
  final memberListKey = GlobalKey<HomeState>();
  @override
  void initState() {
    super.initState();
    members = getMemberList();
  }

  Future<List<Member>> getMemberList() async {
    final response = await http.get(Uri.parse("${Api.URL_PREFIX}/list.php"));
    print(response.body); // Menampilkan respons dari API ke konsol

    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Member> members = items.map<Member>((json) {
      return Member.fromJson(json);
    }).toList();

    return members;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: memberListKey,
      appBar: AppBar(
        title: Text('Members List JKT48'),
      ),
      body: Center(
        child: FutureBuilder<List<Member>>(
          future: members,
          builder: (BuildContext context, AsyncSnapshot<List<Member>> snapshot) {
            // Tampilkan loading spinner jika data belum tersedia
            if (!snapshot.hasData) return CircularProgressIndicator();
            // Render daftar member
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.person),
                    trailing: Icon(Icons.view_list),
                    title: Text(
                      data.name,
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Details(member: data)),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Create(refreshMemberList: widget.refreshMemberList)),
          );
        },
      ),
    );
  }
}
