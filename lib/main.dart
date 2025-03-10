import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/auth/auth_bloc.dart';
import 'config/theme/dark.dart';
import 'config/theme/light.dart';
import 'firebase_options.dart';
import 'routes.dart';
import 'services/firebase_auth_service.dart';
import 'services/firebase_messaging_service.dart';
import 'services/firestore_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firebaseAuthService = FirebaseAuthService.instance;
  final firestoreService = FirestoreService.instance;
  // final firebaseMessagingService = FirebaseMessagingService.instance;

  // await firebaseMessagingService.initializeFirebaseMessaging();

  final User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    firestoreService.setCurrentUser(currentUser);
  } else {
    print('User not set');
  }

  runApp(MyApp(
    firebaseAuthService: firebaseAuthService,
    firestoreService: firestoreService,
  ));
}

class MyApp extends StatelessWidget {
  final FirebaseAuthService firebaseAuthService;
  final FirestoreService firestoreService;

  const MyApp({
    super.key,
    required this.firebaseAuthService,
    required this.firestoreService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(firebaseAuthService),
        ),
      ],
      child: MaterialApp(
        title: 'Social Media App',
        theme: light,
        darkTheme: dark,
        themeMode: ThemeMode.system,
        initialRoute: AppRoutes.login,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
