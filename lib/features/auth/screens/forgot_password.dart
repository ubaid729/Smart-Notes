import 'package:create_smart_notes/core/widgets/custom_button.dart';
import 'package:create_smart_notes/core/widgets/custom_textfield.dart';
import 'package:create_smart_notes/features/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailcontroller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Screen dimensions check karne ke liye
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: ConstrainedBox(
                  // Web/Tablet par maximum width constraint (500px)
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
                          SizedBox(height: size.height * 0.02),

                          CustomTextField(
                            controller: emailcontroller,
                            hintText: "Enter your email",
                            prefixIcon: Icons.email,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter email";
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
                                      text: "Send Reset Link",
                                      onPressed: () async {
                                        if (formkey.currentState!.validate()) {
                                          String? error =
                                              await authProvider.resetPassword(
                                            email: emailcontroller.text.trim(),
                                          );

                                          if (!mounted) return;

                                          if (error == null) {
                                            // ignore: use_build_context_synchronously
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Reset email sent",
                                                ),
                                              ),
                                            );

                                            // ignore: use_build_context_synchronously
                                            Navigator.pop(context);
                                          } else {
                                            // ignore: use_build_context_synchronously
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(error),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                    );
                            },
                          )
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