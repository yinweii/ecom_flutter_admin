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
              RaisedButton(
                onPressed: () async {
                  _saveForm(context);
                  if (loginAuth.errorMessage != null) {
                    Utils.showToast(
                        Utils.errorText(loginAuth.errorMessage) != null
                            ? Utils.errorText(loginAuth.errorMessage)
                            : loginAuth.errorMessage);
                  }
                },
                color: Colors.red[200],
                child: context.read<AuthProvider>().isLoading
                    ? Container(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator())
                    : Text(
                        'LOGIN',
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
