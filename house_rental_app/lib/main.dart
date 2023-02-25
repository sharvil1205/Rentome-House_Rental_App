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
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
              hintText: 'Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: login,
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: const Text('Sign up'),
            ),
          ],
        ),
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
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Name',
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: signUp,
              child: Text('Sign Up'),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to login'),
            ),

          ],
        ),
      ),
    );
  }
}