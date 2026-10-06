import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/config/env.dart';
import 'core/theme/app_theme.dart';
import 'core/services/supabase_service.dart';
import 'providers/auth_provider.dart';
import 'providers/dashboard_provider.dart';
import 'providers/cotizaciones_provider.dart';
import 'providers/giras_provider.dart';
import 'providers/asistencia_provider.dart';
import 'providers/plaza_pvr_provider.dart';
import 'providers/theme_provider.dart';
import 'views/auth/login_screen.dart';
import 'views/shell/main_navigation_shell.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase Client Connection
  await SupabaseService().initialize();

  runApp(const DiekApp());
}

class DiekApp extends StatelessWidget {
  const DiekApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => CotizacionesProvider()),
        ChangeNotifierProvider(create: (_) => GirasProvider()),
        ChangeNotifierProvider(create: (_) => AsistenciaProvider()),
        ChangeNotifierProvider(create: (_) => PlazaPvrProvider()),
      ],
      child: Consumer2<AuthProvider, ThemeProvider>(
        builder: (context, authProvider, themeProvider, _) {
          return MaterialApp(
            title: Env.appName,
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: authProvider.isAuthenticated
                ? const MainNavigationShell()
                : const LoginScreen(),
          );
        },
      ),
    );
  }
}
