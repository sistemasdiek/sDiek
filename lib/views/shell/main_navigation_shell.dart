import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../dashboard/dashboard_screen.dart';
import '../cotizaciones/cotizaciones_screen.dart';
import '../giras/giras_screen.dart';
import '../asistencia/asistencia_screen.dart';
import '../plaza_pvr/plaza_pvr_screen.dart';
import '../assets/assets_screen.dart';
import '../auth/login_screen.dart';

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    CotizacionesScreen(),
    GirasScreen(),
    AsistenciaScreen(),
    PlazaPvrScreen(),
    AssetsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        elevation: 0,
        scaffoldLineWidth: 1,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.grid_view_rounded, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Diek App',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  'CORP DIECK • MULTIPLATFORM',
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontSize: 9,
                    letterSpacing: 1.2,
                    color: AppColors.accentCyan,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // Status Pill Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.successBg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.success.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'Online',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.success),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Role Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2)),
            ),
            child: Text(
              user?.roleName?.toUpperCase() ?? 'ADMIN',
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primaryBlue),
            ),
          ),
          const SizedBox(width: 12),

          IconButton(
            icon: const Icon(Icons.logout_rounded, size: 20),
            tooltip: 'Cerrar sesión',
            onPressed: () {
              authProvider.logout();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (idx) => setState(() => _selectedIndex = idx),
        backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        indicatorColor: AppColors.primaryBlue.withOpacity(0.2),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard_rounded, color: AppColors.primaryBlue),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long_rounded, color: AppColors.primaryBlue),
            label: 'Cotizaciones',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_shipping_outlined),
            selectedIcon: Icon(Icons.local_shipping_rounded, color: AppColors.primaryBlue),
            label: 'Giras',
          ),
          NavigationDestination(
            icon: Icon(Icons.badge_outlined),
            selectedIcon: Icon(Icons.badge_rounded, color: AppColors.primaryBlue),
            label: 'Asistencia',
          ),
          NavigationDestination(
            icon: Icon(Icons.storefront_outlined),
            selectedIcon: Icon(Icons.storefront_rounded, color: AppColors.primaryBlue),
            label: 'Plaza PVR',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2_rounded, color: AppColors.primaryBlue),
            label: 'Activos',
          ),
        ],
      ),
    );
  }
}
