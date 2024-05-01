import 'package:chuva_dart/src/pages/activity_page.dart';
import 'package:chuva_dart/src/pages/calendar_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// Open activity page.
Future<void> loadActivityPage(WidgetTester tester) async {
  await tester.pumpWidget(const CalendarPage());
  await tester.tap(find.text('Mesa redonda de 07:00 até 08:00'));
  await tester.pumpAndSettle();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Activity page', () {
    testWidgets('Verifica elementos da atividade', (WidgetTester tester) async {
      await loadActivityPage(tester);
      await expectLater(
        find.byType(ActivityPage),
        matchesGoldenFile('../screenshots/ActivityPage-Unfavorited.png'),
      );

      expect(find.text('Astrofísica e Cosmologia'), findsOneWidget);
      expect(find.text('Maputo'), findsOneWidget);
      expect(find.text('Domingo 07:00h - 08:00h'), findsOneWidget);
      expect(find.text('Adicionar à sua agenda'), findsOneWidget);
      expect(find.text('Sthepen William Hawking'), findsOneWidget);
    });

    testWidgets('Verifica se favoritar funciona', (WidgetTester tester) async {
      await loadActivityPage(tester);
      await expectLater(
        find.byType(ActivityPage),
        matchesGoldenFile('../screenshots/ActivityPage-Unfavorited.png'),
      );
      await tester.tap(find.text('Adicionar à sua agenda'));
      await tester.pumpAndSettle();

      expect(find.text('Remover da sua agenda'), findsOneWidget);
      await expectLater(
        find.byType(ActivityPage),
        matchesGoldenFile('../screenshots/ActivityPage-Favorited.png'),
      );
    });
  });
}
