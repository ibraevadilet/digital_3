import 'dart:io';

import 'package:digital_3/core/functions/upload_image_func.dart';
import 'package:digital_3/features/chat/logic/chat_cubit/chat_cubit.dart';
import 'package:digital_3/features/chat/logic/message_model.dart';
import 'package:digital_3/features/chat/widgets/message_widget.dart';
import 'package:digital_3/helpers/app_colors.dart';
import 'package:digital_3/helpers/date_formates.dart';
import 'package:digital_3/helpers/local_data.dart';
import 'package:digital_3/widgets/app_error_text.dart';
import 'package:digital_3/widgets/app_indicator.dart';
import 'package:digital_3/widgets/custom_app_bar.dart';
import 'package:digital_3/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.title});
  final String title;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final controller = TextEditingController();

  @override
  void initState() {
    context.read<ChatCubit>().getChats(widget.title);
    super.initState();
  }

  bool isLoadImage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorEBEBEBGrey,
      appBar: CustomAppBar(title: widget.title),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: BlocBuilder<ChatCubit, ChatState>(
                    builder: (context, state) {
                      return state.when(
                        loading: () => const AppIndicator(),
                        error: (error) => AppErrorText(error: error),
                        success: (model) => model.isEmpty
                            ? const Center(
                                child: Text(
                                  'В данном чате сообшения отсутсвуют',
                                ),
                              )
                            : ListView.separated(
                                reverse: true,
                                itemBuilder: (context, index) => MessageWidget(
                                  model: model[index],
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 12),
                                itemCount: model.length,
                              ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: controller,
                        borderColor: const Color(0xff0eb080),
                        hintText: 'Введите сообщение',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Builder(
                      builder: (context) => isLoadImage
                          ? const AppIndicator(color: Color(0xff0eb080))
                          : InkWell(
                              onTap: () async {
                                final ImagePicker picker = ImagePicker();
                                final XFile? imageFile = await picker.pickImage(
                                  source: ImageSource.gallery,
                                );
                                if (imageFile != null) {
                                  setState(
                                    () {
                                      isLoadImage = true;
                                    },
                                  );
                                  final imageUrl =
                                      await uploadImage(File(imageFile.path));
                                  final userId = await getUserId();
                                  final userName = await getUserName();

                                  final model = MessageModel(
                                    message: imageUrl,
                                    userName: userName,
                                    chatId: widget.title,
                                    messageId:
                                        DateTime.now().millisecondsSinceEpoch,
                                    userId: userId,
                                    date: dateFormatMainClock.format(
                                      DateTime.now(),
                                    ),
                                  );
                                  context.read<ChatCubit>().sendMessage(model);
                                  controller.clear();
                                  setState(
                                    () {
                                      isLoadImage = false;
                                    },
                                  );
                                }
                              },
                              child: const Icon(
                                Icons.image,
                                color: Color(0xff0eb080),
                              ),
                            ),
                    ),
                    const SizedBox(width: 10),
                    Builder(
                      builder: (context) => InkWell(
                        onTap: () async {
                          final userId = await getUserId();
                          final userName = await getUserName();

                          final model = MessageModel(
                            message: controller.text,
                            userName: userName,
                            chatId: widget.title,
                            messageId: DateTime.now().millisecondsSinceEpoch,
                            userId: userId,
                            date: dateFormatMainClock.format(
                              DateTime.now(),
                            ),
                          );
                          context.read<ChatCubit>().sendMessage(model);
                          controller.clear();
                        },
                        child: const Icon(
                          Icons.send,
                          color: Color(0xff0eb080),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
