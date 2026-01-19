import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

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
