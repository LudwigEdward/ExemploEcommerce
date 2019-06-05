import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  final String orderId;
  OrderScreen(this.orderId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedido Realizado"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check,
              color: Theme.of(context).primaryColor,
              size: 80.0,
            ),
            Text("Pedido Realizado Com Sucesso!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
            Text("Código Do Pedido: $orderId",style: TextStyle(fontSize: 16.0),)
          ],
        ),
      ),
    );
  }
}
