import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart' hide QAccount;
import 'package:qiscus_multichannel_widget/src/utils/extensions.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../account.dart';
import '../config/avatar_config.dart';
import '../config/subtitle_config.dart';
import '../models.dart';
import '../multichannel_provider.dart';
import '../states/app_state.dart';
import '../states/app_theme.dart';
import '../widgets/chat_buttons.dart';
import '../widgets/chat_carousel.dart';

part 'provider.g.dart';
part 'provider.freezed.dart';

part 'account_provider.dart';
part 'states_provider.dart';
part 'avatar_url_provider.dart';
part 'chat_bubble_color_provider.dart';
part 'initiate_chat_provider.dart';
part 'last_message_provider.dart';
part 'message_deleted_provider.dart';
part 'message_delivered_provider.dart';
part 'message_read_provider.dart';
part 'message_received_provider.dart';
part 'messages_provider.dart';
part 'qiscus_sdk_provider.dart';
part 'room_id_provider.dart';
part 'room_provider.dart';
part 'sessional_provider.dart';
part 'shared_preference_provider.dart';
part 'uploader_provider.dart';
part 'user_presence_provider.dart';
part 'user_typing_provider.dart';
