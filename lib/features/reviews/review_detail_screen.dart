import 'package:digital_3/features/reviews/logic/model/review_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helpers/app_colors.dart';
import '../../helpers/app_text_styles.dart';

class PostDetailPage extends StatefulWidget {
  final ReviewModel review;
  final bool islike;
  const PostDetailPage({
    super.key,
    required this.islike,
    required this.review,
  });

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  late bool islike = widget.islike;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop(
                        {
                          "isLike": islike,
                        },
                      );
                    },
                    child: const Icon(
                      CupertinoIcons.chevron_left,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              backgroundColor: AppColors.white,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                      child: Image.network(
                        widget.review.image,
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 14),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Image.network(
                            widget.review.author.avatar,
                            height: 42,
                            width: 42,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          widget.review.author.name,
                          style: AppTextStyles.s16W500(),
                        ),
                        const Spacer(),
                      ],
                    ),
                    SizedBox(height: 16),
                    Divider(thickness: 2),
                    SizedBox(height: 16),
                    Text(
                      widget.review.title,
                      style: AppTextStyles.s25W700(),
                    ),
                    SizedBox(height: 16),
                    Text(
                      widget.review.text,
                      style: AppTextStyles.s18W400(),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
