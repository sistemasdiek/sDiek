import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bento_card.dart';

class UsuariosScreen extends StatelessWidget {
  const UsuariosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<Map<String, String>> usuarios = [
      {'email': 'sbh@diek.hn', 'role': 'Admin General', 'dept': 'Gerencia'},
      {'email': 'vendedor@diek.hn', 'role': 'Vendedor', 'dept': 'Ventas SPS'},
      {'email': 'logistica@diek.hn', 'role': 'Logística', 'dept': 'Almacén Central'},
      {'email': 'rrhh@diek.hn', 'role': 'Recursos Humanos', 'dept': 'RRHH'},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gestión de Usuarios',
            style: theme.textTheme.displayLarge?.copyWith(fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.8),
          ),
          const SizedBox(height: 4),
          Text('Cuentas y roles de acceso en Supabase Auth', style: theme.textTheme.bodyMedium),
          const SizedBox(height: 24),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: usuarios.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              final usr = usuarios[index];
              return BentoCard(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.primaryBlue.withOpacity(0.15),
                      child: const Icon(Icons.person_rounded, color: AppColors.primaryBlue, size: 20),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(usr['email']!, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                          Text('Rol: ${usr['role']} • ${usr['dept']}', style: theme.textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
