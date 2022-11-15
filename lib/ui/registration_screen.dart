import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_bazar/ui/long_in.dart';

class Registration_screen extends StatefulWidget {
  const Registration_screen({Key? key}) : super(key: key);

  @override
  _Registration_screenState createState() => _Registration_screenState();
}

class _Registration_screenState extends State<Registration_screen> {
  TextEditingController _email=TextEditingController();
  TextEditingController _pass=TextEditingController();
  bool _obsecurText=true;
  signUp()async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text,
          password: _pass.text
      );
      var authCredential=userCredential.user;
      print(authCredential!.uid);
      if(authCredential.uid.isNotEmpty){
        Fluttertoast.showToast(msg: 'Registration successful.');
        Navigator.push(context, CupertinoPageRoute(builder: (_)=>LogIn()));
      }
      else{
        Fluttertoast.showToast(msg: 'Please check again');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 150.h,
              width: ScreenUtil().screenWidth,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(onPressed: null, icon: Icon(Icons.light,color: Colors.transparent,)),
                    Text("Sign Up",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold,color: Colors.blueAccent),)
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.only(
                  //   topRight: Radius.circular(20.r),
                  //   topLeft: Radius.circular(20.r)
                  // )
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.sp),
                  child: SingleChildScrollView(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Well come to Online Bazar",style: TextStyle(fontSize: 22.sp,color: Colors.blueAccent),),
                      Text("Please fill up",style: TextStyle(fontSize: 14.sp),),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 48.h,
                            width: 41.w,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(12.r)
                            ),
                            child: Center(child: Icon(Icons.email_outlined,color: Colors.white,)),
                          ),
                          SizedBox(width: 10.w,),
                          Expanded(
                            child: TextField(
                              controller: _email,
                              decoration: InputDecoration(
                                hintText: "mdsobujcmt@gmail.com",
                                hintStyle: TextStyle(fontSize: 14.sp,color: Colors.black),
                                labelText: "Email",
                                labelStyle: TextStyle(fontSize: 15.sp,color: Colors.grey)
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h,),
                      Row(
                        children: [
                          Container(
                            height: 48.h,
                            width: 41.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: Colors.blueAccent
                            ),
                            child: Center(child: Icon(Icons.visibility_off,color: Colors.white,)),
                          ),
                          SizedBox(width: 10.w,),
                          Expanded(
                            child: TextField(
                              controller: _pass,
                              obscureText: _obsecurText,
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: TextStyle(fontSize: 15.sp,color: Colors.grey),
                                hintText: "At least 6 character",
                                hintStyle: TextStyle(fontSize: 14.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25.h,),
                      Center(
                        child: ElevatedButton(onPressed: (

                            ){
                          signUp();
                        }, child: Text("Register")),
                      ),
                      SizedBox(height: 10.h,),
                      Wrap(
                          children: [
                          Center(child: Text("Do you have an account?")),
                            Center(
                              child: GestureDetector(
                                child: Text("Sign In",style: TextStyle(fontSize: 20.sp,color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LogIn()));
                                },
                              ),
                            )
                          ],
                      ),],
                  ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
