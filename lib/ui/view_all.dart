import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class View_all extends StatefulWidget {
  const View_all({Key? key}) : super(key: key);

  @override
  _View_allState createState() => _View_allState();
}

class _View_allState extends State<View_all> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("products").snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Something went wrong"),
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: Text("Loading"),
                          );
                        }

                        return ListView(
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                            return GestureDetector(
                              child: Card(
                                elevation: 5,
                                child: ListTile(
                                  title: Text(data['product-name']),
                                  subtitle: Text(data['product-price']),
                                  leading: Image.network(data['product-img']),
                                ),
                              ),
                              onTap: (){

                              },
                            );
                          }).toList(),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
