import 'package:digital_3/features/chat/chat_screen.dart';
import 'package:digital_3/helpers/app_colors.dart';
import 'package:digital_3/helpers/app_text_styles.dart';
import 'package:flutter/material.dart';

List<String> chats = [
  'Образование',
  'Медицина',
  'ГРС',
];

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Text(
              'Чат сообщество',
              style: AppTextStyles.s19W600(),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          title: chats[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 22,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.color38B6FFBLue,
                    ),
                    child: Text(
                      chats[index],
                      style: AppTextStyles.s16W400(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemCount: chats.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
