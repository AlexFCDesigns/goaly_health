import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../providers/health_entry_provider.dart';
import '../widgets/health_entry_card.dart';
import 'login_page.dart';
import 'add_health_entry_page.dart';
import 'charts_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final healthEntryState = ref.watch(
      healthEntryProvider(authState.firebaseUser?.uid ?? ''),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Goaly Health'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ChartsPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authProvider.notifier).signOut();
              if (context.mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Saludo personalizado
            Text(
              '¡Hola, ${authState.appUser?.name ?? 'Usuario'}!',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Información del usuario
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Información de tu cuenta:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow('Email:', authState.appUser?.email ?? ''),
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      'Miembro desde:',
                      _formatDate(authState.appUser?.fechaRegistro),
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      'Total de registros:',
                      '${healthEntryState.entries.length}',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Título de registros
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Registros de Progreso',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AddHealthEntryPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Lista de registros
            Expanded(
              child: healthEntryState.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : healthEntryState.entries.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.fitness_center_outlined,
                            size: 80,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No tienes registros aún',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Agrega tu primer registro de progreso',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: healthEntryState.entries.length,
                      itemBuilder: (context, index) {
                        final entry = healthEntryState.entries[index];
                        return HealthEntryCard(
                          entry: entry,
                          onDelete: () {
                            ref
                                .read(
                                  healthEntryProvider(
                                    authState.firebaseUser?.uid ?? '',
                                  ).notifier,
                                )
                                .deleteHealthEntry(entry.id);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddHealthEntryPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'No disponible';

    final months = [
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre',
    ];

    return '${date.day} de ${months[date.month - 1]} de ${date.year}';
  }
}
