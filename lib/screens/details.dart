import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api/api.dart';
import '../models/member.dart';
import './edit.dart';

class Details extends StatefulWidget {
  final Member member;

  const Details({super.key, required this.member});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  void deleteMember(context) async {
   await http.post(
      Uri.parse('${Api.URL_PREFIX}/delete.php'),
      body: {
        'id': widget.member.id.toString(),
      },
    );
    // Navigator.pop(context);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

   void confirmDelete(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Are you sure you want to delete this?'),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.red,
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: const Icon(Icons.cancel),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue,
              ),
              onPressed: () => deleteMember(context),
              child: const Icon(Icons.check_circle),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => confirmDelete(context),
          ),
        ],
      ),
      body: Container(
        height: 270.0,
        padding: const EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Name : ${widget.member.name}",
              style: const TextStyle(fontSize: 20),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
            ),
            Text(
              "Age : ${widget.member.age}",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => Edit(member: widget.member, refreshMemberList: (){},),
          ),
        ),
      ),
    );
  }
}
