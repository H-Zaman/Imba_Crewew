import 'package:flutter/material.dart';
import 'package:brewcrew/models/brew.dart';

class BrewTile extends StatelessWidget {

  final Brew brew;

  BrewTile({this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Opacity(
        opacity: 0.65,
        child: Card(
          margin: EdgeInsets.all(4.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.brown[brew.strength],
              //TODO icon needs to changed color not showing icon middle needs to be empty
              //backgroundImage: AssetImage('assets/coffee-icon.jpg'),
            ),
            title: Text(brew.name),
            subtitle: Text('Preferrs ${brew.sugar} Sugar(s)'),
          ),
        ),
      ),
    );
  }
}
