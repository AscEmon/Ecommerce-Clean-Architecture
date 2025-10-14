import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerce/core/presentation/view_util.dart';
import 'package:ecommerce/core/presentation/widgets/global_text.dart';

import 'package:ecommerce/core/theme/app_colors.dart';
import 'package:ecommerce/features/auth/presentation/providers/login_provider.dart';

import '../../../../core/presentation/widgets/global_button.dart';
import '../../../../core/presentation/widgets/global_text_form_field.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/routes/navigation.dart';
import '../../../../core/utils/validators.dart';
import '../providers/state/login_state.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Text editing controllers
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // Always dispose controllers to prevent memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Handle form submission
  void _handleLogin() {
    // Validate form using Form's validator
    if (_formKey.currentState?.validate() ?? false) {
      // Trigger login with controller values
      final notifier = ref.read(loginProvider.notifier);
      notifier.loginWithCredentials(
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  void _clearTextEditingControllers() {
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginProvider);

    // Listen to login state changes
    ref.listen<LoginState>(loginProvider, (previous, next) {
      if (next.isSuccess) {
        ViewUtil.snackbar('Login Successful!');
        // Clear controllers on success
        _clearTextEditingControllers();
        // Reset provider state
        ref.read(loginProvider.notifier).reset();
        // Navigate to home
        Navigation.pushAndRemoveUntil(
          context,
          appRoutes: AppRoutes.mainContainer,
        );
      } else if (next.error != null) {
        ViewUtil.snackbar(next.error!);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.scaffold.color,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlobalText(
                str: 'TR-Store',
                fontSize: 24,
                color: AppColors.primary.color,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 40),

              // Email field with Form validation
              GlobalTextFormField(
                controller: _emailController,
                hintText: 'Username',
                textInputType: TextInputType.text,
                validator: Validators.combine([Validators.required]),
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: 16),

              // Password field with Form validation
              GlobalTextFormField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
                validator: Validators.password,
                textInputAction: TextInputAction.done,
              ),

              const SizedBox(height: 24),

              // Login button
              GlobalButton(
                btnHeight: 52.h,
                roundedBorderRadius: 10,
                onPressed: state.isLoading ? null : _handleLogin,
                buttonText: state.isLoading ? 'Loading...' : 'Login',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
