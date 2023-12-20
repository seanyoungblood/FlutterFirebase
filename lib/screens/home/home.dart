
import 'package:coffee/screens/home/settings_form.dart';
import 'package:coffee/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:coffee/services/database.dart';
import 'package:provider/provider.dart';
import 'package:coffee/screens/home/drink_list.dart';
import 'package:coffee/models/drink.dart';

class Home extends StatelessWidget {
  //const Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Drink>?>.value(
      initialData: null,
      value: DatabaseService().drinks,
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text('Coffee'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              ElevatedButton.icon(
                icon: Icon(Icons.person),
                label: Text('logout'),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.settings),
                label: Text('settings'),
                onPressed: () => _showSettingsPanel(),
              ),
            ],
          ),
          body: DrinkList(), 
        ),
    );
  }
}