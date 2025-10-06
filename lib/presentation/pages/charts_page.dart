import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/auth_provider.dart';
import '../providers/health_entry_provider.dart';

class ChartsPage extends ConsumerWidget {
  const ChartsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          title: const Text('Gráficos de Evolución'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
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
                'Agrega algunos registros para ver los gráficos',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráficos de Evolución'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gráfico de peso
            _buildChartCard(
              title: 'Evolución del Peso',
              child: _buildWeightChart(healthEntryState.entries),
            ),
            const SizedBox(height: 24),

            // Gráfico de IMC
            _buildChartCard(
              title: 'Evolución del IMC',
              child: _buildIMCChart(healthEntryState.entries),
            ),
            const SizedBox(height: 24),

            // Gráfico de grasa corporal
            _buildChartCard(
              title: 'Evolución de la Grasa Corporal',
              child: _buildBodyFatChart(healthEntryState.entries),
            ),
            const SizedBox(height: 24),

            // Gráfico de masa muscular
            _buildChartCard(
              title: 'Evolución de la Masa Muscular',
              child: _buildMuscleMassChart(healthEntryState.entries),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard({required String title, required Widget child}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(height: 200, child: child),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightChart(List<dynamic> entries) {
    if (entries.isEmpty) return const Center(child: Text('Sin datos'));

    final spots = entries.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.peso);
    }).toList();

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: true),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text('${value.toInt()} kg');
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() < entries.length) {
                  final date = entries[value.toInt()].fecha;
                  return Text('${date.day}/${date.month}');
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
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            dotData: const FlDotData(show: true),
          ),
        ],
      ),
    );
  }

  Widget _buildIMCChart(List<dynamic> entries) {
    if (entries.isEmpty) return const Center(child: Text('Sin datos'));

    final spots = entries.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.imc);
    }).toList();

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: true),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(value.toStringAsFixed(1));
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() < entries.length) {
                  final date = entries[value.toInt()].fecha;
                  return Text('${date.day}/${date.month}');
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
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.green,
            barWidth: 3,
            dotData: const FlDotData(show: true),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyFatChart(List<dynamic> entries) {
    if (entries.isEmpty) return const Center(child: Text('Sin datos'));

    final spots = entries.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.grasaCorporal);
    }).toList();

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: true),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text('${value.toInt()}%');
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() < entries.length) {
                  final date = entries[value.toInt()].fecha;
                  return Text('${date.day}/${date.month}');
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
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.orange,
            barWidth: 3,
            dotData: const FlDotData(show: true),
          ),
        ],
      ),
    );
  }

  Widget _buildMuscleMassChart(List<dynamic> entries) {
    if (entries.isEmpty) return const Center(child: Text('Sin datos'));

    final spots = entries.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.masaMuscular);
    }).toList();

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: true),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text('${value.toInt()} kg');
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() < entries.length) {
                  final date = entries[value.toInt()].fecha;
                  return Text('${date.day}/${date.month}');
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
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.purple,
            barWidth: 3,
            dotData: const FlDotData(show: true),
          ),
        ],
      ),
    );
  }
}
