import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

export 'database/database.dart';

const _kSupabaseUrl = 'https://cuznwgmxsewpmtatgfpy.supabase.co';
const _kSupabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN1em53Z214c2V3cG10YXRnZnB5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDczMDI1ODYsImV4cCI6MjAyMjg3ODU4Nn0.59U8IwWJkT7fpa_xDPTfF6BIfuY_BHyjuVBSNdYrSH4';

class SupaFlow {
  SupaFlow._();

  static SupaFlow? _instance;
  static SupaFlow get instance => _instance ??= SupaFlow._();

  final _supabase = Supabase.instance.client;
  static SupabaseClient get client => instance._supabase;

  static Future initialize() => Supabase.initialize(
        url: _kSupabaseUrl,
        anonKey: _kSupabaseAnonKey,
        debug: false,
      );
}
