import 'package:flutter/material.dart';
import 'package:loja_virtual/Screens/login_screen.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;
  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            const Color.fromARGB(255, 129, 255, 225),
            const Color.fromARGB(255, 244, 244, 244)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text(
                        "Flutter's\nClothing",
                        style: TextStyle(
                            fontSize: 34.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      child: ScopedModelDescendant<UserModel>(builder: (context,child,model){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Olá, ${!model.isLogged()? "":model.userData["name"]}",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                if(!model.isLogged())
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
                                else model.signOut();
                              },
                              child: Text(!model.isLogged()?
                                "Entre Ou Cadastre-se ->":"Sair",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        );
                      },)
                    ),
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home,"Início",pageController,0),
              DrawerTile(Icons.list,"Produtos",pageController,1),
              DrawerTile(Icons.location_on ,"Lojas",pageController,2),
              DrawerTile(Icons.playlist_add_check,"Meus Pedidos",pageController,3),
            ],
          )
        ],
      ),
    );
  }
}
