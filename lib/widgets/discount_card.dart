import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: Text(
          "Cupom De Desconto",
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite Seu Cupom"
              ),
              initialValue: CartModel.of(context).coupomCode ?? "",
              onFieldSubmitted: (text){
                Firestore.instance.collection("coupons").document(text).get().then(
                        (docSnap){
                  if(docSnap.data!=null){
                    CartModel.of(context).setCoupon(text, docSnap.data["percent"]);
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("Desconto de ${docSnap.data["percent"]}% Aplicado"),
                      backgroundColor: Theme.of(context).primaryColor,)
                    );
                  }else{
                    CartModel.of(context).setCoupon(null, 0);
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Cupom não existente"),
                          backgroundColor: Colors.redAccent,)
                    );
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
