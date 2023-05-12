import 'package:flutter/material.dart';

class AppForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController ageController;

  const AppForm({
    Key? key,
    required this.formKey,
    required this.nameController,
    required this.ageController,
  }) : super(key: key);

  @override
  _AppFormState createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
  String? _validateName(String? value) {
    if (value == null || value.isEmpty || value.length < 3) {
      return 'Name must be more than 2 characters';
    }
    return null;
  }

  String? _validateAge(String? value) {
    final regex = RegExp(r'(?<=\s|^)\d+(?=\s|$)');
    if (value == null || !regex.hasMatch(value)) {
      return 'Age must be a number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: widget.formKey,
      child: _buildFormFields(),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: widget.nameController,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(labelText: 'Name'),
          validator: _validateName,
        ),
        TextFormField(
          controller: widget.ageController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Age'),
          validator: _validateAge,
        ),
      ],
    );
  }
}
