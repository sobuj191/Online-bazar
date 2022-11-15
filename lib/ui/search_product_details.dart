import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_bazar/ui/added_product_list.dart';
import 'package:online_bazar/ui/products_description.dart';

class Search_product_details extends StatefulWidget {
  String product_name, product_img,product_price,product_description;

  Search_product_details(this.product_name, this.product_img,
      this.product_price, this.product_description);

  @override
  _Search_product_detailsState createState() => _Search_product_detailsState();
}

class _Search_product_detailsState extends State<Search_product_details> {

  addToCart(){
    addedProduct.add(
        { 'name': widget.product_name,
          'img': widget.product_img,
          'price': widget.product_price,
        }
    );
  }
  // Future addToCart() async {
  //   final FirebaseAuth _auth = FirebaseAuth.instance;
  //   var currentUser = _auth.currentUser;
  //   CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-cart-items");
  //   return _collectionRef.doc(currentUser!.email).collection("items").doc().set({
  //     "name": widget._product["product-name"],
  //     "price": widget._product["product-price"],
  //     "images": widget._product["product-img"],
  //   }).then((value) => print("Added to cart"));
  // }

  // Future addToFavourite() async {
  //   final FirebaseAuth _auth = FirebaseAuth.instance;
  //   var currentUser = _auth.currentUser;
  //   CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-favourite-items");
  //   return _collectionRef.doc(currentUser!.email).collection("items").doc().set({
  //     "name": widget._product["product-name"],
  //     "price": widget._product["product-price"],
  //     "images": widget._product["product-img"],
  //   }).then((value) => print("Added to favourite"));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
        ),
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users-favourite-items").doc(FirebaseAuth.instance.currentUser!.email).collection("items").where("name", isEqualTo: widget.product_name).snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Text("");
              }
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                // child: CircleAvatar(
                //   backgroundColor: Colors.blueAccent,
                //   child: IconButton(
                //     onPressed: (){
                //       Navigator.push(context, CupertinoPageRoute(builder: (_)=>AddedList()));
                //     },// snapshot.data.docs.length == 0 ? addToFavourite() : print("Already Added"),
                //     icon: snapshot.data.docs.length == 0
                //         ? Icon(
                //       Icons.shopping_cart,
                //       color: Colors.white,
                //     )
                //         : Icon(
                //       Icons.favorite,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 3, right: 3),
                      child: Container(
                          color: Colors.teal,
                          child: Image.network(
                            widget.product_img,fit: BoxFit.cover,
                          ))
                  ),
                  // AspectRatio(
                  //   aspectRatio: 3.5,
                  //   child: CarouselSlider(
                  //       items: widget._product['product-img']
                  //           .map<Widget>((item) => Padding(
                  //         padding: const EdgeInsets.only(left: 3, right: 3),
                  //         child: Container(
                  //           decoration: BoxDecoration(image: DecorationImage(image: NetworkImage( widget._product['product-img']), fit: BoxFit.fitWidth)),
                  //         ),
                  //       ))
                  //           .toList(),
                  //       options: CarouselOptions(
                  //           autoPlay: false,
                  //           enlargeCenterPage: true,
                  //           viewportFraction: 0.8,
                  //           enlargeStrategy: CenterPageEnlargeStrategy.height,
                  //           onPageChanged: (val, carouselPageChangedReason) {
                  //             setState(() {});
                  //           })),
                  // ),
                  Text(
                    widget.product_name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    " ${widget.product_price.toString()}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,),
                  ),
                  SizedBox(height: 10.sp,),
                  Text(widget.product_description,style: TextStyle(fontSize: 16.sp),),
                  SizedBox(height: 20.sp,),
                  //Divider(),
                  SizedBox(
                    width: 1.sw,
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed: () => addToCart(),
                      child: Text(
                        "Add to cart",
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        elevation: 3,
                      ),
                    ),

                  ),
                  SizedBox(height: 10.sp,),
                ],
              ),
            ),
          )),
    );
  }
}