import 'package:flutter/material.dart';

enum Gender { male, female, other }

class GenderSelection extends StatefulWidget {
  final Function(Gender) onGenderSelected;
  final Gender defaultGender;

  const GenderSelection({
    super.key,
    required this.onGenderSelected,
    required this.defaultGender,
  });

  @override
  _GenderSelectionState createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  late Gender _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.defaultGender;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Gender',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<Gender>(
          value: _selectedGender,
          onChanged: (value) {
            setState(() {
              _selectedGender = value!;
            });
            widget.onGenderSelected(_selectedGender);
          },
          items: const [
            DropdownMenuItem(
              value: Gender.male,
              child: Text('Male'),
            ),
            DropdownMenuItem(
              value: Gender.female,
              child: Text('Female'),
            ),
            DropdownMenuItem(
              value: Gender.other,
              child: Text('Other'),
            ),
          ],
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ],
    );
  }
}
