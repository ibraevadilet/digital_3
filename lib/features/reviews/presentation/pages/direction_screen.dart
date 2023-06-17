import 'package:digital_3/features/reviews/data/models/review_model.dart';
import 'package:digital_3/features/reviews/presentation/pages/detail_direction_screen.dart';
import 'package:digital_3/helpers/app_text_styles.dart';
import 'package:flutter/material.dart';

class DirectionScreen extends StatelessWidget {
  const DirectionScreen({super.key, required this.data});
  final ReviewModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          elevation: 0,
          title: Text(
            data.title,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.separated(
                      itemBuilder: (context, i) => InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DetailDirectionScreen(
                                          data: data.direction[i].items,
                                        ))),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.black),
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    data.direction[i].title,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.book,
                                        size: 16,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Инструкция',
                                        style: AppTextStyles.s16W600(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    data.direction[i].instructions,
                                    style: AppTextStyles.s15W400(
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  )
                                ],
                              ),
                            ),
                          ),
                      separatorBuilder: (context, i) => const SizedBox(
                            height: 16,
                          ),
                      itemCount: data.direction.length),
                ),
              )
            ],
          ),
        ));
  }
}
