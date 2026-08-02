import 'package:create_smart_notes/core/widgets/custom_button.dart';
import 'package:create_smart_notes/core/widgets/custom_textfield.dart';
import 'package:create_smart_notes/features/auth/provider/auth_provider.dart';
import 'package:create_smart_notes/features/auth/screens/forgot_password.dart';
import 'package:create_smart_notes/features/auth/screens/signup_screens.dart';
import 'package:create_smart_notes/features/notes/screens/notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isPasswordHidden = true;

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Screen height aur width calculate karne ke liye
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: ConstrainedBox(
                  // Max width limit (500) set ki hai taaki Tablet/Web par form excessive stretched na lage
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width > 600 ? 32.0 : 20.0,
                      vertical: 20.0,
                    ),
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: size.height * 0.03),

                          // Dynamic Logo sizing (Chhoti screens par tight fit hone se bachane ke liye)
                          FlutterLogo(size: size.height * 0.1 > 90 ? 90 : size.height * 0.1),

                          const SizedBox(height: 25),
                          const Text(
                            'Welcome Back',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Login to Continue',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),

                          SizedBox(height: size.height * 0.04),

                          CustomTextField(
                            controller: emailcontroller,
                            hintText: "Email",
                            prefixIcon: Icons.email,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: passwordcontroller,
                            hintText: "Password",
                            prefixIcon: Icons.lock,
                            obscureText: isPasswordHidden,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordHidden = !isPasswordHidden;
                                });
                              },
                              icon: Icon(
                                isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const ForgotPassword(),
                                  ),
                                );
                              },
                              child: const Text("Forgot Password?"),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Consumer<AuthProvider>(
                              builder: (context, authProvider, child) {
                                return authProvider.isLoading
                                    ? const CircularProgressIndicator()
                                    : CustomButton(
                                        text: 'Login',
                                        onPressed: () async {
                                          if (formkey.currentState!.validate()) {
                                            String? error = await authProvider.login(
                                              email: emailcontroller.text.trim(),
                                              password: passwordcontroller.text.trim(),
                                            );

                                            if (!mounted) return;

                                            if (error == null) {
                                              // ignore: use_build_context_synchronously
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  content: Text("Login Successful"),
                                                ),
                                              );

                                              // ignore: use_build_context_synchronously
                                              Navigator.pushReplacement(
                                                // ignore: use_build_context_synchronously
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => const NotesScreen(),
                                                ),
                                              );
                                            } else {
                                              // ignore: use_build_context_synchronously
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(error),
                                                ),
                                              );
                                            }
                                          }
                                        },
                                      );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const SignupScreens(),
                                    ),
                                  );
                                },
                                child: const Text("Sign Up"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}