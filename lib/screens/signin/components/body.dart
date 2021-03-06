import 'package:desafio_flutter/auth/authentication_service.dart';
import 'package:desafio_flutter/components/input_field.dart';
import 'package:desafio_flutter/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool showingPassword = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void showPassword() {
    setState(() {
      showingPassword = !showingPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.3),
          Text(
            'Login',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
          ),
          SizedBox(height: size.height * 0.05),
          InputField(
            controller: emailController,
            prefixIcon: Icon(Icons.person),
            hintText: 'Email',
            onChanged: (value) {},
          ),
          InputField(
            controller: passwordController,
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: showingPassword
                  ? Icon(Icons.visibility)
                  : Icon(Icons.visibility_off),
              onPressed: showPassword,
            ),
            hintText: 'Senha',
            obscureText: !showingPassword,
            onChanged: (value) {},
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                var result = await context.read<AuthenticationService>().signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                if (result != '') {
                  final snackBar = SnackBar(content: Text(result));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Text('Entrar'),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 50.0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignupScreen();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Ainda n??o possiu um conta? Cadastre-se',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
