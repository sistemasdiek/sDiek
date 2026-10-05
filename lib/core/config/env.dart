/// App Environment Configuration
class Env {
  static const String appName = 'Diek App';
  static const String appVersion = 'v2.4.0 Multiplatform';

  // Supabase Configuration
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://ghgaegcjoqqbmgfudzlb.supabase.co',
  );

  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'sb_publishable_1DUJlBXWLjZ4kKwgGmtUyw_SdGjbi_3',
  );

  // Backend SQL Server Endpoints (Managed via API Server / Supabase Edge Functions)
  static const String sapDatabaseName = 'SBO_CORP_DIECK';
  static const String zkAccessDatabaseName = 'ZKAccess';
}
