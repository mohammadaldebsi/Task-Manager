import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/screens/navigation_bar.dart';
import 'package:task_manager/theme.dart';
import 'package:task_manager/utils/component.dart';
import '../services/auth_service.dart';
import '../utils/constants.dart';
import '../utils/validations.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with FormValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool isPassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final authService = Provider.of<AuthService>(context, listen: false);
      try {
        await authService.loginUser(
            _usernameController.text, _passwordController.text);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationBarView(),));
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(
              child: Stack(
                children: [
                  headContainer(size, 3.5),
                  const Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Welcome back to",
                              style: TextStyle(
                                  fontSize: 28,
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.bold)),
                          Text("Task Manager",
                              style: TextStyle(
                                  fontSize: 28,
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.bold)),
                          Text("Sign in to your account",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "SF-Pro",
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.w400))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  formField(
                      controller: _usernameController,
                      type: TextInputType.text,
                      hint: "Username",
                      prefix: Icons.email_outlined,
                      valid: emptyValidation),
                  const SizedBox(height: 12),
                  formField(
                    controller: _passwordController,
                    isPassword: isPassword,
                    hint: 'Password',
                    prefix: Icons.lock,
                    suffix:
                    isPassword ? Icons.visibility : Icons.visibility_off,
                    suffixPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                    type: TextInputType.visiblePassword,
                    valid: emptyValidation,
                  ),
                  const SizedBox(height: 64),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                      width: size.width,
                      child: customButton(
                          function: _login,
                          text: "Login",
                          style: const TextStyle(color: kWhiteColor))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
