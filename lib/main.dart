// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:kora_rh/utils/app_route_name.dart';
// import 'package:kora_rh/utils/app_theme.dart';
// import 'package:kora_rh/utils/generator_route.dart';
// import 'package:kora_rh/utils/langue_provider.dart';
// import 'package:kora_rh/utils/theme_provider.dart';
// import 'package:provider/provider.dart';
//
// import 'data/models/employee.dart';
// import 'viewmodels/notifications_viewmodel.dart';
//
// const _employeIdCourant = 'emp_001'; // à remplacer par l'ID réel après login
//
// // Employé par défaut utilisé tant qu'aucune connexion n'a eu lieu, pour
// // que ProfilViewModel dispose toujours d'un objet Employee valide.
// final _employeParDefaut = Employee(
//   id: _employeIdCourant,
//   nomComplet: 'Awa Traoré',
//   email: 'awa.traore@entreprise.com',
//   poste: 'Commerciale',
//   equipe: 'Équipe Abidjan',
//   manager: "Koffi N'Guessan",
//   dateEntree: DateTime(2023, 3, 3),
// );
//
// void main() {
//   runApp(const KoraApp());
// }
//
// class KoraApp extends StatefulWidget {
//   const KoraApp({super.key});
//
//   @override
//   State<KoraApp> createState() => _KoraAppState();
// }
//
// class _KoraAppState extends State<KoraApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         // ThemeProvider
//         ChangeNotifierProvider(create: (_) => ThemeProvider()),
//         ChangeNotifierProvider(create: (_) => LanguageProvider()),
//
//         ChangeNotifierProvider(create: (_) => NotificationsViewModel()),
//       ],
//       child: Consumer2<ThemeProvider, LanguageProvider>(
//         builder: (context, themeProvider, languageProvider, child) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//
//             theme: AppTheme.defaultTheme,
//             darkTheme: AppTheme.darkTheme,
//             themeMode: themeProvider.themeMode,
//
//             locale: languageProvider.locale,
//
//             supportedLocales: const [Locale('fr'), Locale('en')],
//
//             localizationsDelegates: [
//               GlobalMaterialLocalizations.delegate,
//               GlobalWidgetsLocalizations.delegate,
//               GlobalCupertinoLocalizations.delegate,
//             ],
//
//             onGenerateRoute: GeneratorRoute.onGenerate,
//             initialRoute: AppRouteName.login,
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kora_rh/data/repositories/pointage_repository.dart';
import 'package:kora_rh/utils/app_colors.dart';
import 'package:kora_rh/utils/app_route_name.dart';
import 'package:kora_rh/utils/app_text.dart';
import 'package:kora_rh/utils/app_theme.dart';
import 'package:kora_rh/utils/generator_route.dart';
import 'package:kora_rh/utils/langue_provider.dart';
import 'package:kora_rh/utils/theme_provider.dart';
import 'package:kora_rh/viewmodels/conges_viewmodel.dart';
import 'package:kora_rh/viewmodels/home_viewmodel.dart';
import 'package:kora_rh/viewmodels/notifications_viewmodel.dart';
import 'package:kora_rh/viewmodels/profil_viewmodel.dart';
import 'package:kora_rh/viewmodels/profil_viewmodel.dart';
import 'package:kora_rh/web_services/connectivity_service.dart';
import 'package:provider/provider.dart';

import 'composants/card_historique_pointage.dart';
import 'data/repositories/auth_repository.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: KoraApp(),
  ));
}


class KoraApp extends StatefulWidget {
  const KoraApp({super.key});

  @override
  State<KoraApp> createState() => _KoraAppState();
}

class _KoraAppState extends State<KoraApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ThemeProvider
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        // Provider<LocalAuthService>(create: (_) => LocalAuthService()),
        // ChangeNotifierProvider(create: (_) => SessionManagerViewModel()),
        // ChangeNotifierProvider(
        //   create: (_) => AuthentificationViewmodel(
        //     authService: AuthServiceImpl(),
        //     merchantServices: MerchantImpl(),
        //   ),
        // ),
        // ChangeNotifierProvider(create: (_) => AcceuilViewModel()),
        ChangeNotifierProvider(create: (_) => NotificationsViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => CongesViewModel()),
        ChangeNotifierProvider(create: (_) => ProfilViewModel(authRepository: null, employee: null )),
      ],
      child: Consumer2<ThemeProvider, LanguageProvider>(
        builder: (context, themeProvider, languageProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            theme: AppTheme.defaultTheme,
            // darkTheme: ThemeData(
            //   brightness: Brightness.dark,
            //   primaryColor: AppColors.indigo900,
            //   // Utilisez la même couleur primaire
            //   scaffoldBackgroundColor: AppColors.indigo900,
            //   appBarTheme: const AppBarTheme(
            //     backgroundColor: AppColors.indigo900,
            //     elevation: 0,
            //     foregroundColor: Colors.white, // Texte de l'appBar en blanc
            //     iconTheme: IconThemeData(color: Colors.white),
            //   ),
            //   cardColor: AppColors.indigo900,
            //
            //   // IMPORTANT: Copier la configuration des textes depuis AppTheme.defaultTheme
            //   textTheme: AppTheme.defaultTheme.textTheme.apply(
            //     displayColor: Colors.white,
            //     bodyColor: Colors.white,
            //   ),
            //
            //   // Ou si vous voulez personnaliser davantage :
            //   // textTheme: const TextTheme(
            //   //   displayLarge: TextStyle(...),
            //   //   displayMedium: TextStyle(...),
            //   //   // ... copier tous les styles depuis votre thème clair
            //   // ).apply(
            //   //   displayColor: Colors.white,
            //   //   bodyColor: Colors.white,
            //   // ),
            //
            //   // Configuration des couleurs de texte pour les différents composants
            //   primaryTextTheme: AppTheme.defaultTheme.primaryTextTheme.apply(
            //     displayColor: Colors.white,
            //     bodyColor: Colors.white,
            //   ),
            //
            //   // Configuration des icônes
            //   iconTheme: const IconThemeData(color: Colors.white70),
            //   primaryIconTheme: const IconThemeData(color: Colors.white),
            //
            //   // Couleurs pour les boutons, etc.
            //   buttonTheme: AppTheme.defaultTheme.buttonTheme.copyWith(
            //     colorScheme: AppTheme.defaultTheme.colorScheme.copyWith(
            //       primary: AppColors.indigo900,
            //     ),
            //   ),
            //
            //   // Couleur des indicateurs de progression, etc.
            //   colorScheme: const ColorScheme.dark(
            //     primary: AppColors.indigo900,
            //     secondary: AppColors.indigo900,
            //     surface: Color(0xFF1E1E1E),
            //     background: Color(0xFF121212),
            //     error: Colors.redAccent,
            //     onPrimary: Colors.white,
            //     onSecondary: Colors.white,
            //     onSurface: Colors.white,
            //     onBackground: Colors.white,
            //     onError: Colors.white,
            //   ),
            //
            //   // Autres configurations pour garder la cohérence
            //   dividerColor: Colors.grey[800],
            //   disabledColor: Colors.grey[600],
            //   hintColor: Colors.grey[500],
            //   focusColor: AppColors.indigo900.withOpacity(0.12),
            //   hoverColor: AppColors.indigo900.withOpacity(0.04),
            //   highlightColor: AppColors.indigo900.withOpacity(0.12),
            //   splashColor: AppColors.indigo900.withOpacity(0.08),
            //
            //   // Garder les mêmes configurations de carte
            //   // cardTheme: AppTheme.defaultTheme.cardTheme.copyWith(
            //   //   color: const Color(0xFF1E1E1E),
            //   // ),
            //
            //   // Garder les mêmes configurations de liste
            //   listTileTheme: AppTheme.defaultTheme.listTileTheme.copyWith(
            //     textColor: Colors.white,
            //     iconColor: Colors.white70,
            //   ),
            //
            //   // Configuration des switchs
            //   switchTheme: SwitchThemeData(
            //     thumbColor: MaterialStateProperty.resolveWith((states) {
            //       if (states.contains(MaterialState.selected)) {
            //         return AppColors.indigo900;
            //       }
            //       return Colors.grey[400];
            //     }),
            //     trackColor: MaterialStateProperty.resolveWith((states) {
            //       if (states.contains(MaterialState.selected)) {
            //         return AppColors.indigo900.withOpacity(0.5);
            //       }
            //       return Colors.grey[800];
            //     }),
            //   ),
            //
            //   // Configuration des radio buttons
            //   radioTheme: RadioThemeData(
            //     fillColor: MaterialStateProperty.resolveWith((states) {
            //       if (states.contains(MaterialState.selected)) {
            //         return AppColors.indigo900;
            //       }
            //       return Colors.grey[600];
            //     }),
            //   ),
            //
            //   // Configuration des checkboxes
            //   checkboxTheme: CheckboxThemeData(
            //     fillColor: MaterialStateProperty.resolveWith((states) {
            //       if (states.contains(MaterialState.selected)) {
            //         return AppColors.indigo900;
            //       }
            //       return Colors.grey[600];
            //     }),
            //   ),
            //
            //   // Configuration des dialogues
            // ),
            themeMode: themeProvider.themeMode,

            locale: languageProvider.locale,

            supportedLocales: const [Locale('fr'), Locale('en')],

            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            onGenerateRoute: GeneratorRoute.onGenerate,
            initialRoute: AppRouteName.login,
          );
        },
      ),
    );
  }

}


// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Geolocator Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
//         useMaterial3: true,
//       ),
//       home: const LocationDemoPage(),
//     );
//   }
// }
//
// class LocationDemoPage extends StatefulWidget {
//   const LocationDemoPage({super.key});
//
//   @override
//   State<LocationDemoPage> createState() => _LocationDemoPageState();
// }
//
// class _LocationDemoPageState extends State<LocationDemoPage> {
//   String _statusMessage = 'Aucune position récupérée pour le moment.';
//   Position? _currentPosition;
//   StreamSubscription<Position>? _positionStreamSub;
//   bool _isTracking = false;
//   final List<Position> _trackedPositions = [];
//
//   @override
//   void dispose() {
//     _positionStreamSub?.cancel();
//     super.dispose();
//   }
//
//   /// Vérifie que le service de localisation est actif et que les
//   /// permissions sont accordées. Retourne true si tout est OK.
//   Future<bool> _ensurePermissions() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       setState(() {
//         _statusMessage =
//         'Le service de localisation est désactivé sur cet appareil.';
//       });
//       return false;
//     }
//
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         setState(() {
//           _statusMessage = 'Permission de localisation refusée.';
//         });
//         return false;
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       setState(() {
//         _statusMessage =
//         'Permission refusée définitivement. Ouvre les réglages système '
//             'pour l\'autoriser manuellement.';
//       });
//       return false;
//     }
//
//     return true;
//   }
//
//   /// 1) Récupère une position instantanée (snapshot ponctuel).
//   Future<void> _getCurrentLocation() async {
//     setState(() => _statusMessage = 'Récupération de la position...');
//
//     final ok = await _ensurePermissions();
//     if (!ok) return;
//
//     try {
//       final position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       setState(() {
//         _currentPosition = position;
//         _statusMessage = 'Position récupérée avec succès.';
//       });
//     } catch (e) {
//       setState(() => _statusMessage = 'Erreur : $e');
//     }
//   }
//
//   /// 2) Démarre/arrête un flux de positions en temps réel.
//   Future<void> _toggleTracking() async {
//     if (_isTracking) {
//       await _positionStreamSub?.cancel();
//       setState(() => _isTracking = false);
//       return;
//     }
//
//     final ok = await _ensurePermissions();
//     if (!ok) return;
//
//     setState(() {
//       _isTracking = true;
//       _trackedPositions.clear();
//     });
//
//     const locationSettings = LocationSettings(
//       accuracy: LocationAccuracy.high,
//       distanceFilter: 10, // ne notifie qu'après 10 m de déplacement
//     );
//
//     _positionStreamSub =
//         Geolocator.getPositionStream(locationSettings: locationSettings)
//             .listen((Position position) {
//           setState(() {
//             _currentPosition = position;
//             _trackedPositions.add(position);
//             _statusMessage =
//             '${_trackedPositions.length} mise(s) à jour reçue(s).';
//           });
//         }, onError: (e) {
//           setState(() {
//             _statusMessage = 'Erreur du flux : $e';
//             _isTracking = false;
//           });
//         });
//   }
//
//   /// 3) Calcule la distance entre la position actuelle et un point fixe
//   /// (ici Abidjan, à titre d'exemple).
//   double? _distanceToAbidjan() {
//     if (_currentPosition == null) return null;
//     const abidjanLat = 5.3600;
//     const abidjanLng = -4.0083;
//     return Geolocator.distanceBetween(
//       _currentPosition!.latitude,
//       _currentPosition!.longitude,
//       abidjanLat,
//       abidjanLng,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final distance = _distanceToAbidjan();
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Test Geolocator')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: ListView(
//           children: [
//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(_statusMessage,
//                         style: Theme.of(context).textTheme.bodyMedium),
//                     const SizedBox(height: 12),
//                     if (_currentPosition != null) ...[
//                       Text('Latitude : ${_currentPosition!.latitude}'),
//                       Text('Longitude : ${_currentPosition!.longitude}'),
//                       Text(
//                           'Précision : ${_currentPosition!.accuracy.toStringAsFixed(1)} m'),
//                       if (distance != null)
//                         Text(
//                             'Distance jusqu\'à Abidjan : ${(distance / 1000).toStringAsFixed(1)} km'),
//                     ],
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton.icon(
//               onPressed: _getCurrentLocation,
//               icon: const Icon(Icons.my_location),
//               label: const Text('Obtenir la position actuelle'),
//             ),
//             const SizedBox(height: 12),
//             ElevatedButton.icon(
//               onPressed: _toggleTracking,
//               icon: Icon(_isTracking ? Icons.stop : Icons.play_arrow),
//               label: Text(_isTracking
//                   ? 'Arrêter le suivi en temps réel'
//                   : 'Démarrer le suivi en temps réel'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: _isTracking ? Colors.red : null,
//               ),
//             ),
//             const SizedBox(height: 20),
//             if (_trackedPositions.isNotEmpty) ...[
//               Text('Historique du suivi (${_trackedPositions.length}) :',
//                   style: Theme.of(context).textTheme.titleMedium),
//               const SizedBox(height: 8),
//               ...List.generate(_trackedPositions.length, (i) {
//                 final p = _trackedPositions[i];
//                 return Text(
//                     '#${i + 1}: ${p.latitude.toStringAsFixed(5)}, ${p.longitude.toStringAsFixed(5)}');
//               }),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }