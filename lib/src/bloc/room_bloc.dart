import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "room_bloc.freezed.dart";

@freezed
class RoomState with _$RoomState {
  const factory RoomState.initial() = _StateInitial;
}

class RoomBloc extends Cubit<RoomState> {
  RoomBloc([RoomState initialState = const RoomState.initial()])
      : super(initialState);
}
