import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/add_update_tasks_controller.dart';
import '../controllers/auth_controller.dart';
import '../utils/navigator.dart';
import 'home.dart';

class LoginScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Consumer<AddorUpdateTasksController>(
        builder: (context, pro, child) => Center(
          child: Consumer<GoogleAuthController>(
            builder: (context,provider, child)=> ElevatedButton.icon(
              onPressed: (){
                provider.signInWithGoogle(context).then((value) {
                  if(value.data == true){
                    pro.getTasks();
                    Navi.navigatePushRemoveTo(context, HomeScreen());
                  }else{
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Something Went Wrong'),
                      ),
                    );
                  }
                });

              },
              icon: Icon(Icons.login),
              label: Text('Sign in with Google'),
            ),
          ),
        ),
      ),
    );
  }
}
