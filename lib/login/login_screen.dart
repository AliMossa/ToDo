import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/login/bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moreInfo = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/login.png'),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue.withOpacity(.5),
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  onChanged: (value) {
                    print("the valeu is $value");
                    context.read<LoginBloc>().data.userNameV = value;
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context)
                        .requestFocus(context.read<LoginBloc>().data.password);
                  },
                  focusNode: context.watch<LoginBloc>().data.userName,
                  decoration: const InputDecoration(
                      hintText: 'User Name', border: InputBorder.none),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue.withOpacity(.5),
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  onChanged: (value) {
                    context.read<LoginBloc>().data.passwordV = value;
                  },
                  focusNode: context.watch<LoginBloc>().data.password,
                  obscureText: !context.watch<LoginBloc>().data.secure,
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () {
                          context.read<LoginBloc>().add(ShowPasswordEvent());
                        },
                        child: context.watch<LoginBloc>().state
                                is ShowPasswordState
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                      hintText: 'Password',
                      border: InputBorder.none),
                ),
              ),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  print(state);
                  if (state is ExceptionLoginState) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        "Login has been failed",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ));
                  } else if (state is SuccessLoginState) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                  }
                },
                builder: (context, state) => SizedBox(
                  width: moreInfo.width * 0.8,
                  height: moreInfo.height * .08,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.blue.withOpacity(.8),
                      ),
                    ),
                    onPressed: () {
                      context.read<LoginBloc>().add(SendLoginEvent());
                    },
                    child: context.watch<LoginBloc>().state is LoadingLoginState
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
