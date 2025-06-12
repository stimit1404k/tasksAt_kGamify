import 'package:flutter/material.dart';

import '../models/User.dart';

class UserInputForm extends StatefulWidget {
  @override
  _UserInputFormState createState() => _UserInputFormState();
}

class _UserInputFormState extends State<UserInputForm> {
  final _formKey = GlobalKey<FormState>();
  double _progress = 0.0;

  // User model data variables
  int? _userId;
  String? _name;
  String? _email;
  int? _phone;
  String? _userQualification;
  String? _college;
  List<String> _userInterests = [];

  // Dummy data for interests
  final List<String> interests = ['Music', 'Sports', 'Reading', 'Coding'];

  // Method to calculate the progress
  void _calculateProgress() {
    double filledFields = 0.0;
    int totalFields = 6; // There are 6 fields to fill

    // Count how many fields are filled
    if (_name != null && _name!.isNotEmpty) filledFields++;
    if (_email != null && _email!.isNotEmpty) filledFields++;
    if (_phone != null) filledFields++;
    if (_userQualification != null && _userQualification!.isNotEmpty) filledFields++;
    if (_college != null && _college!.isNotEmpty) filledFields++;
    if (_userInterests.isNotEmpty) filledFields++;

    // Calculate progress as a percentage
    setState(() {
      _progress = filledFields / totalFields;
    });
  }

  // Method to handle form submission
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Create the User model instance
      User newUser = User(
        userId: 1,
        name: _name,
        email: _email,
        phone: _phone,
        userQualification: _userQualification,
        college: _college,
        userInterests: _userInterests,
      );

      // Optionally, print the created User model to console
      print(newUser.toJson());

      // You can handle further steps here like sending data to a backend
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Input Form")),
      body: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom,right: 16,left: 16),
        child: Column(
          children: [
            SizedBox(height: 10),
            // Form
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // User Name
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _name = value;
                        _calculateProgress(); // Update progress as the user types
                      });
                    },
                  ),

                  // User Email
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                        _calculateProgress();
                      });
                    },
                  ),

                  // User Phone
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Phone'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _phone = int.tryParse(value ?? '');
                        _calculateProgress();
                      },);
                    },
                  ),

                  // User Qualification
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Qualification'),
                    onChanged: (value) {
                      setState(() {
                        _userQualification = value;
                        _calculateProgress();
                      });
                    },
                  ),

                  // College Name
                  TextFormField(
                    decoration: InputDecoration(labelText: 'College'),
                    onChanged: (value) {
                      setState(() {
                        _college = value;
                        _calculateProgress();
                      });
                    },
                  ),

                  // User Interests (Multiple choices)
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Select Interests'),
                    items: interests.map((interest) {
                      return DropdownMenuItem<String>(
                        value: interest,
                        child: Text(interest),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        if (_userInterests.contains(value)) {
                          _userInterests.remove(value);
                        } else {
                          _userInterests.add(value!);
                        }
                        _calculateProgress();
                      });
                    },
                    value: null, // You can set a default value here
                    hint: Text("Select Interest"),
                    isExpanded: true,
                  ),
                ],
              ),
            ),
            Spacer(),
            Stack(
              children: [
                LinearProgressIndicator(
                  value: _progress,
                  backgroundColor: Colors.grey[300],
                  color: Colors.purple,
                  minHeight: kToolbarHeight,
                  borderRadius: BorderRadius.circular(50),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.sizeOf(context).width,kToolbarHeight),
                    backgroundColor: Colors.transparent
                  ),
                  onPressed: _progress == 1 ? _submitForm : null,
                  child: Text('Submit',style: TextStyle(
                    color: Colors.white
                  ),),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}