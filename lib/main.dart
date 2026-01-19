import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'game.dart';
import 'grain.dart';

/// Singleton class to manage local storage operations for the app.
/// This provides an instance-based solution instead of using global localStorage.
class StorageManager {
  static final StorageManager _instance = StorageManager._internal();
  LocalStorage? _storage;
  
  factory StorageManager() {
    return _instance;
  }
  
  StorageManager._internal();
  
  /// Returns the LocalStorage instance.
  LocalStorage get storage {
    _storage ??= localStorage;
    return _storage!;
  }
  
  /// Initializes the local storage and loads the saved score.
  /// Returns the score value, defaulting to 0 if not found or invalid.
  Future<int> initializeScore() async {
    await initLocalStorage();
    String? item = storage.getItem('score');
    
    if (item == null) {
      // No score saved yet, initialize with 0
      storage.setItem('score', '0');
      return 0;
    } else {
      // Try to parse the saved score, handle errors gracefully
      try {
        int parsedScore = int.parse(item);
        return parsedScore;
      } catch (e) {
        // If parsing fails (invalid data), reset to 0
        debugPrint('Error parsing score from storage: $e. Resetting to 0.');
        storage.setItem('score', '0');
        return 0;
      }
    }
  }
}

/// Entry point of the Flutter application.
/// Initializes Flutter bindings and runs the app.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

/// Root widget of the application.
/// Uses FutureBuilder to asynchronously load initial data before rendering the game.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Bonfire - Chicken Game',
      // Define app theme with custom colors and styles
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xff004800),
        useMaterial3: true,
      ),
      // Use FutureBuilder to initialize score before showing the game
      home: FutureBuilder<int>(
        future: StorageManager().initializeScore(),
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
          if (snapshot.hasData) {
            score = snapshot.data!;
            scoreView.text = "Score: $score";
          }
          
          return const SimpleChickenGameWidget();
        },
      ),
    );
  }
}
