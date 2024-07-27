import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/ui/register/bloc/register_cubit.dart';

import '../../constants/constants.dart';
import '../../domain/authentication_repository/authentication_repository.dart';
import '../login/login_page.dart';

class RegisterPage extends StatelessWidget {
  static const route = '/register_page';
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) {
          final authenticationRepository =
              context.read<AuthenticationRepository>();
          return RegisterCubit(
            authenticationRepository: authenticationRepository,
          );
        },
        child: const RegisterPageView(),
      ),
    );
  }
}

class RegisterPageView extends StatefulWidget {
  const RegisterPageView({super.key});

  @override
  State<RegisterPageView> createState() => _RegisterPageViewState();
}

class _RegisterPageViewState extends State<RegisterPageView> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();
  final usernameFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  final confirmPasswordFormKey = GlobalKey<FormState>();
  var _autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          // Show loading indicator
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        }
        if (state is RegisterSuccess) {
          // show dialog success
          //Navigator.of(context).pop(); // Dismiss loading indicator
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Register success'),
            ),
          );
        }
        if (state is RegisterFailure) {
          Navigator.of(context).pop(); // Dismiss loading indicator
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildTextTitle(),
                _buildFormRegister(),
                const SizedBox(height: 30),
                _buildFormPassword(),
                const SizedBox(height: 30),
                _buildFormConfirmPassword(),
                _buildRegisterButton(),
                _buildOrSplitDivider(),
                _buildRegisterWithGoogleButton(),
                _buildRegisterWithAppleButton(),
                const SizedBox(height: 20),
                _buildHaveAnAccount(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextTitle() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      alignment: Alignment.centerLeft,
      child: const Text(
        'REGISTER',
        style: TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFormRegister() {
    return Form(
      key: usernameFormKey,
      autovalidateMode: _autoValidateMode,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Username',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextFormField(
              controller: _emailTextController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                final emailValid = RegExp(Constants.emailRegex).hasMatch(value);
                if (!emailValid) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: 'Enter your username',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                fillColor: Colors.grey.withOpacity(0.2),
                filled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormPassword() {
    return Form(
      key: passwordFormKey,
      autovalidateMode: _autoValidateMode,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextFormField(
              controller: _passwordTextController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              obscureText: true,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: 'Enter your password',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                fillColor: Colors.grey.withOpacity(0.2),
                filled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormConfirmPassword() {
    return Form(
      key: confirmPasswordFormKey,
      autovalidateMode: _autoValidateMode,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Confirm Password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextFormField(
              controller: _confirmPasswordTextController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                if (value != _passwordTextController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
              obscureText: true,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: 'Confirm password',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                fillColor: Colors.grey.withOpacity(0.2),
                filled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Container(
        margin: const EdgeInsets.only(top: 50),
        height: 48,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            _register();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(Constants.primaryColor),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ),
          child: const Text(
            'Create Account',
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  Widget _buildOrSplitDivider() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              color: Colors.white.withOpacity(0.5),
              height: 1,
            ),
          ),
          Text(
            'OR',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              color: Colors.white.withOpacity(0.5),
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterWithGoogleButton() {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        height: 48,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            print('Register with Google');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              side: BorderSide(
                color: Color(Constants.primaryColor),
                width: 1,
              ),
            ),
          ),
          child: const Text(
            'Register with Google',
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  Widget _buildRegisterWithAppleButton() {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        height: 48,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            print('Register with Apple');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              side: BorderSide(
                color: Color(Constants.primaryColor),
                width: 1,
              ),
            ),
          ),
          child: const Text(
            'Register with Apple',
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  Widget _buildHaveAnAccount() {
    return RichText(
        text: TextSpan(
      text: 'Already have an account? ',
      style: TextStyle(
        color: Colors.white.withOpacity(0.5),
      ),
      children: [
        TextSpan(
          text: 'Login',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.of(context).pushNamed(LoginPage.route);
            },
        ),
      ],
    ));
  }

  void _register() {
    if (_autoValidateMode == AutovalidateMode.disabled) {
      setState(() {
        _autoValidateMode = AutovalidateMode.always;
      });
    }
    final email = _emailTextController.text;
    final password = _passwordTextController.text;

    final isEmailValid = usernameFormKey.currentState?.validate() ?? false;
    final isPasswordValid = passwordFormKey.currentState?.validate() ?? false;
    final isConfirmPasswordValid =
        confirmPasswordFormKey.currentState?.validate() ?? false;
    final isValid = isEmailValid && isPasswordValid && isConfirmPasswordValid;

    if (!isValid) {
      print('Form is not valid');
      return;
    } else {
      context.read<RegisterCubit>().register(email, password);
    }
  }
}
