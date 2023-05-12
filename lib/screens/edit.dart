import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api/api.dart';
import '../models/member.dart';
import '../widgets/form.dart';

class Edit extends StatefulWidget {
  final Member member;
  final Function refreshMemberList;

  const Edit({super.key, required this.member, required this.refreshMemberList});

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  // This is  for form validations
  final formKey = GlobalKey<FormState>();

  // This is for text onChange
  late TextEditingController nameController;
  late TextEditingController ageController;

  // Http post request
  Future editMember() async {
    return await http.post(
      Uri.parse('${Api.URL_PREFIX}/update.php'),
      body: {
        "id": widget.member.id.toString(),
        "name": nameController.text,
        "age": ageController.text
      },
    );
  }

  void _onConfirm(context) async {
    await editMember();
    Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    nameController = TextEditingController(text: widget.member.name);
    ageController = TextEditingController(text: widget.member.age.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.blue,
          ),
          onPressed: () {
            _onConfirm(context);
          },
          child: const Text('CONFIRM'),
        ),
      ),
      
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: AppForm(
              formKey: formKey,
              nameController: nameController,
              ageController: ageController,
            ),
          ),
        ),
      ),
    );
  }
}