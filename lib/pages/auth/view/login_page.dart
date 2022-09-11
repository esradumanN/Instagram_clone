import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/pages/auth/view_model/auth_bloc/auth_bloc.dart';
import 'package:instagram_clone/ui/basic_form_field.dart';
import 'package:instagram_clone/ui/blue_button.dart';
import 'package:instagram_clone/ui/button_loading.dart';

import '../../../core/constants/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _usernameController.text = "mdpgroup";
    _passwordController.text = "12345";
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sizeHelper.sbh(150),
              Center(
                child: Image.asset("assets/images/Instagram Logo.png"),
              ),
              sizeHelper.sbh(50),
              Column(
                children: [
                  BasicFormField(
                    maxLines: 1,
                    w: sizeHelper.getWidth(343),
                    controller: _usernameController,
                  ),
                  sizeHelper.sbh(20),
                  BasicFormField(
                    maxLines: 1,
                    w: sizeHelper.getWidth(343),
                    controller: _passwordController,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Spacer(),
                  TextButton(
                    child: Text("Forgot Password?"),
                    onPressed: () {},
                  )
                ],
              ),
              BlocBuilder(
                bloc: authBloc,
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return BlueButtonLoading();
                  }
                  return BlueButton(
                    title: "Log in",
                    func: () {
                      ;
                      authBloc.add(LoginEvent(
                          username: _usernameController.text,
                          password: _passwordController.text));
                    },
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/icons/facebook.png"),
                  TextButton(
                    child: Text("Log in with Facebook"),
                    onPressed: () {},
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                    height: 2,
                    color: AppColors.lightGrey,
                  )),
                  sizeHelper.sbw(40),
                  Text(
                    "OR",
                    style: TextStyle(
                        color: AppColors.grey, fontWeight: FontWeight.w600),
                  ),
                  sizeHelper.sbw(40),
                  Expanded(
                      child: Container(
                    height: 2,
                    color: AppColors.lightGrey,
                  )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't you have a account? ",
                    style: TextStyle(
                        color: AppColors.grey, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Sign up.",
                    style: TextStyle(
                        color: AppColors.lightBlue,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              sizeHelper.sbh(100),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Instagram or Facebook",
                    style: TextStyle(
                        color: AppColors.grey, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              sizeHelper.sbh(10),
            ],
          ),
        ),
      ),
    );
  }
}
