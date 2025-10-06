import '../../domain/models/health_entry.dart';
import '../../domain/repositories/health_entry_repository.dart';
import '../services/health_entry_service.dart';

class HealthEntryRepositoryImpl implements HealthEntryRepository {
  final HealthEntryService _healthEntryService;

  HealthEntryRepositoryImpl(this._healthEntryService);

  @override
  Future<void> createHealthEntry(HealthEntry entry) async {
    await _healthEntryService.createHealthEntry(entry);
  }

  @override
  Future<List<HealthEntry>> getHealthEntriesByUser(String userId) async {
    return await _healthEntryService.getHealthEntriesByUser(userId);
  }

  @override
  Stream<List<HealthEntry>> getHealthEntriesStream(String userId) {
    return _healthEntryService.getHealthEntriesStream(userId);
  }

  @override
  Future<HealthEntry?> getHealthEntryById(String entryId) async {
    return await _healthEntryService.getHealthEntryById(entryId);
  }

  @override
  Future<void> updateHealthEntry(HealthEntry entry) async {
    await _healthEntryService.updateHealthEntry(entry);
  }

  @override
  Future<void> deleteHealthEntry(String entryId) async {
    await _healthEntryService.deleteHealthEntry(entryId);
  }

  @override
  Future<HealthEntry?> getLastHealthEntry(String userId) async {
    return await _healthEntryService.getLastHealthEntry(userId);
  }
}
