import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/core/storage/cache_manager.dart';

void main() {
  group('CacheDuration', () {
    test('should have correct short duration', () {
      expect(CacheDuration.short, const Duration(minutes: 15));
    });

    test('should have correct medium duration', () {
      expect(CacheDuration.medium, const Duration(hours: 1));
    });

    test('should have correct long duration', () {
      expect(CacheDuration.long, const Duration(hours: 24));
    });

    test('should have correct extended duration', () {
      expect(CacheDuration.extended, const Duration(days: 7));
    });

    test('should have correct organizations duration', () {
      expect(CacheDuration.organizations, const Duration(hours: 6));
    });

    test('should have correct spaces duration', () {
      expect(CacheDuration.spaces, const Duration(hours: 1));
    });

    test('should have correct content duration', () {
      expect(CacheDuration.content, const Duration(minutes: 30));
    });

    test('should have correct documents duration', () {
      expect(CacheDuration.documents, const Duration(minutes: 30));
    });

    test('should have correct users duration', () {
      expect(CacheDuration.users, const Duration(hours: 12));
    });
  });

  group('CacheStrategy', () {
    test('should have all expected strategies', () {
      expect(CacheStrategy.values, contains(CacheStrategy.cacheFirst));
      expect(CacheStrategy.values, contains(CacheStrategy.networkFirst));
      expect(CacheStrategy.values, contains(CacheStrategy.cacheOnly));
      expect(CacheStrategy.values, contains(CacheStrategy.networkOnly));
      expect(CacheStrategy.values, contains(CacheStrategy.staleWhileRevalidate));
    });

    test('should have 5 strategies', () {
      expect(CacheStrategy.values.length, 5);
    });
  });

  group('CacheStats', () {
    test('should create cache stats correctly', () {
      final stats = CacheStats(
        organizationCount: 5,
        spaceCount: 10,
        contentCount: 50,
        recentItemCount: 20,
        pendingSyncCount: 3,
        lastSyncTime: DateTime.now(),
      );

      expect(stats.organizationCount, 5);
      expect(stats.spaceCount, 10);
      expect(stats.contentCount, 50);
      expect(stats.recentItemCount, 20);
      expect(stats.pendingSyncCount, 3);
      expect(stats.lastSyncTime, isNotNull);
    });

    test('should detect empty cache', () {
      final emptyStats = CacheStats(
        organizationCount: 0,
        spaceCount: 0,
        contentCount: 0,
        recentItemCount: 5,
        pendingSyncCount: 0,
      );

      expect(emptyStats.isEmpty, isTrue);
    });

    test('should detect non-empty cache', () {
      final nonEmptyStats = CacheStats(
        organizationCount: 1,
        spaceCount: 0,
        contentCount: 0,
        recentItemCount: 0,
        pendingSyncCount: 0,
      );

      expect(nonEmptyStats.isEmpty, isFalse);
    });

    test('should detect pending sync', () {
      final withPending = CacheStats(
        organizationCount: 0,
        spaceCount: 0,
        contentCount: 0,
        recentItemCount: 0,
        pendingSyncCount: 5,
      );

      expect(withPending.hasPendingSync, isTrue);
    });

    test('should detect no pending sync', () {
      final noPending = CacheStats(
        organizationCount: 0,
        spaceCount: 0,
        contentCount: 0,
        recentItemCount: 0,
        pendingSyncCount: 0,
      );

      expect(noPending.hasPendingSync, isFalse);
    });

    test('should handle null last sync time', () {
      final stats = CacheStats(
        organizationCount: 0,
        spaceCount: 0,
        contentCount: 0,
        recentItemCount: 0,
        pendingSyncCount: 0,
        lastSyncTime: null,
      );

      expect(stats.lastSyncTime, isNull);
    });
  });
}
