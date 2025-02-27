import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:signals_flutter/signals_flutter.dart';

import '../utils/counter.dart';

void main() {
  SignalsObserver.instance = null;
  group('.watch()', () {
    testWidgets('bindComputed', (tester) async {
      int calls = 0;
      final value = signal(0);
      final widget = Counter(
        watch: false,
        createSource: (context) => value,
        createReader: (context) =>
            bindComputed(context, computed(() => value.value)),
        callback: () => calls++,
      );

      await tester.pumpWidget(widget);

      expect(calls, 1);
      expect(find.text('Count: 0'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(calls, 2);
      expect(find.text('Count: 1'), findsOneWidget);
    });
  });

  group('Watch', () {
    testWidgets('bindComputed', (tester) async {
      int calls = 0;
      final value = signal(0);
      final widget = Counter(
        watch: true,
        createSource: (context) => value,
        createReader: (context) =>
            bindComputed(context, computed(() => value.value)),
        callback: () => calls++,
      );

      await tester.pumpWidget(widget);

      expect(calls, 1);
      expect(find.text('Count: 0'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(calls, 2);
      expect(find.text('Count: 1'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(calls, 3);
      expect(find.text('Count: 2'), findsOneWidget);
    });
  });
}
