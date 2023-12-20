import 'package:coffee/models/drink.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee/screens/home/drink_tile.dart';

class DrinkList extends StatefulWidget {
  @override
  State<DrinkList> createState() => _DrinkListState();
}

class _DrinkListState extends State<DrinkList> {
  @override
  
  Widget build(BuildContext context) {

    final drinks = Provider.of<List<Drink>?>(context) ?? [];


  
    return ListView.builder(
      itemCount: drinks!.length,
      itemBuilder: (context, index) {
        return DrinkTile(drink: drinks[index]);
      },
    );
  }
}