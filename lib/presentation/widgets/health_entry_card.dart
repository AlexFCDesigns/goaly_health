import 'package:flutter/material.dart';
import '../../domain/models/health_entry.dart';

class HealthEntryCard extends StatelessWidget {
  final HealthEntry entry;
  final VoidCallback? onDelete;

  const HealthEntryCard({super.key, required this.entry, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fecha
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDate(entry.fecha),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: onDelete,
                  ),
              ],
            ),
            const SizedBox(height: 12),

            // Métricas en grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 2.5,
              children: [
                _buildMetricItem('Peso', '${entry.peso.toStringAsFixed(1)} kg'),
                _buildMetricItem('IMC', entry.imc.toStringAsFixed(1)),
                _buildMetricItem(
                  'Grasa Corporal',
                  '${entry.grasaCorporal.toStringAsFixed(1)}%',
                ),
                _buildMetricItem(
                  'Masa Muscular',
                  '${entry.masaMuscular.toStringAsFixed(1)} kg',
                ),
                _buildMetricItem(
                  'Grasa Visceral',
                  entry.grasaVisceral.toStringAsFixed(1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Ene',
      'Feb',
      'Mar',
      'Abr',
      'May',
      'Jun',
      'Jul',
      'Ago',
      'Sep',
      'Oct',
      'Nov',
      'Dic',
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
