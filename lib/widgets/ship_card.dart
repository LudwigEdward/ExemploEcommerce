import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ShipCard extends StatefulWidget {
  @override
  _ShipCardState createState() => _ShipCardState();
}

class _ShipCardState extends State<ShipCard> {
  bool onChanged=false;
  @override
  Widget build(BuildContext context) {
    return  Card(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child:  ExpansionTile(
              title: Text(
                "Frete",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Icon(Icons.location_on),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Digite Seu CEP"
                    ),
                    initialValue: "",
                    onFieldSubmitted: (text){

                    },
                  ),
                ),
              ],
            ),
    );
  }
}