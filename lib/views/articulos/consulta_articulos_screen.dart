import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bento_card.dart';
import '../../core/widgets/custom_text_field.dart';

class ConsultaArticulosScreen extends StatefulWidget {
  const ConsultaArticulosScreen({super.key});

  @override
  State<ConsultaArticulosScreen> createState() => _ConsultaArticulosScreenState();
}

class _ConsultaArticulosScreenState extends State<ConsultaArticulosScreen> {
  final _searchController = TextEditingController();
  final _currency = NumberFormat.currency(symbol: 'L. ', decimalDigits: 2);

  final List<Map<String, dynamic>> _articulos = [
    {
      'code': 'TRAM-PRO-42',
      'name': 'Juego de Herramientas Tramontina Pro 42 Pzs',
      'price': 1250.00,
      'stock': 148,
      'group': 'Tramontina',
    },
    {
      'code': 'FANAL-800-CR',
      'name': 'Cerradura de Alta Seguridad Fanal Cromada',
      'price': 480.00,
      'stock': 320,
      'group': 'Fanal',
    },
    {
      'code': 'GATO-HYD-3T',
      'name': 'Gato Hidráulico Tipo Causal 3 Toneladas',
      'price': 2100.00,
      'stock': 45,
      'group': 'Gato',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Consulta de Artículos y Precios',
            style: theme.textTheme.displayLarge?.copyWith(fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.8),
          ),
          const SizedBox(height: 4),
          Text('Búsqueda directa en catálogo SAP SBO_CORP_DIECK', style: theme.textTheme.bodyMedium),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Buscar Artículo',
            hint: 'Escribe código o descripción...',
            controller: _searchController,
            prefixIcon: Icons.search_rounded,
          ),
          const SizedBox(height: 24),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _articulos.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              final art = _articulos[index];
              return BentoCard(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.inventory_2_rounded, color: AppColors.primaryBlue, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('[${art['code']}] ${art['name']}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                          const SizedBox(height: 2),
                          Text('Línea: ${art['group']} • Stock disponible: ${art['stock']} unidades', style: theme.textTheme.bodyMedium),
                        ],
                      ),
                    ),
                    Text(_currency.format(art['price']), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: AppColors.success)),
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
