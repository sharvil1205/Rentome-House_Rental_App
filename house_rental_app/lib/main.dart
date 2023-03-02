import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:house_rental_app/TenantHomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login/Signup Form',
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    
    );
  }
}


class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future login() async {
  
    
    if(emailController.text!="" && passwordController.text!="")
    {
      try{
        String uri = 'http://localhost:3000/login';

        var res = await http.post(Uri.parse(uri), body: {
          "email": emailController.text,
          "password": passwordController.text
        });

        var response = jsonDecode(res.body);
        if(response['success'] == true){
          print("logged in");
          print(response['message']);
          Navigator.push(context, MaterialPageRoute(builder: (context) => TenantHomePage()));

        }
        else if(response['success'] == false){
          print(response['message']);
        }
      }
      catch(e){
        print(e);
      }
    }
    else{
      print("Please fill all fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Container(
               child: 
               const Text(
                'Login',
                style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                fontFamily: "TiltNeon-Regular",
                height: 5)),   
            ),

            Container(
              height: 34,
              width: 400,
              margin: EdgeInsets.all(16.0),
              
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(1),
                    blurRadius: 8.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),

            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
                prefixIcon: Icon(Icons.person_2, color: Colors.grey),
              ),
            ),
          ),
          
          Center(
            child: Container(
            height: 34,
            width: 400,
            margin: EdgeInsets.all(16.0),
            
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(1),
                  blurRadius: 8.0,
                  offset: Offset(0, 4),
                ),
              ],
            ),

            child: TextField(
              controller: passwordController,
              decoration: InputDecoration(
              hintText: 'Password',
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
              prefixIcon: Icon(Icons.lock, color: Colors.grey),
              ),
              obscureText: true,
            ),
          ),
          ),
          

          SizedBox(height: 30),
                     
          SizedBox(
            height: 30,
            width: 400,
            child: ElevatedButton(
            onPressed: login,
            child: const Text(
              'Login',
              style: TextStyle(
                fontWeight: FontWeight.bold),
            ),
          
            style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.purple.shade600),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),),
            ),
            ),
            ),
            ),
            
            SizedBox(height: 20),
            
            Row(    
              children: [
                SizedBox(width:130),
                Text("Don't have an account? "),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
              
                  child: const Text(
                    'Sign up',
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                  ),
              ],
            ),
          ],
        ),   
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future signUp() async {
  
    if(nameController.text!="" && emailController.text!="" && passwordController.text!="")
    {
      try{
        String uri = 'http://localhost:3000/signup';

        var res = await http.post(Uri.parse(uri), body: {
          "name": nameController.text,
          "email": emailController.text,
          "password": passwordController.text
        });

        var response = jsonDecode(res.body);
        if(response['success'] == true){
          print("record inserted");
          Navigator.push(context, MaterialPageRoute(builder: (context) => TenantHomePage()));

        }
        else if(response['success'] == false){
          print(response['message']);
        }
        else 
        {
          print('Some issue');
        }
      }
      catch(e){
        print(e);
      }
    }
    else{
      print("Please fill all fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,          
          children: <Widget>[

            Container(
               child: 
                const Text('Sign Up',
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  fontFamily: "TiltNeon-Regular",
                  height: 5)),
            ),

            Container(
              height: 34,
              width: 400,
              margin: EdgeInsets.all(16.0),
              
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
            
              boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(1),
                blurRadius: 8.0,
                offset: Offset(0, 4),
              ),
              ],
              ),

              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                hintText: 'Name',
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
                prefixIcon: Icon(Icons.person_2, color: Colors.grey),
                ),
              ),
            ),

            Container(
              height: 34,
              width: 400,
              margin: EdgeInsets.all(16.0),
            
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(1),
                  blurRadius: 8.0,
                  offset: Offset(0, 4),
                ),
                ],
              ),

              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
                prefixIcon: Icon(Icons.person_2, color: Colors.grey),
                ),
              ),
          ),


          Center(
            child: Container(
              height: 34,
              width: 400,
              margin: EdgeInsets.all(16.0),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(1),
                    blurRadius: 8.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),

                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                  hintText: 'Password',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
                  prefixIcon: Icon(Icons.lock, color: Colors.grey),
                  ),
                  obscureText: true,
                ),
            ),
          ),

          SizedBox(height: 30),

          SizedBox(
            height: 30,
            width: 400,
            
            child: ElevatedButton(
            onPressed: signUp,
            child: const Text(
              'Sign Up',
              style: TextStyle(
                fontWeight: FontWeight.bold),
            ),

            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.purple.shade600),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            ),
            ),

          SizedBox(height: 20,),

          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            
            child: Text(
                'Back to login',
                style: TextStyle(color: Colors.deepPurple
                ),
            ),
          ),

        ],
        ),
      ),
    );
  }
}