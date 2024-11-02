import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rating_state.g.dart';

@riverpod
class RatingState extends _$RatingState {
  @override
  double build() => 5.0; // Default rating

  void updateRating(double rating) {
    state = rating;
  }
}
