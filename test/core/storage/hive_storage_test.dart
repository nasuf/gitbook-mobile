import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/core/storage/hive_storage.dart';

void main() {
  group('CacheMetadata', () {
    test('should create metadata with TTL', () {
      final metadata = CacheMetadata.withTtl(
        const Duration(hours: 1),
        etag: 'test-etag',
        version: 2,
      );

      expect(metadata.etag, 'test-etag');
      expect(metadata.version, 2);
      expect(metadata.isExpired, isFalse);
      expect(metadata.timeUntilExpiry.inMinutes, greaterThanOrEqualTo(59));
    });

    test('should detect expired cache', () {
      final metadata = CacheMetadata(
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        expiresAt: DateTime.now().subtract(const Duration(hours: 1)),
      );

      expect(metadata.isExpired, isTrue);
    });

    test('should detect non-expired cache', () {
      final metadata = CacheMetadata(
        createdAt: DateTime.now(),
        expiresAt: DateTime.now().add(const Duration(hours: 1)),
      );

      expect(metadata.isExpired, isFalse);
    });

    test('should serialize to map correctly', () {
      final now = DateTime.now();
      final expiresAt = now.add(const Duration(hours: 1));
      final metadata = CacheMetadata(
        createdAt: now,
        expiresAt: expiresAt,
        etag: 'test-etag',
        version: 3,
      );

      final map = metadata.toMap();

      expect(map['createdAt'], now.millisecondsSinceEpoch);
      expect(map['expiresAt'], expiresAt.millisecondsSinceEpoch);
      expect(map['etag'], 'test-etag');
      expect(map['version'], 3);
    });

    test('should deserialize from map correctly', () {
      final now = DateTime.now();
      final expiresAt = now.add(const Duration(hours: 1));
      final map = {
        'createdAt': now.millisecondsSinceEpoch,
        'expiresAt': expiresAt.millisecondsSinceEpoch,
        'etag': 'test-etag',
        'version': 5,
      };

      final metadata = CacheMetadata.fromMap(map);

      expect(metadata.createdAt.millisecondsSinceEpoch, now.millisecondsSinceEpoch);
      expect(metadata.expiresAt.millisecondsSinceEpoch, expiresAt.millisecondsSinceEpoch);
      expect(metadata.etag, 'test-etag');
      expect(metadata.version, 5);
    });

    test('should handle null etag in deserialization', () {
      final now = DateTime.now();
      final map = {
        'createdAt': now.millisecondsSinceEpoch,
        'expiresAt': now.add(const Duration(hours: 1)).millisecondsSinceEpoch,
      };

      final metadata = CacheMetadata.fromMap(map);

      expect(metadata.etag, isNull);
      expect(metadata.version, 1); // Default version
    });

    test('should calculate time until expiry correctly', () {
      final metadata = CacheMetadata(
        createdAt: DateTime.now(),
        expiresAt: DateTime.now().add(const Duration(minutes: 30)),
      );

      final timeUntilExpiry = metadata.timeUntilExpiry;

      expect(timeUntilExpiry.inMinutes, greaterThanOrEqualTo(29));
      expect(timeUntilExpiry.inMinutes, lessThanOrEqualTo(30));
    });

    test('should return negative time for expired cache', () {
      final metadata = CacheMetadata(
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        expiresAt: DateTime.now().subtract(const Duration(hours: 1)),
      );

      expect(metadata.timeUntilExpiry.isNegative, isTrue);
    });
  });
}
