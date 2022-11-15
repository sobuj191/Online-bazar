import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_bazar/ui/home_screen.dart';
import 'package:online_bazar/ui/registration_screen.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController _emailcontroller=TextEditingController();
  TextEditingController _passlcontroller=TextEditingController();
  bool _obsecureText=true;
  signIn()async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailcontroller.text,
          password: _passlcontroller.text
      );
      var authCredential=userCredential.user;
      print(authCredential!.uid);
      if(authCredential.uid.isNotEmpty){
        Navigator.push(context, CupertinoPageRoute(builder: (_)=>Home()));
      }
      else{
        Fluttertoast.showToast(msg: 'Please check again');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
      }  else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
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
              padding:  EdgeInsets.only(left: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                     onPressed: null,
                    icon: Icon(Icons.light,color: Colors.transparent,),
                  ),
                  Text("Sign In",style: TextStyle(fontSize: 22.sp, color: Colors.blueAccent),),
                ],
              ),
            )
          ),
          Expanded(
            child: Container(
              width: ScreenUtil().screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(28.w),
                //   topRight: Radius.circular(28.w),
                // ),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Wellcome to Online Bazar",style: TextStyle(fontSize: 22.sp,color: Colors.blueAccent),),
                      Text("Please login",style: TextStyle(fontSize: 14.sp,),),
                      SizedBox(height: 15.h,),
                      Row(
                        children: [
                          Container(
                            height: 48.h,
                            width: 41.h,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(12.r)
                            ),
                            child: Center(
                              child: Icon(
                                Icons.email_outlined,
                                size: 20.w,color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w,),
                          Expanded(
                            child: TextField(
                              controller: _emailcontroller,
                              decoration: InputDecoration(
                                hintText: "sobujcmt@gmail.com",
                                hintStyle:TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.black
                                ),
                                labelText: "Email",
                                labelStyle: TextStyle(
                                fontSize: 16.sp,
                                  color: Colors.grey
                                )

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
                            width: 41.h,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(12.r)
                            ),
                            child: Center(
                              child: Icon(
                                Icons.visibility_off,
                                size: 20.w,color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w,),
                          Expanded(
                            child: TextField(
                              controller: _passlcontroller,
                              obscureText: _obsecureText,
                              decoration: InputDecoration(
                                hintText: "At least 6 character",
                                hintStyle:TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black
                                ),
                                labelText: "Password",
                                labelStyle: TextStyle(
                                fontSize: 15.sp,
                                  color: Colors.grey
                                ),
                                //suffixIcon: _obse

                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h,),
                      Center(
                        child: ElevatedButton(onPressed: (){
                          signIn();
                        }, child: Text("Sign In")),
                      ),
                      SizedBox(height: 20.h,),
                      Center(child: Text("Don't have an account?", style: TextStyle(fontSize: 20.sp),)),
                      Center(
                        child: GestureDetector(
                          child: Text("Sign Up",style: TextStyle(fontSize: 25.sp,color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                          onTap: (){

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Registration_screen()));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    )
    );
  }
}
