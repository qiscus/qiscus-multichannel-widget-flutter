import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final encSharedPreferenceProvider = Provider((_) {
  return const FlutterSecureStorage();
}, name: 'encSharedPreferenceProvider');
