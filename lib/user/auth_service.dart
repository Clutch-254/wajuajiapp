import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Helper: Store user info in Firestore
  Future<void> _storeUserData(User user, String username, {String? bio}) async {
    final userDoc = _firestore.collection('users').doc(user.uid);
    final userData = {
      'uid': user.uid,
      'email': user.email,
      'username': username,
      'bio': bio ?? 'This is a short bio about the user.',
      'subscriberCount': 0,
      'collaboratorCount': 0,
      'createdAt': FieldValue.serverTimestamp(),
    };

    // Only set if document doesn't already exist
    final doc = await userDoc.get();
    if (!doc.exists) {
      await userDoc.set(userData);
    }
  }

  // Sign up with email and password
  Future<String?> signUp(
    String email,
    String password,
    String username,
    String bio,
  ) async {
    try {
      final UserCredential userCred = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _storeUserData(userCred.user!, username, bio: bio);
      await userCred.user!.updateDisplayName(username);

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Log in with email and password
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Google Sign-In
  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return 'Cancelled by user';

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCred = await _auth.signInWithCredential(credential);
      await _storeUserData(userCred.user!, googleUser.displayName ?? '');

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }

  // Auth state stream
  Stream<User?> get userChanges => _auth.authStateChanges();
}
