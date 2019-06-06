import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/tabs/home_tab.dart';
import 'package:loja_virtual/tabs/orders_tab.dart';
import 'package:loja_virtual/tabs/places_tab.dart';
import 'package:loja_virtual/tabs/products_tab.dart';
import 'package:loja_virtual/widgets/cart_button.dart';
import 'package:loja_virtual/widgets/custom_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        return PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Scaffold(
              drawer: CustomDrawer(_pageController),
              floatingActionButton: CartButton(),
              body: HomeTab(),
            ),
            Scaffold(
              appBar: AppBar(
                title: Text("Produtos"),
                centerTitle: true,
              ),
              drawer: CustomDrawer(_pageController),
              floatingActionButton: CartButton(),
              body: ProductsTab(),
            ),
            Scaffold(
              appBar: AppBar(title: Text("Lojas"),
              centerTitle: true,),
              body: PlacesTab(),
              drawer: CustomDrawer(_pageController),
            ),
            Scaffold(
              appBar: AppBar(
                title: Text("Meus Pedidos"),
                centerTitle: true,
              ),
              body: OrdersTab(),
              drawer: CustomDrawer(_pageController),
            ),
          ],
        );
      },
    );
  }
}
