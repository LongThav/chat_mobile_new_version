import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logic/auth_logic.dart';
import 'home_page.dart';
import 'login_pages.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      checkSignedIn();
    });
  }

  void checkSignedIn() async {
    AuthLogic authLogic = context.read<AuthLogic>();
    bool isLoggedIn = await authLogic.isLoggedIn();
    if (isLoggedIn) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
      return;
    }
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody,
    );
  }

  get _buildBody {
    return SafeArea(
      child: Column(
        children: const [
          SizedBox(
            height: 80,
          ),
          Center(
            child: Text(
              'តោះៗ',
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'khmer',
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              'និយាយគ្នា',
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'khmer',
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              '💕',
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'khmer',
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
