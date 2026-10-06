import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';
import '../dashboard/dashboard_screen.dart';
import '../tutorial/tutorial_screen.dart';
import '../articulos/consulta_articulos_screen.dart';
import '../clientes/clientes_screen.dart';
import '../cobranza/cuentas_por_cobrar_screen.dart';
import '../cotizaciones/cotizaciones_screen.dart';
import '../giras/giras_screen.dart';
import '../asistencia/asistencia_screen.dart';
import '../plaza_pvr/plaza_pvr_screen.dart';
import '../assets/assets_screen.dart';
import '../usuarios/usuarios_screen.dart';
import '../auth/login_screen.dart';

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _selectedIndex = 0;

  late final List<Widget> _screens = [
    DashboardScreen(onNavigateToTab: (idx) => setState(() => _selectedIndex = idx)),
    const TutorialScreen(),
    const ConsultaArticulosScreen(),
    const ConsultaArticulosScreen(), // Catálogo de Artículos
    const ClientesScreen(),
    const CuentasPorCobrarScreen(), // Contabilidad
    const CuentasPorCobrarScreen(), // Cuentas por cobrar
    const PlazaPvrScreen(),
    const CotizacionesScreen(), // Ventas
    const GirasScreen(), // Logística
    const AsistenciaScreen(), // Recursos Humanos
    const CotizacionesScreen(), // Compras
    const AssetsScreen(), // IT
    const UsuariosScreen(), // Usuarios
  ];

  final List<Map<String, dynamic>> _navigationItems = [
    {'title': 'Inicio', 'icon': Icons.home_rounded},
    {'title': 'Tutorial', 'icon': Icons.menu_book_rounded},
    {'title': 'Consulta de Artículos y Precios', 'icon': Icons.sell_outlined},
    {'title': 'Catálogo de Artículos', 'icon': Icons.inventory_2_outlined},
    {'title': 'Clientes', 'icon': Icons.people_outline_rounded},
    {'title': 'Contabilidad', 'icon': Icons.receipt_long_outlined},
    {'title': 'Cuentas por cobrar', 'icon': Icons.attach_money_rounded},
    {'title': 'Plaza Villa Rosa', 'icon': Icons.apartment_rounded},
    {'title': 'Ventas', 'icon': Icons.shopping_cart_outlined},
    {'title': 'Logística', 'icon': Icons.local_shipping_outlined},
    {'title': 'Recursos Humanos', 'icon': Icons.badge_outlined},
    {'title': 'Compras', 'icon': Icons.shopping_bag_outlined},
    {'title': 'IT', 'icon': Icons.phone_android_rounded},
    {'title': 'Usuarios', 'icon': Icons.admin_panel_settings_outlined},
  ];

  void _showChangePasswordDialog() {
    final passController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Cambiar Contraseña', style: TextStyle(fontWeight: FontWeight.bold)),
        content: TextField(
          controller: passController,
          obscureText: true,
          decoration: const InputDecoration(hintText: 'Nueva contraseña'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Contraseña actualizada correctamente')),
              );
            },
            child: const Text('Actualizar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final authProvider = Provider.of<AuthProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userEmail = authProvider.currentUser?.email ?? 'sbh@diek.hn';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.business_rounded, color: AppColors.primaryBlue, size: 24),
            const SizedBox(width: 8),
            Text(
              'CORPORACIÓN DIEK',
              style: theme.textTheme.headlineLarge?.copyWith(fontSize: 16, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
        child: Column(
          children: [
            // Drawer Header with Corporación Diek Logo
            DrawerHeader(
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurfaceCard : AppColors.lightSurfaceCard,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.business_rounded, color: AppColors.primaryBlue, size: 32),
                      const SizedBox(width: 8),
                      Text(
                        'DIEK',
                        style: theme.textTheme.displayLarge?.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ERP Corporación Diek',
                    style: theme.textTheme.labelSmall?.copyWith(fontSize: 10, color: AppColors.accentCyan),
                  ),
                ],
              ),
            ),

            // Scrollable Menu Options matching exact screenshot list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _navigationItems.length,
                itemBuilder: (context, index) {
                  final item = _navigationItems[index];
                  final isSelected = _selectedIndex == index;

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryBlue.withOpacity(0.12) : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(
                        item['icon'],
                        color: isSelected ? AppColors.primaryBlue : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                        size: 20,
                      ),
                      title: Text(
                        item['title'],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected ? AppColors.primaryBlue : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                        ),
                      ),
                      onTap: () {
                        setState(() => _selectedIndex = index);
                        Navigator.pop(context); // Close drawer
                      },
                    ),
                  );
                },
              ),
            ),

            const Divider(),

            // Footer Matching Screenshot: Theme Switch + Email + Cambiar contraseña + Salir
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Theme Toggle Pill (Claro / Oscuro) matching screenshot
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => themeProvider.toggleTheme(false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: !isDark ? AppColors.primaryBlue : Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.wb_sunny_rounded, size: 14, color: !isDark ? Colors.white : Colors.grey),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Claro',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: !isDark ? Colors.white : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => themeProvider.toggleTheme(true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: isDark ? AppColors.primaryBlue : Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.nightlight_round, size: 14, color: isDark ? Colors.white : Colors.grey),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Oscuro',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: isDark ? Colors.white : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // User Email Label
                  Text(
                    userEmail,
                    style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 12),

                  // Cambiar contraseña button
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 38),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: _showChangePasswordDialog,
                    child: const Text('Cambiar contraseña', style: TextStyle(fontSize: 12)),
                  ),

                  const SizedBox(height: 8),

                  // Salir button
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 38),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {
                      authProvider.logout();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: const Text('Salir', style: TextStyle(fontSize: 12, color: AppColors.error)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
    );
  }
}
