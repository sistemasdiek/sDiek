import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/env.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;
    try {
      await Supabase.initialize(
        url: Env.supabaseUrl,
        anonKey: Env.supabaseAnonKey,
      );
      _isInitialized = true;
    } catch (e) {
      // Graceful fallback if offline or config issue
      print('Supabase initialization notice: $e');
    }
  }

  SupabaseClient get client => Supabase.instance.client;

  bool get isReady => _isInitialized;
}
