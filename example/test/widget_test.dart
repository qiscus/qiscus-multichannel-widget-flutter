import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multichannel_flutter_sample/main.dart';
import 'package:multichannel_flutter_sample/demo_config.dart';


void main() {
  testWidgets('Setup UI renders modern sections and default values', (WidgetTester tester) async {
    // Note: App calls Firebase.initializeApp in main, but we pump the App widget here.
    // In a real scenario, we might want to mock Firebase.
    await tester.pumpWidget(const ProviderScope(child: App()));

    // Check modern sections
    expect(find.text('Multichannel Live Chat'), findsOneWidget);
    expect(find.text('1. Basic Configuration'), findsOneWidget);
    expect(find.text('2. Identity Information'), findsOneWidget);
    expect(find.text('3. Showcase Preset'), findsOneWidget);

    // Check defaults
    expect(find.text('guest-1001'), findsAtLeastNWidgets(1)); // User ID or Display Name
  });

  testWidgets('Validation: Start Chat blocks without required fields', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));

    // Clear App ID (this triggers the onChanged to update config in App)
    await tester.enterText(find.widgetWithText(TextField, 'App ID'), '');
    await tester.pump();

    // Tap Launch
    await tester.tap(find.text('Launch Chat Room'));
    await tester.pump();

    // Snack bar should show (validation error)
    expect(find.text('App ID and Channel ID are required'), findsOneWidget);
  });

  testWidgets('Theme selector and toggle updates the config', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));

    // Initially "Qiscus Teal" (from DemoThemePreset.qiscus)
    expect(find.text(DemoThemePreset.qiscus.label), findsOneWidget);

    // Open theme dropdown and select Ocean
    await tester.tap(find.byType(DropdownButtonFormField<DemoThemePreset>));
    await tester.pumpAndSettle();
    await tester.tap(find.text(DemoThemePreset.ocean.label).last);
    await tester.pumpAndSettle();

    expect(find.text(DemoThemePreset.ocean.label), findsOneWidget);

    // Find and tap a toggle
    final switchFinder = find.byType(Switch).first;
    expect(tester.widget<Switch>(switchFinder).value, true); // Default Show System Events is true

    await tester.tap(switchFinder);
    await tester.pump();

    expect(tester.widget<Switch>(switchFinder).value, false);
  });
}

