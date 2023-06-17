import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../model/review_model.dart';
part 'create_review_state.dart';
part 'create_review_cubit.freezed.dart';

class CreateReviewCubit extends Cubit<CreateReviewState> {
  CreateReviewCubit() : super(const CreateReviewState.initial());

  final postsDataBase = FirebaseDatabase.instance.ref('reviews');

  Future<void> addPost(ReviewModel postModel) async {
    emit(const CreateReviewState.loading());

    try {
      String url = await uploadImage(File(postModel.image));
      postModel.image = url;
      await postsDataBase.push().set(postModel.toJson());
      emit(const CreateReviewState.success());
    } catch (e) {
      emit(CreateReviewState.error(e.toString()));
      throw Exception(e);
    }
  }

  Future<String> uploadImage(File file) async {
    final metadata = SettableMetadata(contentType: 'image/jpeg');
    final storageRef = FirebaseStorage.instance.ref();

    Reference ref = storageRef
        .child('pictures/${DateTime.now().microsecondsSinceEpoch}.jpg');
    final uploadTask = ref.putFile(file, metadata);
    final taskSnapshot = await uploadTask.whenComplete(() => null);

    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }
}
