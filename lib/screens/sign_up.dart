import 'package:auth_poc/firebase_auth/firebase_auth_class.dart';
import 'package:auth_poc/screens/welcome.dart';
import 'package:flutter/material.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuthClass _auth = FirebaseAuthClass();
  final TextEditingController _nameTextEditingController =
  TextEditingController();
  final TextEditingController _passwordTextEditingController =
  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp Screen'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameTextEditingController,
              decoration: InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(
                    color: Colors.red, // Specify the border color here
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              obscureText: true,
              controller: _passwordTextEditingController,
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: const BorderSide(
                    color: Colors.red, // Specify the border color here
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _signUp,
                  child: const Text('SignUp'),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      backgroundColor:
                      MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            // The button is pressed
                            return Colors.amberAccent;
                          }
                          // The button is in its default state
                          return Colors.amber; // Default color
                        },
                      ),
                      fixedSize: MaterialStateProperty.all(
                          Size(double.infinity, 30.0))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void _signUp() async{
    dynamic user;
    String email = _nameTextEditingController.text;
    String password = _passwordTextEditingController.text;
    user = await _auth.createUserWithEmailAndPassword(email, password);
    if(user !=null){
      print('User has been successfully created');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Welcome()),
      );
    }
    else{
      print('Some error occured');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUp()),
      );
    }
  }
}
