import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screen/homepage.dart';
import 'login.dart';

class Rigister extends StatelessWidget {
  const Rigister({super.key});

  @override
  Widget build(BuildContext context) {
    return const RegisterScreen();
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "REGISTER",
                style: TextStyle(
                  color: Color.fromARGB(255, 107, 96, 96),
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 44,
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: "Enter username",
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Enter email",
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            TextField(
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Enter password",
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                onPressed: () async {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text)
                      .then((value) {
                    print("Created new account");
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const Login()));
                  });
                },
                child: const Text(
                  "Create account",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SignInOption()
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Row SignInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Do you already have an account?",
            style: TextStyle(color: Colors.black54, fontSize: 16.0)),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Login()));
          },
          child: const Text(
            "Login",
            style: TextStyle(
                color: Color.fromARGB(255, 35, 234, 41), fontSize: 18.0),
          ),
        )
      ],
    );
  }
}
