import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_to_do_list/data/firestor.dart';

abstract class AuthentificationDatasource {
  Future<void> register(String email, String password, String passwordConfirm);
  Future<void> login(
    String email,
    String password,
  );
}

class AuthentificationRemote extends AuthentificationDatasource {
  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.trim(), password: password.trim());
  }

  @override
  Future<void> register(
      String email, String password, String passwordConfirm) async {
    if (passwordConfirm == password) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email.trim(), password: password.trim()).then((value)=>{
            Firestore_Datasource().CreateUser(email)
          });
    }
  }
}
