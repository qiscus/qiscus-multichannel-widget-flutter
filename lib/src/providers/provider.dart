import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage_x/flutter_secure_storage_x.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart' hide QAccount;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../account.dart';
import '../config/avatar_config.dart';
import '../config/subtitle_config.dart';
import '../models.dart';
import '../states/app_state.dart';
import '../states/app_theme.dart';
import '../utils/extensions.dart';
import '../widgets/chat_buttons.dart';
import '../widgets/chat_carousel.dart';

part 'account_provider.dart';
part 'avatar_url_provider.dart';
part 'chat_bubble_color_provider.dart';
part 'initiate_chat_provider.dart';
part 'last_message_provider.dart';
part 'message_deleted_provider.dart';
part 'message_delivered_provider.dart';
part 'message_read_provider.dart';
part 'message_received_provider.dart';
part 'messages_provider.dart';
part 'multichannel_provider.dart';
part 'provider.freezed.dart';
part 'provider.g.dart';
part 'qiscus_sdk_provider.dart';
part 'room_id_provider.dart';
part 'room_provider.dart';
part 'sessional_provider.dart';
part 'shared_preference_provider.dart';
part 'states_provider.dart';
part 'uploader_provider.dart';
part 'user_presence_provider.dart';
part 'user_typing_provider.dart';
