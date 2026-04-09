import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../common/colors.dart';
import '../../../common/primary_button.dart';
import '../../../common/social_buttons.dart';
import '../../palette/screens/home_color.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isSignIn = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }
    if (!_isSignIn && name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter your name.')));
      return;
    }

    final cubit = AuthCubit.get(context);
    if (_isSignIn) {
      cubit.login(email: email, password: password);
    } else {
      cubit.register(name: name, email: email, password: password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeColor()),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          backgroundColor: AppColors.darkBackground,
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: SvgPicture.asset(
                'assets/images/x.svg',
                width: 24,
                height: 24,
              ),
            ),
            backgroundColor: AppColors.darkBackground,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                spacing: 32,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.overlay50,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    height: 46,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        spacing: 12,
                        children: [
                          Expanded(
                            child: FilledButton(
                              onPressed: () => setState(() => _isSignIn = true),
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  _isSignIn
                                      ? AppColors.darkBackground
                                      : AppColors.overlay50,
                                ),
                              ),
                              child: const Text(
                                'Sign In',
                                style: TextStyle(color: AppColors.white),
                              ),
                            ),
                          ),
                          Expanded(
                            child: FilledButton(
                              onPressed: () =>
                                  setState(() => _isSignIn = false),
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  !_isSignIn
                                      ? AppColors.darkBackground
                                      : AppColors.overlay50,
                                ),
                              ),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(color: AppColors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _isSignIn ? 'Sign In' : 'Sign Up',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  if (!_isSignIn)
                    _buildField(
                      label: 'Full Name',
                      hint: 'Enter Your Name',
                      controller: _nameController,
                    ),

                  _buildField(
                    label: 'Email',
                    hint: 'Enter Your Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                      Text(
                        'Password',
                        style: TextStyle(
                          color: const Color(0xFFA7AFB7),
                          fontSize: 18,
                        ),
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Enter Your Password',
                          hintStyle: TextStyle(color: AppColors.grey),
                          fillColor: AppColors.overlay50,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.grey,
                            ),
                            onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                          ),
                        ),
                      ),
                      if (_isSignIn)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                            ),
                          ),
                        ),
                    ],
                  ),

                  Column(
                    spacing: 20,
                    children: [
                      isLoading
                          ? const CircularProgressIndicator(
                              color: AppColors.primary,
                            )
                          : PrimaryButton(
                              onPressed: () => _submit(context),
                              buttonText: _isSignIn
                                  ? 'Sign In'
                                  : 'Create Account',
                            ),
                      Text(
                        'Or continue with',
                        style: TextStyle(color: AppColors.grey, fontSize: 16),
                      ),
                      Row(
                        spacing: 20,
                        children: [
                          Expanded(
                            child: SocialLoginButton(
                              onPressed: () {},
                              text: 'Facebook',
                              iconPath: 'assets/images/facebook.png',
                            ),
                          ),
                          Expanded(
                            child: SocialLoginButton(
                              onPressed: () {},
                              text: 'Google',
                              iconPath: 'assets/images/google.png',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFFA7AFB7), fontSize: 18),
        ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppColors.grey),
            fillColor: AppColors.overlay50,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
          ),
        ),
      ],
    );
  }
}
