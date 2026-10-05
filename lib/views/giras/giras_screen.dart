import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bento_card.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../providers/giras_provider.dart';

class GirasScreen extends StatelessWidget {
  const GirasScreen({super.key});

  void _showIncidenciaDialog(BuildContext context, String giraId) {
    final driverController = TextEditingController(text: 'Juan Pérez');
    final typeController = TextEditingController(text: 'Tráfico San Pedro Sula');
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Reportar Incidencia de Gira', style: TextStyle(fontWeight: FontWeight.w800)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(label: 'Motorista', controller: driverController),
            const SizedBox(height: 14),
            CustomTextField(label: 'Tipo de Incidencia', controller: typeController),
            const SizedBox(height: 14),
            CustomTextField(label: 'Descripción del Evento', controller: descController, hint: 'Ej. Demora por tráfico en peaje'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogCtx), child: const Text('Cancelar')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.warning,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              if (descController.text.trim().isEmpty) return;
              Provider.of<GirasProvider>(context, listen: false).addIncidencia(
                giraId,
                driverController.text,
                typeController.text,
                descController.text.trim(),
              );
              Navigator.pop(dialogCtx);
            },
            child: const Text('Registrar Incidencia', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final girasProvider = Provider.of<GirasProvider>(context);
    final giras = girasProvider.giras;
    final dateFormat = DateFormat('dd/MM/yyyy • hh:mm a');

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Control de Giras & Entregas',
            style: theme.textTheme.displayLarge?.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Monitoreo de rutas de distribución, guías de remisión e incidencias',
            style: theme.textTheme.bodyMedium,
          ),

          const SizedBox(height: 24),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: giras.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final gira = giras[index];
              final isCompleted = gira.estado == 'completada';

              return BentoCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: (isCompleted ? AppColors.success : AppColors.primaryBlue).withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                isCompleted ? Icons.check_circle_rounded : Icons.local_shipping_rounded,
                                color: isCompleted ? AppColors.success : AppColors.primaryBlue,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  gira.numero,
                                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                                ),
                                Text(
                                  'Remisión: ${gira.numRemision ?? "N/A"} • Ayudante: ${gira.ayudante ?? "Sin asignar"}',
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isCompleted ? AppColors.successBg : AppColors.warningBg,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            gira.estado.toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: isCompleted ? AppColors.success : AppColors.warning,
                            ),
                          ),
                        ),
                      ],
                    ),

                    if (gira.incidencias.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 12),
                      Text('INCIDENCIAS REGISTRADAS', style: theme.textTheme.labelSmall?.copyWith(color: AppColors.warning)),
                      const SizedBox(height: 8),
                      Column(
                        children: gira.incidencias.map((inc) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.warningBg.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.warning.withOpacity(0.3)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.warning_amber_rounded, color: AppColors.warning, size: 18),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${inc.tipo} (${inc.motorista})', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                                      Text(inc.descripcion, style: const TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],

                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Iniciada: ${dateFormat.format(gira.createdAt)}', style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12)),
                        if (!isCompleted)
                          TextButton.icon(
                            onPressed: () => _showIncidenciaDialog(context, gira.id),
                            icon: const Icon(Icons.report_problem_outlined, size: 16, color: AppColors.warning),
                            label: const Text('Reportar Incidencia', style: TextStyle(color: AppColors.warning, fontWeight: FontWeight.bold, fontSize: 12)),
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
