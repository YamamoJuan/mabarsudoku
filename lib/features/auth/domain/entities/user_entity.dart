import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String displayName,
    required String? email,
    required DateTime createdAt,
    required int gamesPlayed,
    required int wins,
    required double accuracy,
    required int highestStreak,
  }) = _UserEntity;
}
