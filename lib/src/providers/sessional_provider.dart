part of 'provider.dart';

final sessionalProvider = FutureProvider<bool>((ref) async {
  var baseUrl = ref.watch(baseUrlProvider);
  var appId = ref.watch(appIdProvider);

  if (appId == null) return false;

  var sessional = await http.get(Uri.parse('$baseUrl/$appId/get_session'));
  var body = jsonDecode(sessional.body) as Map<String, Object?>;
  var data = body['data'] as Map<String, Object?>;
  var isSessional = data['is_sessional'] as bool?;
  isSessional ??= false;

  return isSessional;
});
