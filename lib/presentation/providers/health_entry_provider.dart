import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/health_entry.dart';
import '../../domain/repositories/health_entry_repository.dart';
import 'service_providers.dart';

part 'health_entry_provider.freezed.dart';

// Estado de los registros de salud
@freezed
class HealthEntryState with _$HealthEntryState {
  const factory HealthEntryState({
    @Default(false) bool isLoading,
    @Default([]) List<HealthEntry> entries,
    String? error,
  }) = _HealthEntryState;
}

// Provider del estado de registros de salud
final healthEntryProvider =
    StateNotifierProvider.family<HealthEntryNotifier, HealthEntryState, String>(
      (ref, userId) {
        final healthEntryRepository = ref.watch(healthEntryRepositoryProvider);
        return HealthEntryNotifier(healthEntryRepository, userId);
      },
    );

class HealthEntryNotifier extends StateNotifier<HealthEntryState> {
  final HealthEntryRepository _healthEntryRepository;
  final String _userId;

  HealthEntryNotifier(this._healthEntryRepository, this._userId)
    : super(const HealthEntryState()) {
    _init();
  }

  void _init() {
    // Escuchar cambios en los registros de salud
    _healthEntryRepository.getHealthEntriesStream(_userId).listen((entries) {
      state = state.copyWith(entries: entries, isLoading: false, error: null);
    });
  }

  // Crear nuevo registro de salud
  Future<void> createHealthEntry(HealthEntry entry) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _healthEntryRepository.createHealthEntry(entry);
      // El stream se encargará de actualizar la lista
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Actualizar registro de salud
  Future<void> updateHealthEntry(HealthEntry entry) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _healthEntryRepository.updateHealthEntry(entry);
      // El stream se encargará de actualizar la lista
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Eliminar registro de salud
  Future<void> deleteHealthEntry(String entryId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _healthEntryRepository.deleteHealthEntry(entryId);
      // El stream se encargará de actualizar la lista
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Obtener último registro
  Future<HealthEntry?> getLastHealthEntry() async {
    try {
      return await _healthEntryRepository.getLastHealthEntry(_userId);
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return null;
    }
  }

  // Limpiar error
  void clearError() {
    state = state.copyWith(error: null);
  }
}
