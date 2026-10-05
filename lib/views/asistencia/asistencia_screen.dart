import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bento_card.dart';
import '../../providers/asistencia_provider.dart';

class AsistenciaScreen extends StatelessWidget {
  const AsistenciaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final asistenciaProvider = Provider.of<AsistenciaProvider>(context);
    final empleados = asistenciaProvider.empleados;
    final currencyFormat = NumberFormat.currency(symbol: 'L. ', decimalDigits: 2);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recursos Humanos & Asistencia',
            style: theme.textTheme.displayLarge?.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Sincronización biométrica ZKAccess y registro de nómina',
            style: theme.textTheme.bodyMedium,
          ),

          const SizedBox(height: 24),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: empleados.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final emp = empleados[index];

              return BentoCard(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: AppColors.primaryBlue.withOpacity(0.15),
                      child: Text(
                        emp.nombreCompleto.substring(0, 2).toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primaryBlue),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            emp.nombreCompleto,
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${emp.puesto} • ${emp.departamento}',
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.accentCyan.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'Código ZK: ${emp.codigoAsistencia}',
                                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.accentCyan),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Identidad: ${emp.identidad}',
                                style: theme.textTheme.labelSmall?.copyWith(fontSize: 11),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          currencyFormat.format(emp.salarioBase),
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.success),
                        ),
                        Text(
                          'Salario Base',
                          style: theme.textTheme.labelSmall?.copyWith(fontSize: 10),
                        ),
                      ],
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
