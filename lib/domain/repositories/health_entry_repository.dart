import '../models/health_entry.dart';

abstract class HealthEntryRepository {
  Future<void> createHealthEntry(HealthEntry entry);
  Future<List<HealthEntry>> getHealthEntriesByUser(String userId);
  Stream<List<HealthEntry>> getHealthEntriesStream(String userId);
  Future<HealthEntry?> getHealthEntryById(String entryId);
  Future<void> updateHealthEntry(HealthEntry entry);
  Future<void> deleteHealthEntry(String entryId);
  Future<HealthEntry?> getLastHealthEntry(String userId);
}
