import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/Screens/cart_screen.dart';
import 'package:loja_virtual/Screens/login_screen.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;
  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;
  _ProductScreenState(this.product);
  String size;

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: color,
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  "Tamanho",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.5),
                    children: product.sizes.map((s) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            size = s;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              border: Border.all(
                                  color: s == size ? color : Colors.grey[800],
                                  width: 3.0)),
                          width: 50,
                          alignment: Alignment.center,
                          child: Text(
                            s,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 13.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: size != null ? () {
                      if(UserModel.of(context).isLogged()){

                        CartProduct cartProduct = CartProduct();
                        cartProduct.size = size;
                        cartProduct.quantity = 1;
                        cartProduct.pid = product.id;
                        cartProduct.category = product.category;

                        CartModel.of(context).addCartItem(cartProduct);

                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CartScreen()));
                      }else{
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
                      }
                    } : null,
                    child: Text(
                      UserModel.of(context).isLogged()?"Adicionar ao Carrinho":"Entre Para Comprar",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    color: color,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0,),
                Text(
                  "Decrição",
                  style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 18.0),
                ),
                SizedBox(height: 5.0,),
                Text(
                  product.description,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
