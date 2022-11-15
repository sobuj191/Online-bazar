import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_bazar/ui/products_description.dart';
import 'product_details.dart';
class AddedList extends StatefulWidget {
  const AddedList({Key? key}) : super(key: key);

  @override
  _AddedListState createState() => _AddedListState();
}

class _AddedListState extends State<AddedList> {
  late AsyncSnapshot<QuerySnapshot> snapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Added products list"),
        centerTitle: true,
      ),
    body:
    ListView.builder(
          itemCount: addedProduct.length,   //itemCount: 5,//ami caile number bole dite pari je koy ta show korve.
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              child: ListTile(
               // tileColor: Colors.deepOrange,
                leading: CircleAvatar(
                  child: Image.network(addedProduct[index]["img"],fit: BoxFit.cover,),
                ),
                title: Text(addedProduct[index]["name"],style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),),
                subtitle: Text(addedProduct[index]["price"],style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold)),
                trailing: IconButton(
                  onPressed: (){
                    setState(() {
                      addedProduct.removeAt(index);
                    });

                  },
                  icon: Icon(Icons.remove_shopping_cart,size: 25.sp,),
                ),
              ),
            );
          },
        ),
           floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
           setState(() {
             addedProduct.clear();
             Fluttertoast.showToast(msg: 'Order successful.',fontSize: 30.sp,);
           });
        },

        label: Text("Order Now",style: TextStyle(color: Colors.white, fontSize: 18.sp),
    //   ),
      ),
    //   floatingActionButton: FloatingActionButton(
    //
    //     onPressed: (){
    //       setState(() {
    //         addedProduct.clear();
    //         Fluttertoast.showToast(msg: 'Order successful.');
    //       });
    //
    //     },
    // child: Text(
    //    "Order Now",
    //      style: TextStyle(color: Colors.white, fontSize: 18.sp),
    //   ),
    //   ),

      // ElevatedButton(
      //   onPressed: (){
      //     addedProduct.clear();
      //     Fluttertoast.showToast(msg: 'Order successful.');
      //   } ,
      //   child: Text(
      //     "Order Now",
      //     style: TextStyle(color: Colors.white, fontSize: 18.sp),
      //   ),
      //   style: ElevatedButton.styleFrom(
      //     primary: Colors.blueAccent,
      //     elevation: 3,
      //   ),
      // ),

    //   body:ListView(
    // children: [
    // //snapshot.data!.docs.map((DocumentSnapshot document) {
    //   //Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    //   SingleChildScrollView(
    //     scrollDirection: Axis.vertical,
    //     child: Column(
    //         children: [
    //     for (var i=0;i<addedProduct.length;i++) Card(child: Column(
    //   children: [
    //
    //  Image.network(addedProduct[i]["img"],fit: BoxFit.cover,),
    //   Text(addedProduct[i]["name"]),
    //   ],
    //   ),
    // ),
    // ],
    //     ),),
    // ],
    //   ),
    ));
  }
}
