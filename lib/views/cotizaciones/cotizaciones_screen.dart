import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bento_card.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../models/cotizacion_model.dart';
import '../../providers/cotizaciones_provider.dart';

class CotizacionesScreen extends StatefulWidget {
  const CotizacionesScreen({super.key});

  @override
  State<CotizacionesScreen> createState() => _CotizacionesScreenState();
}

class _CotizacionesScreenState extends State<CotizacionesScreen> {
  final _currencyFormat = NumberFormat.currency(symbol: 'L. ', decimalDigits: 2);

  void _showNuevaCotizacionDialog(BuildContext context) {
    final clientController = TextEditingController();
    final itemCodeController = TextEditingController(text: 'TRAM-500');
    final itemNameController = TextEditingController(text: 'Juego de Destornilladores Tramontina 12 Pzs');
    final qtyController = TextEditingController(text: '5');
    final priceController = TextEditingController(text: '650.00');

    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Nueva Cotización de Ventas', style: TextStyle(fontWeight: FontWeight.w800)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                label: 'Nombre del Cliente',
                hint: 'Ej. Ferreteria Central',
                controller: clientController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Código de Artículo',
                controller: itemCodeController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Descripción de Artículo',
                controller: itemNameController,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: 'Cantidad',
                      controller: qtyController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomTextField(
                      label: 'Precio Unitario (L.)',
                      controller: priceController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              if (clientController.text.trim().isEmpty) return;

              final qty = double.tryParse(qtyController.text) ?? 1.0;
              final price = double.tryParse(priceController.text) ?? 0.0;

              final newCot = CotizacionModel(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                numero: 'COT-2026-${(1000 + DateTime.now().second)}',
                nombreCliente: clientController.text.trim(),
                creadoPor: 'Vendedor Actual',
                creadoEn: DateTime.now(),
                items: [
                  CotizacionItemModel(
                    id: 'item-new',
                    cotizacionId: 'new',
                    itemCode: itemCodeController.text,
                    itemName: itemNameController.text,
                    cantidad: qty,
                    precioUnitario: price,
                  ),
                ],
              );

              Provider.of<CotizacionesProvider>(context, listen: false).addCotizacion(newCot);
              Navigator.pop(dialogCtx);
            },
            child: const Text('Guardar Cotización', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cotizacionesProvider = Provider.of<CotizacionesProvider>(context);
    final cotizaciones = cotizacionesProvider.cotizaciones;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cotizaciones de Ventas',
                    style: theme.textTheme.displayLarge?.copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.8,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Generación de ofertas comerciales e integración SAP Business One',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
              CustomButton(
                text: 'Nueva Cotización',
                icon: Icons.add_rounded,
                height: 44,
                onPressed: () => _showNuevaCotizacionDialog(context),
              ),
            ],
          ),

          const SizedBox(height: 24),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cotizaciones.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final item = cotizaciones[index];
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
                                color: AppColors.primaryBlue.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.receipt_rounded, color: AppColors.primaryBlue, size: 22),
                            ),
                            const SizedBox(width: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.numero,
                                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                                ),
                                Text(
                                  'Cliente: ${item.nombreCliente}',
                                  style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              _currencyFormat.format(item.total),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: AppColors.success,
                              ),
                            ),
                            Text(
                              'ISV Incluido (15%)',
                              style: theme.textTheme.labelSmall?.copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 12),

                    Text(
                      'ARTÍCULOS INCLUIDOS',
                      style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),

                    Column(
                      children: item.items.map((line) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${line.cantidad.toInt()}x  [${line.itemCode}] ${line.itemName}',
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                _currencyFormat.format(line.subtotal),
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
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
