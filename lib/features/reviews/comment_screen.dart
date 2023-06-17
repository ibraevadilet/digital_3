import 'package:cached_network_image/cached_network_image.dart';
import 'package:digital_3/features/reviews/logic/model/review_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../helpers/app_colors.dart';
import '../../helpers/app_text_styles.dart';
import '../../widgets/custom_text_field.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key, required this.model});
  final ReviewModel model;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController commentController = TextEditingController();
  bool isEntred() => commentController.text.isNotEmpty;

  late List<Comments> lisCommments = widget.model.comments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Comment',
          style: AppTextStyles.s15W700(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            Expanded(
              child: lisCommments.isEmpty
                  ? Center(
                      child: Text(
                        'Be the first to comment',
                        style: AppTextStyles.s19W400(
                          color: AppColors.colorEBEBEBGrey,
                        ),
                      ),
                    )
                  : ListView.separated(
                      reverse: true,
                      itemCount: lisCommments.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) => Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: CachedNetworkImageProvider(
                              lisCommments[index].author.avatar,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: AppColors.colorFED5E4LightBlue
                                      .withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lisCommments[index].author.name,
                                    style: AppTextStyles.s15W700(),
                                  ),
                                  Text(
                                    lisCommments[index].comment,
                                    style: AppTextStyles.s11W400(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            SizedBox(height: 20),
            SafeArea(
              child: CustomTextField(
                suffix: isEntred()
                    ? InkWell(
                        onTap: () async {
                          // final userId =
                          //     AuthRepository().currentUser?.uid ??
                          //         DateTime.now().toString();
                          // final userName =
                          //     AuthRepository().currentUser?.displayName ??
                          //         'Name';
                          // final userImage = AuthRepository()
                          //         .currentUser
                          //         ?.photoURL ??
                          //     'https://static.vecteezy.com/system/resources/previews/001/840/618/original/picture-profile-icon-male-icon-human-or-people-sign-and-symbol-free-vector.jpg';
                          setState(
                            () {
                              lisCommments.add(
                                Comments(
                                  author: Author(
                                    name: 'userName',
                                    id: 'userId',
                                    avatar:
                                        'https://static.vecteezy.com/system/resources/previews/001/840/618/original/picture-profile-icon-male-icon-human-or-people-sign-and-symbol-free-vector.jpg',
                                  ),
                                  comment: commentController.text,
                                ),
                              );
                              commentController.clear();
                            },
                          );
                          final ref = FirebaseDatabase.instance.ref('posts');
                          ref.child(widget.model.id!).update(
                                ReviewModel(
                                  text: widget.model.text,
                                  id: widget.model.id,
                                  author: widget.model.author,
                                  image: widget.model.image,
                                  title: widget.model.title,
                                  comments: lisCommments,
                                  isLiked: widget.model.isLiked,
                                ).toJson(),
                              );
                        },
                        child: Icon(CupertinoIcons.forward),
                      )
                    : null,
                onChanged: (value) {
                  setState(() {});
                },
                hintText: 'Your comment',
                controller: commentController,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
