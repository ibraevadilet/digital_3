import 'package:digital_3/features/chat/chat_screen_list.dart';
import 'package:digital_3/features/info/info_screen.dart';
import 'package:digital_3/features/profile/profile_screen.dart';
import 'package:digital_3/features/reviews/presentation/pages/reviews_screen.dart';
import 'package:flutter/material.dart';

import 'package:digital_3/helpers/app_colors.dart';

class BottomNavigatorScreen extends StatefulWidget {
  const BottomNavigatorScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigatorScreen> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigatorScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.color38B6FFBLue,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 10,
        selectedFontSize: 10,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.white.withOpacity(0.5),
        currentIndex: index,
        onTap: (indexFrom) async {
          setState(() {
            index = indexFrom;
          });
        },
        items: [
          BottomNavigationBarItem(
            activeIcon: const Icon(
              Icons.sports_martial_arts_outlined,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.sports_martial_arts_outlined,
              color: Colors.white.withOpacity(
                0.5,
              ),
            ),
            label: 'Чат',
          ),
          BottomNavigationBarItem(
            activeIcon: const Icon(
              Icons.sports_score_rounded,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.sports_score_rounded,
              color: Colors.white.withOpacity(
                0.5,
              ),
            ),
            label: 'Отзывы',
          ),
          BottomNavigationBarItem(
            activeIcon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.person,
              color: Colors.white.withOpacity(
                0.5,
              ),
            ),
            label: 'Справочник',
          ),
          BottomNavigationBarItem(
            activeIcon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.person,
              color: Colors.white.withOpacity(
                0.5,
              ),
            ),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}

List<Widget> pages = [
  const ChatListScreen(),
  ReviewsScreen(),
  const InfoScreen(),
  const ProfileScreen(),
];
