part of 'create_review_cubit.dart';

@freezed
class CreateReviewState with _$CreateReviewState {
  const factory CreateReviewState.initial() = _Initial;
  const factory CreateReviewState.loading() = _Loading;
  const factory CreateReviewState.success() = _Success;
  const factory CreateReviewState.error(String error) = _Error;

  const CreateReviewState._();
}
