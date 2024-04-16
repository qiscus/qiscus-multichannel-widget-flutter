import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';

final repliedMessageProvider = StateProvider<QMessage?>((ref) => null);
