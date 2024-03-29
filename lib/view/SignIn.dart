  
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'mainp.dart';
import 'Regist.dart';


// class MyLoginPage extends StatefulWidget {
//   MyLoginPage({Key key}) : super(key: key);
 
//   @override
//   _MyLoginPageState createState() => _MyLoginPageState();
// }
class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
 
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage>{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool _validate = false;


@override
 void initState() {
    super.initState();
    checkAuth(context);
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.purple,
      body: SafeArea(
        child: Container(
        
          padding: EdgeInsets.only(left: 16,right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 100,),
                  Text("Welcome",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w500, color: Colors.white)),
                  
                  
                  
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: 450.0,
                    color:  Color(0xFFFFFFFf),
                    //height:100.0,
                    child: TextField(
                      controller: emailController,

                      decoration: InputDecoration(
                        
                        labelText: "Email",
                        labelStyle: TextStyle(fontSize: 15,color: Colors.grey),
                        errorText:_validate ? '' : null ,

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.red,
                            )
                        ),
                      ),
                    ),
                  ),
          
                  SizedBox(height: 10,),
                  Container(
                    color:  Color(0xFFFFFFFf),
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(fontSize: 15,color: Colors.grey),
                        errorText:_validate ? 'กรุณากรอกข้อมูล' : null ,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.red,
                            )
                        ),
                      ),
                    ),
                  ),
              
                  SizedBox(height: 30,),
                  Container(
                    color: Colors.black,
                    height: 50,
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: (){
                     
                           signIn();
                        
                      },
                      padding: EdgeInsets.all(0),
                      child: Ink(
                      
                        child: Container(
                          alignment: Alignment.center,
                          constraints: BoxConstraints(maxWidth: double.infinity,minHeight: 50),
                          child: Text("เข้าสู่ระบบ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  SizedBox(height: 16,),
                  
                  SizedBox(height: 30,),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return SignUp();
                        }));
                      },
                      child: Text("สมัครสมาชิก",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  signIn(){
    _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()
    ).then((user) {
      print("signed in ${user.email}");
      checkAuth(context);  // add here
    }).catchError((error) {
      print(error.message);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(error.message, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ));
    });
  }

    Future checkAuth(BuildContext context) async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      print("Already singed-in with");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage(user)));
    }
  }
 }




