import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../qiscus_multichannel_widget.dart';
import 'bloc/app_bloc.dart';
import 'states/app_state.dart';

class QMultichannelProvider extends StatelessWidget {
  const QMultichannelProvider({
    Key? key,
    required this.builder,
    // required this.child,
    required this.instance,
  }) : super(key: key);

  final Widget Function(BuildContext, QAppState) builder;
  // final Widget child;
  final QMultichannelWidget instance;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => instance.appBloc,
      child: BlocBuilder<QAppBloc, QAppState>(
        bloc: instance.appBloc,
        builder: (context, state) {
          // var room = context.room();
          var bloc = BlocProvider.of<QAppBloc>(context);
          var state = bloc.state;
          state.map(
            authenticated: (v) {
              print('authenticated $v');
            },
            initial: (v) {
              print('initial $v');
            },
            ready: (v) {
              print('ready $v');
            },
            setup: (v) {
              print('setup $v');
            },
          );
          return builder(context, state);
        },
      ),
    );
  }
}

class QMultichannelBuilder extends StatelessWidget {
  const QMultichannelBuilder({Key? key, required this.builder})
      : super(key: key);
  final Widget Function(BuildContext, QAppState) builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QAppBloc, QAppState>(
      builder: builder,
    );
  }
}
