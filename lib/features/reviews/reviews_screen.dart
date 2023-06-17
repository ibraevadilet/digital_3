import 'package:digital_3/features/reviews/components/review_card.dart';
import 'package:digital_3/features/reviews/create_review_screen.dart';
import 'package:digital_3/features/reviews/logic/cubits/fetch_reviews/fetch_reviews_cubit.dart';
import 'package:digital_3/features/reviews/review_detail_screen.dart';
import 'package:digital_3/helpers/app_colors.dart';
import 'package:digital_3/helpers/app_text_styles.dart';
import 'package:digital_3/widgets/scale_animated_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddPostPage(),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          width: MediaQuery.of(context).size.width / 1.8,
          height: 60,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Text(
            'Добавить отзыв',
            style: AppTextStyles.s16W400(color: AppColors.white),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BlocProvider(
                  create: (context) => FetchReviewsCubit()..fetchReviews(),
                  child: BlocBuilder<FetchReviewsCubit, FetchReviewsState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => SizedBox(),
                        loading: () =>
                            Center(child: CircularProgressIndicator()),
                        success: (reviews) {
                          return ListView(
                            children: [
                              ...List.generate(
                                reviews.length,
                                (index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: ScaleAnimationContainer(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => PostDetailPage(
                                            islike: false,
                                            review: reviews[index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: ReviewCart(
                                      reviewModel: reviews[index],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 70),
                            ],
                          );
                        },
                        failed: (message) => Text(message),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
