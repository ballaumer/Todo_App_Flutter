import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/views/splash_screen.dart';
import 'controllers/add_update_tasks_controller.dart';
import 'controllers/auth_controller.dart';
import 'package:flutter/services.dart';

Future main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider<AddorUpdateTasksController>(create:(_)=>AddorUpdateTasksController() ),
         ChangeNotifierProvider<GoogleAuthController>(create:(_)=>GoogleAuthController() ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home:  SplashScreen(),
      ),
    );
  }
}
