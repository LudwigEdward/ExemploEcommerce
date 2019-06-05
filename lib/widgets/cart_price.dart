import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {
  final VoidCallback buy;

  CartPrice(this.buy);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child:
            ScopedModelDescendant<CartModel>(builder: (context, child, model) {
              double price = model.getProductsPrice();
              String discount = model.getDiscount();
              double ship = model.getShipPrice();


          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Resumo Do Pedido",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 12.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Subtotal"),
                  Text("R\$ ${price.toStringAsFixed(2)}")
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Desconto"),
                  Text("R\$ ${discount}")
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Entrega"),
                  Text("R\$ ${ship.toStringAsFixed(2)}")
                ],
              ),
              Divider(),
              SizedBox(height: 12.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Total",style: TextStyle(fontWeight: FontWeight.w500),),
                  Text("R\$ ${(price+ship - CartModel.of(context).price).toStringAsFixed(2)}",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 16.0),)
                ],
              ),
              SizedBox(height: 12.0,),
              RaisedButton(
                child: Text("Finalizar Pedido"),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: buy,
              )
            ],
          );
        }),
      ),
    );
  }
}
