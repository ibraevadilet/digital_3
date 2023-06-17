import 'package:bloc/bloc.dart';
import 'package:digital_3/features/reviews/logic/local_liked_posts_repository.dart';
import 'package:digital_3/features/reviews/logic/model/review_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_reviews_cubit.freezed.dart';

class FetchReviewsCubit extends Cubit<FetchReviewsState> {
  FetchReviewsCubit() : super(FetchReviewsState.initial());

  Future<void> fetchReviews() async {
    emit(FetchReviewsState.loading());
    try {
      var reviews = await fetchFromServer('reviews');
      final likedReviews = await LocalLikedPostsRepository.getLikedPosts();

      for (var review in reviews) {
        if (likedReviews.contains(review.image)) {
          review.isLiked = true;
        } else {
          review.isLiked = false;
        }
      }
      emit(FetchReviewsState.success(reviews));
    } catch (e) {
      emit(FetchReviewsState.failed(e.toString()));
    }
  }

  Future<List<ReviewModel>> fetchFromServer(String ref) async {
    final snapshot = await FirebaseDatabase.instance.ref(ref).get();
    final informationFromServer = <ReviewModel>[];

    if (snapshot.value != null) {
      final map = snapshot.value as Map<dynamic, dynamic>;

      map.forEach((key, value) {
        value['id'] = key;
        final model = ReviewModel.fromJson(value);

        informationFromServer.add(model);
      });
    }

    return informationFromServer;
  }
}

@freezed
class FetchReviewsState with _$FetchReviewsState {
  const factory FetchReviewsState.initial() = _Initial;
  const factory FetchReviewsState.loading() = _Loading;
  const factory FetchReviewsState.success(List<ReviewModel> reviews) = _Success;
  const factory FetchReviewsState.failed(String message) = _Failed;
}
