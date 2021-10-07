import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newsapp/controller/main_controller.dart';
import 'package:newsapp/screens/homepage.dart';
import 'package:newsapp/screens/login-signup/signup.dart';

class Login extends StatelessWidget {
    static const String idscreen = "Login";
    FirebaseAuth auth = FirebaseAuth.instance;

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    Logics control = Logics();

    void login(BuildContext context)async{
     showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
       return Center(child: Container(child: CircularProgressIndicator(),),);
     });
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password:passwordController.text);
       Navigator.push(context,  MaterialPageRoute(builder: (context) => Api()),);
              Fluttertoast.showToast(msg: "Logged in");
        // control.saveSwitchState(true);

        // if(userCredential != null){
        //   FirebaseFirestore firestore = FirebaseFirestore.instance;
        //   FirebaseFirestore.instance.collection('userdata').doc(userCredential.user!.uid).get().then(DataSnapshot snap){


        //   });
        // }
        
      } on FirebaseAuthException catch(e){
        if (e.code == 'user-not-found') {
          Navigator.pop(context);
    Fluttertoast.showToast(msg: 'No user found for that email.');
  } else if (e.code == 'wrong-password') {
    Navigator.pop(context);
    Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
  } 
  
      } 
      


    }

    
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        title: Center(child: Title(color: Colors.blueAccent, child: Text("Login")),),),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 35,),
      
           
           SizedBox(height: 5,),
           Text(
             "Login",
             style: TextStyle(
               color: Colors.blueAccent,
               fontWeight: FontWeight.bold,
               fontSize: 24
             ),
           ),
      
           SizedBox(height: 3,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
             child: TextFormField(
               controller: emailController,
               keyboardType: TextInputType.emailAddress,
               decoration: InputDecoration(
                 labelText: "Enter Email Address",
                 labelStyle: TextStyle(fontSize: 14,
                 fontFamily: "Regular")
                 
               ),
              
             ),
           ),
           SizedBox(height: 5,),
      
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
             child: TextFormField(
               controller: passwordController,
               obscureText: true,
               decoration: InputDecoration(
                 labelText: "Enter Password",
                 labelStyle: TextStyle(fontSize: 14,
                 fontFamily: "Regular")
                 
               ),
              
             ),
           ),
      
           // ignore: deprecated_member_use
           Container(
             height: 50,
             width: 200,
             
             child: RaisedButton(
               color: Colors.white, 
               textColor: Colors.blueAccent,
      
               onPressed: (){
                 login(context);
               }, child: Text("Login", style: TextStyle(
               fontSize: 15),),shape: new RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(14)
               ),)
               ),
               SizedBox(height: 15,),
      
               InkWell(
                 onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Signup()));
                 },
                child: Text(
                  "Not have an account? Register.",
                  style: TextStyle(fontSize: 13.5,
                  fontWeight:FontWeight.bold,
                  fontFamily: "Regular"),
                ),
               )
             
      
      
          ],
        ),
      ),
      
    );
  }
}