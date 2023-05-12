import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api/api.dart';
import '../widgets/form.dart';

class Create extends StatefulWidget {
  final Function refreshMemberList;

  const Create({Key? key, required this.refreshMemberList}) : super(key: key);

  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  Future _createMember() async {
    return await http.post(
      Uri.parse('${Api.URL_PREFIX}/create.php'),
      body: {
        'name': nameController.text,
        'age': ageController.text,
      },
    );
  }

  void _onConfirm(BuildContext context) async {
    await _createMember();
    Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              _onConfirm(context);
            }
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
