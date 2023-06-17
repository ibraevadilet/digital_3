import 'package:cached_network_image/cached_network_image.dart';
import 'package:digital_3/features/chat/logic/chat_cubit/chat_cubit.dart';
import 'package:digital_3/features/chat/logic/message_model.dart';
import 'package:digital_3/helpers/app_text_styles.dart';
import 'package:digital_3/widgets/app_indicator.dart';
import 'package:digital_3/widgets/delete_dismissible_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String userId = '21131';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.model,
  });

  final MessageModel model;

  @override
  Widget build(BuildContext context) {
    return DeleteDismissibleWidget(
      onDelete: () {
        context
            .read<ChatCubit>()
            .deleteMessage(model.chatId, model.messageId.toString());
      },
      child: Row(
        mainAxisAlignment: userId == model.userId
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(
                  left: userId == model.userId ? 20 : 0,
                  right: userId != model.userId ? 20 : 0),
              child: Column(
                crossAxisAlignment: userId == model.userId
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(
                        model.message.contains('https') ? 5 : 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: userId == model.userId
                          ? const Color(0xff0eb080)
                          : Colors.white,
                    ),
                    child: model.message.contains('https')
                        ? CachedNetworkImage(
                            imageUrl: model.message,
                            placeholder: (context, url) {
                              return const AppIndicator(
                                color: Colors.white,
                              );
                            },
                          )
                        : Text(
                            model.message,
                            style: AppTextStyles.s18W400(
                              color: userId == model.userId
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    model.date,
                    style: AppTextStyles.s11W400(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    model.userName,
                    style: AppTextStyles.s12W400(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
