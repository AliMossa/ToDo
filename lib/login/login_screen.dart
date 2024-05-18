import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/home/bloc/home_bloc.dart';
import 'package:todo/login/bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
   LoginScreen({Key? key}) : super(key: key);

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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    print("the value is $value");
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    context.read<LoginBloc>().data.passwordV = value;
                  },
                  focusNode: context.watch<LoginBloc>().data.password,
                  obscureText:!context.watch<LoginBloc>().data.secure,
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
              // Add a button to trigger validation
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If all forms are valid, proceed with login logic
                    context.read<LoginBloc>().add(SendLoginEvent());
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
