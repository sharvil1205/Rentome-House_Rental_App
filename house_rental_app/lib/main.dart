import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:house_rental_app/TenantHomePage.dart';
import 'package:house_rental_app/LandlordHomePage.dart';

String uname = "";
int uid=0;
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

          uname = emailController.text;
          if(response['type'] == 'Tenant') Navigator.push(context, MaterialPageRoute(builder: (context) => TenantHomePage()));
          else  Navigator.push(context, MaterialPageRoute(builder: (context) => LandlordHomePage()));

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
              margin: const EdgeInsets.all(16.0),
              
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(1),
                    blurRadius: 8.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
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
            margin: const EdgeInsets.all(16.0),
            
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(1),
                  blurRadius: 8.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),

            child: TextField(
              controller: passwordController,
              decoration: const InputDecoration(
              hintText: 'Password',
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
              prefixIcon: Icon(Icons.lock, color: Colors.grey),
              ),
              obscureText: true,
            ),
          ),
          ),
          

          const SizedBox(height: 30),
                     
          SizedBox(
            height: 30,
            width: 400,
            child: ElevatedButton(
            onPressed: login,
          
            style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.purple.shade600),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),),
            ),
            ),
            child: const Text(
              'Login',
              style: TextStyle(
                fontWeight: FontWeight.bold),
            ),
            ),
            ),
            
            const SizedBox(height: 20),
            
            Row(    
              children: [
                const SizedBox(width:130),
                const Text("Don't have an account? "),
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
  bool _isTenantChecked = false;
  bool _isLandlordChecked = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future signUp() async {
  
    if(nameController.text!="" && emailController.text!="" && passwordController.text!="")
    {
      try{
        bool tl = false;
        if(_isTenantChecked) tl = true;

        String uri = 'http://localhost:3000/signup';

        var res = await http.post(Uri.parse(uri), body: {
          "name": nameController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "tenant": tl.toString()
        });

        var response = jsonDecode(res.body);
        if(response['success'] == true){
          print("record inserted");
        
          uname = emailController.text;
          if(response['type'] == 'Tenant') Navigator.push(context, MaterialPageRoute(builder: (context) => TenantHomePage()));
          else Navigator.push(context, MaterialPageRoute(builder: (context) => LandlordHomePage()));

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
              margin: const EdgeInsets.all(16.0),
              
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
            
              boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(1),
                blurRadius: 8.0,
                offset: const Offset(0, 4),
              ),
              ],
              ),

              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                hintText: 'Name',
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
                prefixIcon: Icon(Icons.person_2, color: Colors.grey),
                ),
              ),
            ),

            Container(
              height: 34,
              width: 400,
              margin: const EdgeInsets.all(16.0),
            
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(1),
                  blurRadius: 8.0,
                  offset: const Offset(0, 4),
                ),
                ],
              ),

              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
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
              margin: const EdgeInsets.all(16.0),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(1),
                    blurRadius: 8.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                  hintText: 'Password',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
                  prefixIcon: Icon(Icons.lock, color: Colors.grey),
                  ),
                  obscureText: true,
                ),
            ),
          ),
        
          const SizedBox(height: 30),
          CheckboxListTile(
              title: const Text('Tenant'),
              value: _isTenantChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isTenantChecked = value!;
                  _isLandlordChecked = false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Landlord'),
              value: _isLandlordChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isLandlordChecked = value!;
                  _isTenantChecked = false;
                });
              },
            ),
            const SizedBox(height: 30),
          SizedBox(
            height: 30,
            width: 400,
            
            child: ElevatedButton(
            onPressed: signUp,

            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.purple.shade600),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            child: const Text(
              'Sign Up',
              style: TextStyle(
                fontWeight: FontWeight.bold),
            ),
            ),
            ),

          const SizedBox(height: 20,),

          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            
            child: const Text(
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