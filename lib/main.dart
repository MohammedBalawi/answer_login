import 'package:answer_login/Screen/home_screen.dart';
import 'package:answer_login/Screen/launch_screen.dart';
import 'package:answer_login/Screen/login_screen.dart';
import 'package:answer_login/Screen/register_screen.dart';
import 'package:answer_login/database/db_controller.dart';
import 'package:answer_login/provieder/language_provider.dart';
import 'package:answer_login/provieder/note_provieder.dart';
import 'package:answer_login/shared_pref/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPreferences();
  await DbController().initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 812),
        builder: (context, child) {
        return MultiProvider(
            providers: [
        ChangeNotifierProvider<LanguageProvider>(create: (context) => LanguageProvider()) ,
              ChangeNotifierProvider<NotesProvider>(create: (context) => NotesProvider ()),
        ],
        builder: (context ,widget){
          return MaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              textTheme: TextTheme(),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),

                    textStyle: GoogleFonts.cairo()),
              ),

              appBarTheme: AppBarTheme(
                iconTheme: const IconThemeData(color: Colors.black),
                elevation: 0,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                titleTextStyle: GoogleFonts.cairo(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            debugShowCheckedModeBanner: false,

            localizationsDelegates: const [

              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,

              AppLocalizations.delegate,

            ],

            // supportedLocales: AppLocalizations.supportedLocales,
            supportedLocales: const [
              Locale('ar'),
              Locale('en'),
            ],
            locale: Locale(Provider .of<LanguageProvider> (context, listen: true).language),

            initialRoute: '/launch_screen',
            routes: {
              '/launch_screen': (context) => const LaunchScreen(),
              '/login_screen': (context) => const LoginScreen(),
              '/home_screen': (context) =>  HomeScreen(),
              '/register_screen': (context) => const RegisterScreen(),

            },


          );
        }
        );
        }


    );

  }
}
