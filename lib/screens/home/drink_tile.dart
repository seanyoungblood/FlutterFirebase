import 'package:flutter/material.dart';
import 'package:coffee/models/drink.dart';

class DrinkTile extends StatelessWidget {

  final Drink? drink;

  DrinkTile({this.drink});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[drink!.strength!],

          ),
          title: Text(drink!.name!),
          subtitle: Text('Takes ${drink!.sugars!} sugar(s)'),
        ),
      ),
    );
  }
}