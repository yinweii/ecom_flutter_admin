import 'package:ecom_admin/provider/authprovider.dart';
import 'package:ecom_admin/utils/utils.dart';
import 'package:ecom_admin/widget/customtextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailEdtController = TextEditingController();
  final TextEditingController _passwordEdtController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    _emailEdtController.dispose();
    _passwordEdtController.dispose();
    super.dispose();
  }

  Future<void> _saveForm(BuildContext context) async {
    _formKey.currentState.validate();
    await Provider.of<AuthProvider>(context, listen: false).userLogIn(
      _emailEdtController.text,
      _passwordEdtController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginAuth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/adminlogin.png'),
                radius: 70,
              ),
              CustomTextField(
                  controller: _emailEdtController,
                  data: Icons.lock,
                  hintText: 'Email',
                  isObsecure: false),
              CustomTextField(
                  controller: _passwordEdtController,
                  data: Icons.lock,
                  hintText: 'password',
                  isObsecure: true),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () {
                    _saveForm(context);
                    if (loginAuth.errorMessage != null) {
                      Utils.showToast(
                          Utils.errorText(loginAuth.errorMessage) != null
                              ? Utils.errorText(loginAuth.errorMessage)
                              : loginAuth.errorMessage);
                    }
                  },
                  child: Container(
                    width: Utils.sizeHeight(context),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFFF717B),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: context.read<AuthProvider>().isLoading
                          ? CircularProgressIndicator(
                              color: Colors.grey,
                            )
                          : Text(
                              'LOGIN',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
