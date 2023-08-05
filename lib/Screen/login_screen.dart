// import 'dart:js';

// import 'dart:js';

import 'package:answer_login/context-extenssion.dart';
import 'package:answer_login/database/controller/user_db_controller.dart';
import 'package:answer_login/database/db_controller.dart';
import 'package:answer_login/modle/process_response.dart';
import 'package:answer_login/provieder/language_provider.dart';
import 'package:answer_login/shared_pref/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  bool _obscureText = true;

  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  late String _language;

  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _language =
        SharedPrefController().getValueFor<String>(Key: PreKey.language.name) ??
            'en';

    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(context.localizations.login,
          style: GoogleFonts.aBeeZee(
              fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showLanguageBottomSheet();
              // _showLanguageBottomSheet();
            },
            icon: const Icon(
              Icons.language,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.localizations.login_title,
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            Text(
              context.localizations.login_subtitle,
              style: GoogleFonts.nunito(
                fontSize: 15,
                color: Colors.black45,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailTextController,
              style: GoogleFonts.nunito(),
              onTap: () => print('Tapped'),
              onChanged: (String value) => print('Value: $value'),
              textInputAction: TextInputAction.send,
              onSubmitted: (String value) => print('Submitted: $value'),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                constraints: BoxConstraints(
                  maxHeight: _emailError == null ? 50 : 70,
                ),
                hintText: context.localizations.email,
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
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordTextController,
              keyboardType: TextInputType.text,
              style: GoogleFonts.nunito(),
              obscureText: _obscureText,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                constraints:
                BoxConstraints(maxHeight: _passwordError == null ? 50 : 70),
                hintText: context.localizations.password,
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
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async => await _performLogin(),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child:  Text(context.localizations.login),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.localizations.have_no_account,
                  style: GoogleFonts.cairo(),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/register_screen'),
                  child: Text(
                    context.localizations.create,
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
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
  Future<void> _performLogin() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (_checkData()) {
      // Navigator.pushReplacementNamed(context, '/home_screen');
      _login();
    }
  }

  bool _checkData() {
    _controlErrorValue();
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    // context.showMessage(message: 'Error, enter required data!', error: true);
    return false;
  }

  //
  void _controlErrorValue() {
    setState(() {
      _emailError =
      _emailTextController.text.isEmpty ? 'Enter email address' : null;
      _passwordError =
      _passwordTextController.text.isEmpty ? 'Enter password' : null;
    });
  }

  //
  void _login() async {
    ProcessResponse processResponse = await UserDbController().login(
        email: _emailTextController.text,
        password: _passwordTextController.text);
    if(processResponse.success){
    Navigator.pushReplacementNamed(context as BuildContext, '/home_screen');
  }
    context.showMessage(
        message: processResponse.message, error: !processResponse.success);
  }

  void _showLanguageBottomSheet() async {
    String? languag = await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(10),
          topEnd: Radius.circular(10),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        context.localizations.language_sheet_title,
                        style: GoogleFonts.aBeeZee(
                            fontSize: 22,
                            // height: 1.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                      Text(
                        context.localizations.language_sheet_subtitle,
                        style: GoogleFonts.aBeeZee(
                            fontSize: 19,
                            // height: 1.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black12),
                      ),
                      Divider(),
                      RadioListTile<String>(
                          value: 'en',
                          title: Text('English', style: GoogleFonts.aBeeZee(),),
                          groupValue: _language,
                          onChanged: (String? value) {
                            if (value != null) {
                              setState(() {
                                _language = value;
                                Navigator.pop(context, 'en');
                              });
                            }
                          }),
                      RadioListTile<String>(
                          value: 'ar',
                          title: Text('العربية', style: GoogleFonts.aBeeZee(),),
                          groupValue: _language,
                          onChanged: (String? value) {
                            if (value != null) {
                              setState(() {
                                _language = value;
                                Navigator.pop(context, 'ar');
                              });
                            }
                          }),
                    ],
                  ),
                );
              },);
          },
        );
      },
    );
    // if(languag!= null){
    //
    if (languag != null) {
      Future.delayed(Duration(milliseconds: 700), () {
        Provider.of<LanguageProvider>(context, listen: false).changeLanguage();
      });
    }
  }
}

