import 'package:create_smart_notes/core/widgets/custom_button.dart';
import 'package:create_smart_notes/core/widgets/custom_textfield.dart';
import 'package:create_smart_notes/features/auth/provider/auth_provider.dart';
import 'package:create_smart_notes/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreens extends StatefulWidget {
  const SignupScreens({super.key});

  @override
  State<SignupScreens> createState() => _SignupScreensState();
}

class _SignupScreensState extends State<SignupScreens> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController confirmpasswordcontroller = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool ispasswordHidden = true;
  bool isconfirmpasswordHidden = true;

  @override
  void dispose() {
    namecontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    confirmpasswordcontroller.dispose();
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
                  // Max width limit taaki tablet/web par screen stretched na dikhe
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width > 600 ? 32.0 : 20.0,
                      vertical: 20.0,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: size.height * 0.03),
                          
                          // Logo size dynamic range ke mutabiq
                          FlutterLogo(size: size.height * 0.1 > 90 ? 90 : size.height * 0.1),
                          
                          const SizedBox(height: 25),
                          const Text(
                            'Welcome Signup page',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Signup to Continue',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          
                          SizedBox(height: size.height * 0.04),
                          
                          CustomTextField(
                            controller: namecontroller,
                            hintText: "Full Name",
                            prefixIcon: Icons.person,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your name";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
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
                            obscureText: ispasswordHidden,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  ispasswordHidden = !ispasswordHidden;
                                });
                              },
                              icon: Icon(
                                ispasswordHidden ? Icons.visibility : Icons.visibility_off,
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
                          CustomTextField(
                            controller: confirmpasswordcontroller,
                            hintText: "Confirm Password",
                            prefixIcon: Icons.lock,
                            obscureText: isconfirmpasswordHidden,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isconfirmpasswordHidden = !isconfirmpasswordHidden;
                                });
                              },
                              icon: Icon(
                                isconfirmpasswordHidden ? Icons.visibility : Icons.visibility_off,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please confirm your password";
                              }
                              if (value != passwordcontroller.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          Consumer<AuthProvider>(
                            builder: (context, authProvider, child) {
                              return authProvider.isLoading
                                  ? const CircularProgressIndicator()
                                  : CustomButton(
                                      text: 'Create Account',
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          String? error = await authProvider.signup(
                                            email: emailcontroller.text.trim(),
                                            password: passwordcontroller.text.trim(),
                                          );

                                          if (!mounted) return;

                                          if (error == null) {
                                            // ignore: use_build_context_synchronously
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('Account created successfully'),
                                              ),
                                            );
                                            // ignore: use_build_context_synchronously
                                            Navigator.pop(context);
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
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have an account?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                },
                                child: const Text('Login'),
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