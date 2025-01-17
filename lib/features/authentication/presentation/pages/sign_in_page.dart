import 'package:blog_app/core/common/widgets/state_loading_view.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/snackbar_message.dart';
import 'package:blog_app/features/authentication/domain/usercases/current_user.dart';

import 'package:blog_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/authentication/presentation/pages/sign_up_page.dart';
import 'package:blog_app/features/authentication/presentation/widgets/app_theme_switcher.dart';
import 'package:blog_app/features/authentication/presentation/widgets/auth_field_view.dart';
import 'package:blog_app/features/authentication/presentation/widgets/auth_gradient_btn.dart';
import 'package:blog_app/features/authentication/presentation/widgets/auth_text_btn.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (_) => SignInPage(),
      );
  static const String id = "/sign-in";

  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          AppThemeSwitcher(),
        ],
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            SnackBarMessage(context, message: state.message).show();
          } else if (state is AuthSuccess) {
            context.read<AuthBloc>().add(AuthIsUserLoggedIn());
            Navigator.pushAndRemoveUntil(
                context, BlogPage.route(), (route) => false);
          }
        },
        builder: (context, state) {
          return StateLoadingView(
            isLoading: state is AuthLoading,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sign In.",
                      style: TextStyle(
                        fontSize: 57,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    AuthFieldView(
                      hintText: "Email",
                      controller: _emailController,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    AuthFieldView(
                      obscureText: true,
                      hintText: "Password",
                      controller: _passwordController,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    AuthGradientBtn(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                AuthSignIn(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                ),
                              );
                        }
                      },
                      text: "Sign In",
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    AuthTextBtn(
                      onPressed: () {
                        Navigator.push(
                          context,
                          SignUpPage.route(),
                        );
                      },
                      title: "Don't have an account? ",
                      subTitle: "Sign Up",
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
