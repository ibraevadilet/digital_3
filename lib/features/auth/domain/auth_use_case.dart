import 'package:digital_3/features/auth/data/auth_repo.dart';
import 'package:digital_3/features/auth/data/user_model.dart';
import 'package:digital_3/helpers/saved_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthUseCase {
  GetAuthRepo getAuthRepo;
  AuthUseCase(this.getAuthRepo);
  Future<UserModel> setUser(GoogleSignInAuthentication googleAuth) async {
    OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    UserModel user = UserModel(
      email: userCredential.user!.email!,
      name: userCredential.user!.displayName!,
      image: userCredential.user!.photoURL!,
      uid: userCredential.user!.uid,
      date: DateTime.now().toString(),
    );

    UserModel? userFrom = await getAuthRepo.setUser(user);

    if (userFrom != null) {
      user = userFrom;
    }

    await SavedData.setUid(user.uid);
    await SavedData.setName(user.name);
    await SavedData.setEmail(user.email);
    await SavedData.setImage(user.image);

    return user;
  }
}
