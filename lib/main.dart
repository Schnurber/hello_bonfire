import 'package:flutter/material.dart';
import 'game.dart';
import 'grain.dart';
import 'storage_manager.dart';

/// Background color used throughout the game
const Color kGameBackgroundColor = Color(0xff004800);

/// Entry point of the Flutter application.
/// Initializes Flutter bindings and runs the app.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

/// Root widget of the application.
/// Uses FutureBuilder to asynchronously load initial data before rendering the game.
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Store the future to prevent recreation on every rebuild
  late final Future<int> _initializeFuture;
  bool _scoreInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeFuture = StorageManager().initializeScore();
  }
  
  /// Initialize the score once when data becomes available
  void _initializeScore(int scoreValue) {
    if (!_scoreInitialized) {
      score = scoreValue;
      scoreView.text = "Score: $score";
      _scoreInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Bonfire - Chicken Game',
      // Define app theme with custom colors and styles
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.light,
        scaffoldBackgroundColor: kGameBackgroundColor,
        useMaterial3: true,
      ),
      // Use FutureBuilder to initialize score before showing the game
      home: FutureBuilder<int>(
        future: _initializeFuture,
        builder: (context, snapshot) {
          // Show loading indicator while initializing
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          
          // Handle errors during initialization
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Error initializing app: ${snapshot.error}'),
              ),
            );
          }
          
          // Data loaded successfully, set the score and show the game
          // Use fallback to 0 if data is somehow missing
          _initializeScore(snapshot.data ?? 0);
          
          return const SimpleChickenGameWidget();
        },
      ),
    );
  }
}
