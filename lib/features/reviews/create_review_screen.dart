import 'dart:io';
import 'package:digital_3/features/reviews/logic/cubits/create_review_cubit/create_review_cubit.dart';
import 'package:digital_3/features/reviews/logic/model/review_model.dart';
import 'package:digital_3/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../helpers/app_colors.dart';
import '../../helpers/app_text_styles.dart';
import '../../widgets/buttom_navigator.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  var postText = '';
  var title = '';
  File? imageFile;
  final picker = ImagePicker();
  var isLoading = ValueNotifier(false);
  final createCubit = CreateReviewCubit();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.colorFED5E4LightBlue,
          title: Text(
            "Добавить отзыв",
            style: AppTextStyles.s18W700(),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: imageFile == null
                        ? Column(
                            children: [
                              Spacer(),
                              SizedBox(height: 4),
                              Text(
                                "Загрузите файл сюда",
                                style: AppTextStyles.s18W400(
                                  color: AppColors.black,
                                ),
                              ),
                              SizedBox(height: 4),
                              InkWell(
                                onTap: () {
                                  _showImagePicker(context);
                                },
                                child: Text(
                                  "Загрузить",
                                  style: AppTextStyles.s18W400(
                                    color: AppColors.colorF0912FFDartBLue,
                                  ),
                                ),
                              ),
                              Spacer(),
                            ],
                          )
                        : Stack(
                            alignment: Alignment.topRight,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.file(
                                  imageFile!,
                                  fit: BoxFit.cover,
                                  height: 180,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 12, right: 12),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      imageFile = null;
                                    });
                                  },
                                  child: Icon(
                                    CupertinoIcons.delete,
                                  ),
                                ),
                              )
                            ],
                          ),
                  ),
                ),
                SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    cursorColor: AppColors.colorF0912FFDartBLue,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Заголовок',
                      hintStyle: AppTextStyles.s16W300(),
                      fillColor: AppColors.grey.withOpacity(0.6),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                          color: AppColors.white.withOpacity(0.2),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                          color: AppColors.colorF0912FFDartBLue,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                          color: AppColors.white.withOpacity(0.2),
                        ),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        title = val;
                      });
                    },
                  ),
                ),
                SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    cursorColor: AppColors.colorF0912FFDartBLue,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: 'Описание',
                      hintStyle: AppTextStyles.s16W300(),
                      fillColor: AppColors.grey.withOpacity(0.6),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                          color: AppColors.white.withOpacity(0.2),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                          color: AppColors.colorF0912FFDartBLue,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                          color: AppColors.white.withOpacity(0.2),
                        ),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        postText = val;
                      });
                    },
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: BlocProvider.value(
                    value: createCubit,
                    child: BlocListener<CreateReviewCubit, CreateReviewState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () {},
                          loading: () => isLoading.value = true,
                          success: () {
                            isLoading.value = false;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BottomNavigatorScreen(),
                              ),
                            );
                          },
                          error: (message) {
                            isLoading.value = false;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Container(
                                  alignment: Alignment.center,
                                  color: Colors.red,
                                  child: Text(message,
                                      style: AppTextStyles.s16W600()),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: ValueListenableBuilder(
                        valueListenable: isLoading,
                        builder: (context, str, _) {
                          return CustomButton(
                            text: "Создать",
                            isLoading: isLoading.value,
                            color: imageFile == null ||
                                    title.isEmpty ||
                                    postText.isEmpty
                                ? AppColors.colorF0912FFDartBLue
                                    .withOpacity(0.5)
                                : AppColors.colorF0912FFDartBLue,
                            onPressed: () async {
                              if (imageFile == null ||
                                  title.isEmpty ||
                                  postText.isEmpty) {
                                return;
                              }
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
                              await createCubit.addPost(
                                ReviewModel(
                                  isLiked: false,
                                  author: Author(
                                      name: 'name',
                                      id: 'id',
                                      avatar:
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6GDZLuzPjqjqIE4RdmcFesXIAfmXvkE7zfDzbKQRPjA&s'),
                                  title: title,
                                  image: imageFile!.path,
                                  text: postText,
                                  comments: [],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  Future<void> _showImagePicker(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(CupertinoIcons.camera),
                title: Text('Камера'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Галерея'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
