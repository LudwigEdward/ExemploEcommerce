import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model{
  UserModel user;
  List<CartProduct> products = [];

  String coupomCode;
  int discountPercetage = 0;
  double price;

  CartModel(this.user){
    if(user.isLogged()){
      _loadCartItems();
    }

  }
  bool isLoading = false;

  static CartModel of(BuildContext context)=> ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct){
    products.add(cartProduct);
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").add(cartProduct.toMap()).then((doc){
      cartProduct.cid = doc.documentID;
    });
    notifyListeners();
  }
  void removeCartItem(CartProduct cartProduct){
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").document(cartProduct.cid).delete();

    products.remove(cartProduct);
    notifyListeners();
  }
  void decProduct(CartProduct cartProduct){
    cartProduct.quantity --;
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").document(cartProduct.cid).updateData(cartProduct.toMap());
    notifyListeners();
  }
  void incProduct(CartProduct cartProduct){
    cartProduct.quantity ++;
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").document(cartProduct.cid).updateData(cartProduct.toMap());
    notifyListeners();
  }

  void setCoupon(String couponCode,int discountPercentage){
    this.coupomCode = couponCode;
    this.discountPercetage = discountPercentage;
  }

  void updatePrices(){
    notifyListeners();
  }

  double getProductsPrice(){
    double price = 0.0;
    for(CartProduct c in products){
      if(c.productData!=null) price +=c.quantity * c.productData.price;
    }
    return price;
  }
  double getShipPrice(){
    return 9.99;
  }
  String getDiscount(){

    String a;
    price  = getProductsPrice() * discountPercetage/100;
    if(price==0.00){
      return a ="0.00";
    }else{
      return a = "- ${price.toString()}";
    }

  }
  Future<String> finishOrder() async{
    if(products.length==0) return null;
    isLoading = true;
    notifyListeners();
    getDiscount();
    double productsPrices = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = price;
   DocumentReference refOrder = await Firestore.instance.collection("orders").add({
      "clientId": user.firebaseUser.uid,
      "products":products.map((cartProduct)=>cartProduct.toMap()).toList(),
      "shipPrice":shipPrice,
      "productsPrice":productsPrices,
      "discount":discount,
      "totalPrice":productsPrices - discount +shipPrice,
      "status":1
    });
   await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("orders").document(refOrder.documentID).setData({
     "orderId":refOrder.documentID
   });

   QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").getDocuments();
   for(DocumentSnapshot doc in query.documents){
     doc.reference.delete();
   }
   products.clear();
   discountPercetage = 0;
   coupomCode = null;
   isLoading = false;
   notifyListeners();

   return refOrder.documentID;

  }

  void _loadCartItems() async {
    QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").getDocuments();

    products = query.documents.map((doc)=>CartProduct.fromDocument(doc)).toList();
    print("Productos: $products");

    notifyListeners();
  }
}