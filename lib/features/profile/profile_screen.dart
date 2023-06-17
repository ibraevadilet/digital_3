import 'package:cached_network_image/cached_network_image.dart';
import 'package:digital_3/features/profile/widgets/profile_widget.dart';
import 'package:digital_3/helpers/app_text_styles.dart';
import 'package:digital_3/helpers/saved_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              Text(
                'Профиль',
                style: AppTextStyles.s19W600(),
              ),
              const SizedBox(height: 22),
              FutureBuilder(
                future: SavedData.getImage(),
                builder: (context, image) {
                  if (image.hasData) {
                    return kIsWeb
                        ? Image.network(image.data!)
                        : CachedNetworkImage(
                            imageUrl: image.data!,
                            placeholder: (_, url) {
                              return Container(
                                height: 100,
                                width: 100,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey.withOpacity(0.4),
                                  highlightColor: Colors.white,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              );
                            },
                            imageBuilder: (_, imageProvider) {
                              return Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      image.data!,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 12),
              FutureBuilder(
                future: SavedData.getName(),
                builder: (context, name) {
                  if (name.hasData) {
                    return Text(
                      name.data!,
                      style: AppTextStyles.s19W400(),
                    );
                  }
                  return Text(
                    '',
                    style: AppTextStyles.s19W400(),
                  );
                },
              ),
              const SizedBox(height: 5),
              FutureBuilder(
                future: SavedData.getEmail(),
                builder: (context, email) {
                  if (email.hasData) {
                    return Text(
                      email.data!,
                      style: AppTextStyles.s19W400(),
                    );
                  }
                  return Text(
                    '',
                    style: AppTextStyles.s19W400(),
                  );
                },
              ),
              const SizedBox(height: 12),
              ProfileWidget(
                title: 'Редактировать профиль',
                icon: Icons.edit,
                onTap: () {},
              ),
              ProfileWidget(
                title: 'Сменить язык',
                icon: Icons.language,
                onTap: () {},
              ),
              ProfileWidget(
                title: 'Тема',
                icon: Icons.color_lens_outlined,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
