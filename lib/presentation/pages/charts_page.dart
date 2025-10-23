import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/auth_provider.dart';
import '../providers/health_entry_provider.dart';
import '../../domain/models/health_entry.dart';

class ChartsPage extends ConsumerStatefulWidget {
  const ChartsPage({super.key});

  @override
  ConsumerState<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends ConsumerState<ChartsPage> {
  int? _selectedPointIndex;
  HealthEntry? _selectedEntry;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final healthEntryState = ref.watch(
      healthEntryProvider(authState.firebaseUser?.uid ?? ''),
    );

    if (healthEntryState.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (healthEntryState.entries.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Resumen de Progreso',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bar_chart_outlined, size: 80, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No hay datos para mostrar',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Text(
                'Agrega algunos registros para ver tu progreso',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    final entries = healthEntryState.entries;
    final latestEntry = entries.first;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resumen de Progreso',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card de resumen actual
            _buildSummaryCard(latestEntry),
            const SizedBox(height: 24),

            // Gráfico interactivo principal
            _buildInteractiveChartCard(entries),
            const SizedBox(height: 24),

            // Detalles del punto seleccionado
            if (_selectedEntry != null) ...[
              _buildSelectedPointCard(_selectedEntry!),
              const SizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(HealthEntry latestEntry) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue.shade50, Colors.blue.shade100],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.blue.withOpacity(0.2), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade600,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Valores Actuales',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  _formatDate(latestEntry.fecha),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 2.2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildMetricItem(
                  'Peso',
                  '${latestEntry.peso.toStringAsFixed(1)} kg',
                  Icons.monitor_weight,
                  Colors.green,
                ),
                _buildMetricItem(
                  'IMC',
                  latestEntry.imc.toStringAsFixed(1),
                  Icons.trending_up,
                  Colors.orange,
                ),
                _buildMetricItem(
                  'Grasa Corporal',
                  '${latestEntry.grasaCorporal.toStringAsFixed(1)}%',
                  Icons.pie_chart,
                  Colors.red,
                ),
                _buildMetricItem(
                  'Masa Muscular',
                  '${latestEntry.masaMuscular.toStringAsFixed(1)} kg',
                  Icons.fitness_center,
                  Colors.purple,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveChartCard(List<HealthEntry> entries) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue.shade50, Colors.blue.shade100],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.blue.withOpacity(0.2), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Evolución General',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Toca un punto para ver detalles',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            SizedBox(height: 300, child: _buildInteractiveChart(entries)),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveChart(List<HealthEntry> entries) {
    final spots = entries.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.peso);
    }).toList();

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 1,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(color: Colors.grey.withOpacity(0.3), strokeWidth: 1);
          },
          getDrawingVerticalLine: (value) {
            return FlLine(color: Colors.grey.withOpacity(0.3), strokeWidth: 1);
          },
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()} kg',
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() < entries.length) {
                  final date = entries[value.toInt()].fecha;
                  return Text(
                    '${date.day}/${date.month}',
                    style: const TextStyle(fontSize: 10),
                  );
                }
                return const Text('');
              },
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.blue.shade600,
            barWidth: 3,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 6,
                  color: _selectedPointIndex == index
                      ? Colors.red
                      : Colors.blue.shade600,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withOpacity(0.1),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipPadding: const EdgeInsets.all(8),
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((touchedSpot) {
                final entry = entries[touchedSpot.x.toInt()];
                return LineTooltipItem(
                  'Peso: ${entry.peso.toStringAsFixed(1)} kg\n'
                  'IMC: ${entry.imc.toStringAsFixed(1)}\n'
                  'Grasa: ${entry.grasaCorporal.toStringAsFixed(1)}%',
                  const TextStyle(color: Colors.white, fontSize: 12),
                );
              }).toList();
            },
          ),
          touchCallback: (event, response) {
            if (response?.lineBarSpots != null &&
                response!.lineBarSpots!.isNotEmpty) {
              final spotIndex = response.lineBarSpots!.first.x.toInt();
              setState(() {
                _selectedPointIndex = spotIndex;
                _selectedEntry = entries[spotIndex];
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildSelectedPointCard(HealthEntry entry) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.green.shade50, Colors.green.shade100],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.green.withOpacity(0.2), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade600,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Registro del ${_formatDate(entry.fecha)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () {
                    setState(() {
                      _selectedPointIndex = null;
                      _selectedEntry = null;
                    });
                  },
                  padding: const EdgeInsets.all(4),
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 2.2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildMetricItem(
                  'Peso',
                  '${entry.peso.toStringAsFixed(1)} kg',
                  Icons.monitor_weight,
                  Colors.green,
                ),
                _buildMetricItem(
                  'IMC',
                  entry.imc.toStringAsFixed(1),
                  Icons.trending_up,
                  Colors.orange,
                ),
                _buildMetricItem(
                  'Grasa Corporal',
                  '${entry.grasaCorporal.toStringAsFixed(1)}%',
                  Icons.pie_chart,
                  Colors.red,
                ),
                _buildMetricItem(
                  'Masa Muscular',
                  '${entry.masaMuscular.toStringAsFixed(1)} kg',
                  Icons.fitness_center,
                  Colors.purple,
                ),
                _buildMetricItem(
                  'Grasa Visceral',
                  entry.grasaVisceral.toStringAsFixed(1),
                  Icons.warning,
                  Colors.amber,
                ),
              ],
            ),
          ],
        ),
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
