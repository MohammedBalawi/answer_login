// ignore_for_file: use_build_context_synchronously

import 'package:answer_login/context-extenssion.dart';
import 'package:answer_login/database/controller/user_db_controller.dart';
import 'package:answer_login/modle/process_response.dart';
import 'package:answer_login/modle/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscureText = true;

  late TextEditingController _nameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  String? _nameError;
  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(AppLocalizations.of(context)!.register,
          style: GoogleFonts.aBeeZee(color: Colors.black,),),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(
            AppLocalizations.of(context)!.register_title,
        style: GoogleFonts.nunito(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.black,
        ),
      ),
      Text(
        AppLocalizations.of(context)!.register_subtitle,
        style: GoogleFonts.nunito(
          fontSize: 15,
          color: Colors.black45,
        ),
      ),
      SizedBox(height: 20),
      TextField(
        controller: _nameTextController,
        style: GoogleFonts.nunito(),
        //***************************
        onTap: () => print('Tapped'),
        onChanged: (String value) => print('Value: $value'),
        textInputAction: TextInputAction.send,
        onSubmitted: (String value) => print('Submitted: $value'),
        //***************************
        keyboardType: TextInputType.name,
        //***************************
        decoration: InputDecoration(
          //***************************
          contentPadding: EdgeInsets.zero,
          constraints: BoxConstraints(
            maxHeight: _emailError == null ? 50 : 70,
          ),
          hintText: AppLocalizations.of(context)!.name,
          hintMaxLines: 1,
          hintStyle: GoogleFonts.nunito(),
          prefixIcon: const Icon(Icons.person),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.green,
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
          //***************************
          errorText: _nameError,
          errorMaxLines: 1,
          errorStyle: GoogleFonts.nunito(),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color: Colors.red.shade300,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color: Colors.red.shade800,
            ),
          ),
          //***************************
        ),
      ),
      SizedBox(height: 10),
      TextField(
        controller: _emailTextController,
        style: GoogleFonts.nunito(),
        //***************************
        onTap: () => print('Tapped'),
        onChanged: (String value) => print('Value: $value'),
        textInputAction: TextInputAction.send,
        onSubmitted: (String value) => print('Submitted: $value'),
        //***************************
        keyboardType: TextInputType.emailAddress,
        //***************************
        decoration: InputDecoration(
          //***************************
          contentPadding: EdgeInsets.zero,
          constraints: BoxConstraints(
            maxHeight: _emailError == null ? 50 : 70,
          ),
          hintText: AppLocalizations.of(context)!.email,
          hintMaxLines: 1,
          hintStyle: GoogleFonts.nunito(),
          prefixIcon: const Icon(Icons.email),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.green,
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
          //***************************
          errorText: _emailError,
          errorMaxLines: 1,
          errorStyle: GoogleFonts.nunito(),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color: Colors.red.shade300,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color: Colors.red.shade800,
            ),
          ),
          //***************************
        ),
      ),
      SizedBox(height: 10),
      TextField(
        controller: _passwordTextController,
        keyboardType: TextInputType.text,
        style: GoogleFonts.nunito(),
        obscureText: _obscureText,
        decoration: InputDecoration(
          /************************/
          contentPadding: EdgeInsets.zero,
          constraints: BoxConstraints(
              maxHeight: _passwordError == null ? 50 : 70),
          /************************/
          hintText: AppLocalizations.of(context)!.password,
          hintStyle: GoogleFonts.nunito(),
          hintMaxLines: 1,
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() => _obscureText = !_obscureText);
            },
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.blue,
            ),
          ),

          //***************************
          errorText: _passwordError,
          errorMaxLines: 1,
          errorStyle: GoogleFonts.nunito(),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color: Colors.red.shade300,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color: Colors.red.shade800,
            ),
          ),
          //***************************
        ),
      ),
      SizedBox(height: 20),
      ElevatedButton(
        onPressed: () async =>await _performRegister(),
        style: ElevatedButton.styleFrom(
          primary: Colors.blueGrey,
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),),),
            child: Text(AppLocalizations.of(context)!.register),
          ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){},
      //   child: Icon(Icons.language),
      // ),
    );
  }

  //SOLID
  Future<void> _performRegister() async{
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (_checkData()) {
      _register();
    }
  }

  bool _checkData() {
    _controlErrorValue();
    if (_nameTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }

    context.showMessage(message: 'Error, enter required data!', error: true);
    return false;
  }

  void _controlErrorValue() {
    setState(() {
      _nameError = _emailTextController.text.isEmpty ? 'Enter your name' : null;
      _emailError =
      _emailTextController.text.isEmpty ? 'Enter email address' : null;
      _passwordError =
      _passwordTextController.text.isEmpty ? 'Enter password' : null;
    });
  }

  void _register() async {
    ProcessResponse processResponse =
    await UserDbController().register(user: user);
    if (processResponse.success) {
      Navigator.pop(context);
    }
    context.showMessage(
        message: processResponse.message, error: !processResponse.success);
  }

  User get user {
    User user = User();
    user.name=_nameTextController.text;
    user.email=_emailTextController.text;
    user.password=_passwordTextController.text;
    return user;
  }
}
