import 'package:answer_login/shared_pref/shared.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      bool loggedIn = SharedPrefController().getValueFor<bool>(Key: PreKey.loggedIn.name)??false;
      String rout = loggedIn ? '/home_screen':'/login_screen';
      Navigator.pushReplacementNamed(context, rout);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                colors: [
              Colors.pink.shade200,
              Colors.blueAccent.shade200,
            ])),
        child: Text(
          'Answer',
          style: GoogleFonts.aBeeZee(
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
