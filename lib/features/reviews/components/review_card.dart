import 'package:digital_3/features/reviews/comment_screen.dart';
import 'package:digital_3/features/reviews/logic/model/review_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../helpers/app_colors.dart';
import '../logic/local_liked_posts_repository.dart';

class ReviewCart extends StatefulWidget {
  final ReviewModel reviewModel;

  const ReviewCart({
    super.key,
    required this.reviewModel,
  });

  @override
  State<ReviewCart> createState() => _ReviewCartState();
}

class _ReviewCartState extends State<ReviewCart> {
  late bool isLiked = widget.reviewModel.isLiked;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: Image.network(
              widget.reviewModel.image,
              fit: BoxFit.cover,
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                widget.reviewModel.author.avatar,
              ),
            ),
            title: Text(widget.reviewModel.title),
            subtitle: Text(
              widget.reviewModel.author.name,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () async {
                    setState(() {
                      isLiked = !isLiked;
                    });
                    if (isLiked) {
                      await LocalLikedPostsRepository.setLikedPost(
                        widget.reviewModel.image,
                      );
                    } else {
                      await LocalLikedPostsRepository.deleteLikedPost(
                        widget.reviewModel.image,
                      );
                    }
                  },
                  child: Icon(
                    isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                    color: isLiked ? Colors.red : null,
                  ),
                ),
                SizedBox(width: 16),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CommentScreen(
                          model: widget.reviewModel,
                        ),
                      ),
                    );
                  },
                  child: Icon(CupertinoIcons.bubble_right),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
