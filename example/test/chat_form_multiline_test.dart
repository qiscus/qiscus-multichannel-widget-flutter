import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';
// ignore: implementation_imports
import 'package:qiscus_multichannel_widget/src/widgets/chat_form.dart';

void main() {
  testWidgets('chat composer grows to three lines and keeps Enter as newline',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          accountProvider.overrideWith(
            (ref) => AsyncValue.data(
              QAccount(id: 'test-user', name: 'Test User'),
            ),
          ),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Expanded(child: SizedBox.expand()),
                QChatForm(),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final inputFinder = find.byType(TextField);
    final input = tester.widget<TextField>(inputFinder);
    expect(input.minLines, 1);
    expect(input.maxLines, 3);
    expect(input.keyboardType, TextInputType.multiline);
    expect(input.textInputAction, TextInputAction.newline);
    expect(input.onSubmitted, isNull);

    final oneLineRect = tester.getRect(inputFinder);
    await tester.enterText(inputFinder, 'First line\nSecond line');
    await tester.pump();
    final twoLineRect = tester.getRect(inputFinder);
    expect(twoLineRect.height, greaterThan(oneLineRect.height));
    expect(twoLineRect.top, lessThan(oneLineRect.top));
    expect(twoLineRect.bottom, closeTo(oneLineRect.bottom, 1));

    await tester.enterText(inputFinder, 'First\nSecond\nThird');
    await tester.pump();
    final threeLineRect = tester.getRect(inputFinder);
    expect(threeLineRect.height, greaterThan(twoLineRect.height));

    await tester.enterText(inputFinder, 'First\nSecond\nThird\nFourth');
    await tester.pump();
    final fourLineRect = tester.getRect(inputFinder);
    expect(fourLineRect.height, closeTo(threeLineRect.height, 1));
    expect(
      tester.widget<TextField>(inputFinder).controller!.text,
      'First\nSecond\nThird\nFourth',
    );

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets(
      'attach and send buttons stay bottom-aligned at 1, 2, 3, and over 3 lines',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          accountProvider.overrideWith(
            (ref) => AsyncValue.data(
              QAccount(id: 'test-user', name: 'Test User'),
            ),
          ),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Expanded(child: SizedBox.expand()),
                QChatForm(),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final inputFinder = find.byType(TextField);
    final attachFinder = _iconButtonFinder('ic-add.png');
    final sendFinder = _iconButtonFinder('ic-send.png');

    Future<double> bottomGap(Finder button) async {
      final inputBottom = tester.getRect(inputFinder).bottom;
      return (tester.getRect(button).bottom - inputBottom).abs();
    }

    for (final text in [
      'First line',
      'First\nSecond',
      'First\nSecond\nThird',
      'First\nSecond\nThird\nFourth',
    ]) {
      await tester.enterText(inputFinder, text);
      await tester.pumpAndSettle();

      final lineCount = '\n'.allMatches(text).length + 1;
      expect(
        tester.getRect(inputFinder).height,
        greaterThan(0),
        reason: 'text field should have laid out at $lineCount line(s)',
      );
      expect(
        await bottomGap(attachFinder),
        lessThanOrEqualTo(0.5),
        reason: 'attach button bottom must align with text field bottom '
            'at $lineCount line(s)',
      );
      expect(
        await bottomGap(sendFinder),
        lessThanOrEqualTo(0.5),
        reason: 'send button bottom must align with text field bottom '
            'at $lineCount line(s)',
      );
    }

    await tester.pumpWidget(const SizedBox.shrink());
  });
}

/// Finds the composer [TextButton] that renders the asset [assetName].
Finder _iconButtonFinder(String assetName) {
  final image = find.byWidgetPredicate(
    (widget) =>
        widget is Image &&
        widget.image is AssetImage &&
        (widget.image as AssetImage).assetName.endsWith(assetName),
    description: 'Image.asset($assetName)',
  );
  return find.ancestor(of: image, matching: find.byType(TextButton));
}
