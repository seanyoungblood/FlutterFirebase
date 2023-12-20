import 'package:coffee/models/myuser.dart';
import 'package:coffee/services/database.dart';
import 'package:coffee/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4','5'];

  late String _currentName;
  late String _currentSugars = '0';
  late dynamic _currentStrength = 100;

  @override
  Widget build(BuildContext context) {

  final user = Provider.of<MyUser?>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user!.uid).userData,
      builder: (context, snapshot) {
        UserData? userData = snapshot.data;
        if (userData != null) {
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text('Update your settings'),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData!.name,
                  validator: (val) => val!.isEmpty ? 'Please enter name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField(
                  onChanged: (val) => setState(() => _currentSugars = val!),
                  items: sugars.map((sugar){
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars')
                    );
                  }).toList(),
                  value: _currentSugars ?? userData!.sugars,
                ),
                Slider(
                  value: (_currentStrength ?? userData.strength)!.toDouble(),
                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (val) => setState(() => _currentStrength = val.round()),
                ),
                ElevatedButton(
                  child: Text('Update'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? userData.sugars!,
                        _currentName ?? userData.name!,
                        _currentStrength ?? userData.strength
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        } else {
          return Loading(); 
        }
      }, // builder
    );
  }
}