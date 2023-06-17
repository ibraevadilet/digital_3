import 'package:digital_3/features/profile/widgets/profile_widget.dart';
import 'package:digital_3/helpers/app_text_styles.dart';
import 'package:flutter/material.dart';

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
              CircleAvatar(
                radius: 50,
                child: Text(
                  'AI',
                  style: AppTextStyles.s28W600(color: Colors.white),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Adilet Ibraev',
                style: AppTextStyles.s19W700(),
              ),
              const SizedBox(height: 12),
              Text(
                '+996 554 160 500',
                style: AppTextStyles.s19W400(),
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
