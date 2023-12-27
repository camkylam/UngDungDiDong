import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../screen/homepage.dart';
import 'register.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  Future<FirebaseApp> _initialializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initialializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
// login function

  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: (email), password: password);
      user = userCredential.user;
    } on FirebaseAuthMultiFactorException catch (e) {
      if (e.code == "user-not-found") {
        // ignore: avoid_print
        print("No user found for that email");
      }
    }
    return user;
  }

  void vaildation() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      // ignore: avoid_print
      print("Yes");
    } else {
      // ignore: avoid_print
      print("No");
    }
  }

  @override
  Widget build(BuildContext context) {
    // create the textfied controller
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "LOGIN",
                style: TextStyle(
                  color: Color.fromARGB(255, 107, 96, 96),
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
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
            TextFormField(
              controller: passwordController,
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

            // ignore: sized_box_for_whitespace
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                onPressed: () async {
                  vaildation();
                  User? user = await loginUsingEmailPassword(
                      email: emailController.text,
                      password: passwordController.text,
                      context: context);
                  print("user");
                  if (user != null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomePage()));
                  }
                },
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SignUpOption()
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Row SignUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Do not have an account?",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
            )),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegisterScreen()));
          },
          child: const Text(
            "Register",
            style: TextStyle(
                color: Color.fromARGB(255, 35, 234, 41), fontSize: 18.0),
          ),
        )
      ],
    );
  }
}
