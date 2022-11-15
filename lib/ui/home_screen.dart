import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_bazar/ui/added_product_list.dart';

import 'package:online_bazar/ui/product_details.dart';
import 'package:online_bazar/ui/products_description.dart';
import 'package:online_bazar/ui/search_screen.dart';
import 'package:online_bazar/ui/view_all.dart';
// import 'appColors.dart';
// import 'product_details_screen.dart';
// import 'search_screen.dart';

// import 'package:flutter_ecommerce/const/AppColors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _carouselImages = [];


  var _dotPosition = 0;

  var _firestoreInstance = FirebaseFirestore.instance;

  fetchCarouselImages() async {
    QuerySnapshot qn = await _firestoreInstance.collection("carousel-slider").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["img-path"],
        );
        // print(qn.docs[i]["img-path"]);
      }
    });

    return qn.docs;
  }

  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        products.add({
          "product-name": qn.docs[i]["product-name"],
          "product-description": qn.docs[i]["product-description"],
          "product-price": qn.docs[i]["product-price"],
          "product-img": qn.docs[i]["product-img"],
        });
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    //load hoyar sathe sathe jeano kaj kore.
    fetchCarouselImages();
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 10.sp,),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 50.h,
                        width: 260.w,
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0)), borderSide: BorderSide(color: Colors.blue)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0)), borderSide: BorderSide(color: Colors.grey)),
                            hintText: "Search products here",
                            hintStyle: TextStyle(fontSize: 15.sp),
                          ),
                          onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (_) => SearchScreen())),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (_)=>AddedList()));
                        },// snapshot.data.docs.length == 0 ? addToFavourite() : print("Already Added"),
                        icon: //snapshot.data.docs.length == 0
                             Icon(

                          Icons.shopping_cart,
                          color: Colors.blueAccent,size: 40.sp,
                        )
                        //     : Icon(
                        //   Icons.favorite,
                        //   color: Colors.white,
                        // ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                AspectRatio(
                  aspectRatio: 3.5,
                  child: CarouselSlider(
                      items: _carouselImages
                          .map((item) => Padding(
                        padding: const EdgeInsets.only(left: 3, right: 3),
                        child: Container(
                          decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(item), fit: BoxFit.fitWidth)),
                        ),
                      ))
                          .toList(),
                      options: CarouselOptions(
                          autoPlay: false,
                          enlargeCenterPage: true,
                          viewportFraction: 0.8,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          onPageChanged: (val, carouselPageChangedReason) {
                            setState(() {
                              _dotPosition = val;
                            });
                          })),
                ),
                SizedBox(
                  height: 10.h,
                ),
                DotsIndicator(
                  dotsCount: _carouselImages.length == 0 ? 1 : _carouselImages.length,
                  position: _dotPosition.toDouble(),
                  decorator: DotsDecorator(
                    activeColor: Colors.blueAccent,
                    color: Colors.blueAccent.withOpacity(0.5),
                    spacing: EdgeInsets.all(2),
                    activeSize: Size(8, 8), //height:8,width:8
                        size: Size(6, 6),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Text(
                      'Top Products',
                      style: TextStyle(color: Colors.blue, fontSize: 30),
                    ),
                    Spacer(),
                    TextButton(
                      // style: TextButton.styleFrom(
                      //   primary: Colors.deepOrange,
                      //   elevation: 10,
                      //   shadowColor: Colors.white,
                      // ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => View_all()));
                      },

                      child: Text('View All', style: TextStyle(fontSize: 30,color: Colors.blue)),

                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Expanded(
                  child: GridView.builder(
                       scrollDirection: Axis.vertical,
                       itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: 2,
                           childAspectRatio: 1,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8
                            ),
                       itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetails(products[index]))),
                          child: Card(
                            color: Colors.blueAccent,
                            elevation: 3,
                            child: Column(
                              children: [
                                AspectRatio(
                                    aspectRatio: 1.5,
                                    child: Container(
                                        color: Colors.blueAccent,
                                        child: Image.network(
                                          products[index]["product-img"],fit: BoxFit.cover,
                                        ))),
                                SizedBox(height:15.sp),
                                Text("${products[index]["product-name"]}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                Text("${products[index]["product-price"].toString()}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          )),
    );
  }
}