import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bento_card.dart';
import '../../providers/auth_provider.dart';

class DashboardScreen extends StatelessWidget {
  final Function(int)? onNavigateToTab;

  const DashboardScreen({super.key, this.onNavigateToTab});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final authProvider = Provider.of<AuthProvider>(context);
    final userEmail = authProvider.currentUser?.email ?? 'sbh@diek.hn';

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),

          // Corporación Diek Hero Logo Branding
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurfaceCard : Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryBlue.withOpacity(0.2),
                  blurRadius: 30,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.business_rounded,
                  size: 48,
                  color: AppColors.primaryBlue,
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.apartment_rounded,
                  size: 40,
                  color: AppColors.warning,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Text(
            'Bienvenido a Diek App',
            style: theme.textTheme.displayLarge?.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            userEmail,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 48),

          // 4 Quick Feature Cards Grid matching screenshot
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 700;
              return GridView.count(
                crossAxisCount: isWide ? 2 : 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: isWide ? 2.8 : 2.5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildQuickCard(
                    context,
                    title: 'Pedidos',
                    subtitle: 'Pedidos, facturas y notas de crédito',
                    icon: Icons.receipt_long_rounded,
                    iconColor: AppColors.primaryBlue,
                    onTap: () => onNavigateToTab?.call(7), // Ventas
                  ),
                  _buildQuickCard(
                    context,
                    title: 'Cuentas por cobrar',
                    subtitle: 'Mora, saldos vencidos y cobranza',
                    icon: Icons.account_balance_wallet_rounded,
                    iconColor: AppColors.warning,
                    onTap: () => onNavigateToTab?.call(5), // Cuentas por cobrar
                  ),
                  _buildQuickCard(
                    context,
                    title: 'Inventarios',
                    subtitle: 'Existencia, ficha de artículo y reporte',
                    icon: Icons.inventory_2_rounded,
                    iconColor: AppColors.success,
                    onTap: () => onNavigateToTab?.call(1), // Consulta de artículos
                  ),
                  _buildQuickCard(
                    context,
                    title: 'Usuarios',
                    subtitle: 'Cuentas y roles de acceso',
                    icon: Icons.people_alt_rounded,
                    iconColor: AppColors.accentIndigo,
                    onTap: () => onNavigateToTab?.call(12), // Usuarios
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);

    return BentoCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 13,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
