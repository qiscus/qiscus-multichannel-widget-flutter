part of 'provider.dart';

@riverpod
class UploadNotifier extends _$UploadNotifier {
  @override
  Set<QUpload> build() {
    return {};
  }

  void add(File file) async {
    var qiscus = await ref.read(qiscusProvider.future);
    var roomId = await ref.read(roomIdProvider).future;

    var progress = QUpload(file, 0);
    state = {...state, progress};

    var cancelToken = CancelToken();
    progress.cancel = cancelToken.cancel;

    var stream = qiscus.upload(file, cancelToken: cancelToken);
    await for (var data in stream) {
      if (data.data != null) {
        state = state.where((v) => v != progress).toSet();
        var m = qiscus.generateFileAttachmentMessage(
          chatRoomId: roomId,
          caption: '',
          url: data.data!,
        );
        await ref.read(messagesNotifierProvider.notifier).sendMessage(m);
      } else {
        progress.progress = data.progress;
        state = {...state, progress};
      }
    }
  }

  void cancel(QUpload file) {
    state.firstWhere((v) => v == file).cancel?.call();
    state = state.where((v) => v != file).toSet();
  }
}

class QUpload {
  File file;
  double progress;
  void Function()? cancel;

  QUpload(this.file, this.progress);

  @override
  operator ==(Object other) =>
      identical(this, other) ||
      other is QUpload &&
          runtimeType == other.runtimeType &&
          file == other.file;

  @override
  int get hashCode => Object.hash(runtimeType, file);
}
