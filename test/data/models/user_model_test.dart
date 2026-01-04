import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/data/models/user_model.dart';

void main() {
  group('UserModel', () {
    test('should serialize to JSON correctly', () {
      const user = UserModel(
        id: 'user-123',
        displayName: 'John Doe',
        email: 'john@example.com',
        photoUrl: 'https://example.com/photo.jpg',
      );

      final json = user.toJson();

      expect(json['id'], 'user-123');
      expect(json['displayName'], 'John Doe');
      expect(json['email'], 'john@example.com');
      expect(json['photoUrl'], 'https://example.com/photo.jpg');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': 'user-456',
        'displayName': 'Jane Doe',
        'email': 'jane@example.com',
        'photoUrl': 'https://example.com/jane.jpg',
      };

      final user = UserModel.fromJson(json);

      expect(user.id, 'user-456');
      expect(user.displayName, 'Jane Doe');
      expect(user.email, 'jane@example.com');
      expect(user.photoUrl, 'https://example.com/jane.jpg');
    });

    test('should handle null optional fields', () {
      final json = {
        'id': 'user-789',
      };

      final user = UserModel.fromJson(json);

      expect(user.id, 'user-789');
      expect(user.displayName, isNull);
      expect(user.email, isNull);
      expect(user.photoUrl, isNull);
    });

    test('should support equality comparison', () {
      const user1 = UserModel(id: 'user-1', displayName: 'Test');
      const user2 = UserModel(id: 'user-1', displayName: 'Test');
      const user3 = UserModel(id: 'user-2', displayName: 'Test');

      expect(user1, equals(user2));
      expect(user1, isNot(equals(user3)));
    });

    test('should support copyWith', () {
      const user = UserModel(id: 'user-1', displayName: 'Original');
      final updated = user.copyWith(displayName: 'Updated');

      expect(updated.id, 'user-1');
      expect(updated.displayName, 'Updated');
    });
  });

  group('CurrentUserResponse', () {
    test('should serialize to JSON correctly', () {
      const response = CurrentUserResponse(
        user: UserModel(
          id: 'user-123',
          displayName: 'Test User',
        ),
      );

      final json = response.toJson();

      // After toJson(), nested objects are still model instances
      expect((json['user'] as dynamic).id, 'user-123');
      expect((json['user'] as dynamic).displayName, 'Test User');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'user': {
          'id': 'user-456',
          'displayName': 'Response User',
          'email': 'response@example.com',
        },
      };

      final response = CurrentUserResponse.fromJson(json);

      expect(response.user.id, 'user-456');
      expect(response.user.displayName, 'Response User');
      expect(response.user.email, 'response@example.com');
    });
  });
}
