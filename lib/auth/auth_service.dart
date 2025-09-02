import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  AccessCredentials? _credentials;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId: "1090643386575-j7rsh60pqtr4ufq3t2j7vi5cprqbqn83.apps.googleusercontent.com",
  scopes: ['email', 'https://www.googleapis.com/auth/calendar.readonly'],
);
  
  signInWithGoogleFirebase() async {
    // begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // finally, lets sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  

  }

  Future<String?> signInWithGoogleCloud() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null ) return null;  // User canceled sign-in

      final GoogleSignInAuthentication auth = await account.authentication;
      
      return auth.accessToken;  // ✅ Return access token for API calls
    } catch (e) {
      print("❌ Google Sign-In Error: $e");
      return null;
    }
  }

  Future<AuthClient> getAuthenticatedClient() async {
    if (_credentials == null || _credentials!.accessToken.expiry.isBefore(DateTime.now())) {
      print("🔄 Access token expired or not set. Refreshing...");
      await refreshToken();
    }

    return authenticatedClient(http.Client(), _credentials!);
  }

  Future<void> refreshToken() async {
    final clientId = ClientId(
      '1090643386575-j7rsh60pqtr4ufq3t2j7vi5cprqbqn83.apps.googleusercontent.com', 
      //'YOUR_CLIENT_SECRET', 
 );

    if (_credentials == null || _credentials!.refreshToken == null) {
      throw Exception("❌ No refresh token available. User must re-authenticate.");
    }

    _credentials = await refreshCredentials(clientId, _credentials!, http.Client());
    print("✅ Token refreshed successfully!");
  }
}
