import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/provider/auth/auth_provider.dart';
import 'package:spotstock_inventory/common/provider/user_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/desktop/home/home_screen_desktop.dart';
import 'package:spotstock_inventory/widgets/button_widget.dart';
import 'package:spotstock_inventory/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:simple_text_field/simple_text_field.dart';

final box = GetStorage();

class LoginScreenDesktop extends StatefulWidget {
  const LoginScreenDesktop({super.key});

  @override
  State<LoginScreenDesktop> createState() => _LoginScreenDesktopState();
}

final GlobalKey<FormState> _formState = GlobalKey<FormState>();

class _LoginScreenDesktopState extends State<LoginScreenDesktop> {
  late TextEditingController _email;
  late TextEditingController _password;
  bool _isLoading = false;
  bool _obscurePassword = true; // State to manage password visibility

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: box.read('email') ?? '');
    _password = TextEditingController(text: box.read('password') ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF2FCFE),
                  Color(0xFFFAF1FE),
                ],
                stops: [0, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 500,
              height: 350,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const Text(
                    "Sign In",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontFamily: sofia,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Form(
                    key: _formState,
                    child: Column(
                      children: [
                        const SizedBox(height: 30.0),
                        SimpleTextField(
                          controller: _email,
                          decoration: SimpleInputDecoration(
                            hintText: "Email address",
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                            ),
                            fillColor: const Color(0xFFF5F5F5),
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 18.0,
                              horizontal: 20.0,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none, // Remove border
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide.none, // Remove focused border
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        SimpleTextField(
                          controller: _password,
                          obscureText:
                              _obscurePassword, // Manage password visibility
                          decoration: SimpleInputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                            ),
                            fillColor: const Color(0xFFF5F5F5),
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 18.0,
                              horizontal: 20.0,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none, // Remove border
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide.none, // Remove focused border
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        SizedBox(
                          width: double.infinity,
                          child: ButtonGradWidget(
                            onPress: () {
                              if (_formState.currentState?.validate() == true) {
                                setState(() {
                                  _isLoading = !_isLoading;
                                });
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .userLogin(_email.text, _password.text)
                                    .then((response) {
                                  setState(() {
                                    _isLoading = !_isLoading;
                                  });
                                  if (response['status']) {
                                    UserDetails user = response['data'];
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .setUser(user);
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return HomeScreenDesktop();
                                    }));
                                  } else {
                                    Dialogs.alertDialog(
                                        context,
                                        "Failed Login",
                                        response['message'],
                                        "cancel",
                                        "save", []);
                                  }
                                });
                              }
                            },
                            title: 'Submit',
                            isLoading: _isLoading,
                            buttonColor: primaryColor,
                            titleColor: whiteColor,
                            borderColor: primaryColor,
                            paddingHorizontal: 15.0,
                            paddingVertical: 15.0,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
