import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../constants/size_constants.dart';
import '../constants/text_field_constants.dart';
import '../internate_loading/loadingstatus.dart';
import '../logic/auth_logic.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final authlogic = Provider.of<AuthLogic>(context);

    switch (authlogic.loadingstatus) {
      case Loadingstatus.authenticateError:
        // Fluttertoast.showToast(msg: 'Sign in failed');
        SnackBar(content: Text('Sign in failed'));
        break;
      case Loadingstatus.authenticateCanceled:
        // Fluttertoast.showToast(msg: 'Sign in cancelled');
        SnackBar(content: Text('Sign in cancelled'));
        break;
      case Loadingstatus.authenticated:
        // Fluttertoast.showToast(msg: 'Sign in successful');
        SnackBar(content: Text('Sign in successfull'));
        break;
      default:
        break;
    }

    return Scaffold(
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.dimen_30,
              horizontal: Sizes.dimen_20,
            ),
            children: [
              vertical50,
              const Text(
                'Welcome to Smart Talk',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Sizes.dimen_26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              vertical30,
              const Text(
                'Login to continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Sizes.dimen_22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              vertical50,
              Center(child: Image.asset('assets/images/back.png')),
              vertical50,
              GestureDetector(
                onTap: () async {
                  bool isSuccess = await authlogic.handleGoogleSignIn();
                  if (isSuccess) {
                    Future.delayed(const Duration(milliseconds: 300), () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    });
                  }
                },
                child: Image.asset('assets/images/google_login.jpg'),
              ),
            ],
          ),
          Center(
            child: authlogic.loadingstatus == Loadingstatus.authenticating
                ? const CircularProgressIndicator(
                    color: AppColors.lightGrey,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
