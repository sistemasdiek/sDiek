import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../providers/auth_provider.dart';
import '../shell/main_navigation_shell.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(text: 'admin@corpdieck.com');
  final _passwordController = TextEditingController(text: 'AdminDiek2026!');
  final _formKey = GlobalKey<FormState>();

  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.login(
      _emailController.text,
      _passwordController.text,
    );

    if (success && mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const MainNavigationShell(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background ambient gradient glows
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryBlue.withOpacity(0.25),
                blurRadius: 120,
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 380,
              height: 380,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentCyan.withOpacity(0.20),
                blurRadius: 140,
              ),
            ),
          ),

          // Main Center Glass Container
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Container(
                maxWidth: 440,
                child: GlassCard(
                  padding: const EdgeInsets.all(36),
                  borderRadius: 28,
                  blurAmount: 16.0,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // App Logo Branding
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: AppColors.primaryGradient,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryBlue.withOpacity(0.4),
                                    blurRadius: 16,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.grid_view_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Diek App',
                                  style: theme.textTheme.displayLarge?.copyWith(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.8,
                                  ),
                                ),
                                Text(
                                  'CORP DIECK ENTERPRISE',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    fontSize: 10,
                                    letterSpacing: 1.4,
                                    color: AppColors.accentCyan,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // Subtitle text
                        Text(
                          'Inicia sesión para continuar',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.4,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Acceso multiplataforma unificado a logística, ventas y nómina',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Input fields
                        CustomTextField(
                          label: 'Correo',
                          hint: 'ejemplo@corpdieck.com',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icons.email_outlined,
                          validator: (val) {
                            if (val == null || val.isEmpty) return 'Ingrese su correo corporativo';
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        CustomTextField(
                          label: 'Contraseña',
                          hint: '••••••••••••',
                          controller: _passwordController,
                          isPassword: true,
                          prefixIcon: Icons.lock_outline,
                          validator: (val) {
                            if (val == null || val.isEmpty) return 'Ingrese su contraseña';
                            return null;
                          },
                        ),

                        if (authProvider.errorMessage != null) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.errorBg,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.error.withOpacity(0.3)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.error_outline, color: AppColors.error, size: 18),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    authProvider.errorMessage!,
                                    style: const TextStyle(
                                      color: AppColors.error,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        const SizedBox(height: 32),

                        // Submit Button
                        CustomButton(
                          text: 'Entrar',
                          icon: Icons.login_rounded,
                          isLoading: authProvider.isLoading,
                          onPressed: _handleLogin,
                        ),

                        const SizedBox(height: 24),

                        // Footer tag
                        Center(
                          child: Text(
                            'SBO_CORP_DIECK • Multiplatform v2.4',
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontSize: 11,
                              color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
