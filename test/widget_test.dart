// AstroSense widget tests

import 'package:flutter_test/flutter_test.dart';

import 'package:astrosense/main.dart';
import 'package:astrosense/engine/insight_engine.dart';

void main() {
  testWidgets('AstroSense app loads LoginPage', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AstroSenseApp());

    // Verify that the login page displays with AstroSense title
    expect(find.text('AstroSense'), findsOneWidget);
    expect(find.text('Your Personal Cosmic Guide'), findsOneWidget);
    
    // Verify login button exists
    expect(find.text('Begin Your Journey'), findsOneWidget);
  });

  testWidgets('Login validation shows error for empty fields', (WidgetTester tester) async {
    await tester.pumpWidget(const AstroSenseApp());

    // Tap login button without entering data
    await tester.tap(find.text('Begin Your Journey'));
    await tester.pump();

    // Verify validation message appears
    expect(find.text('Please enter both fields'), findsOneWidget);
  });

  testWidgets('InsightEngine generates insights', (WidgetTester tester) async {
    // Test insight generation
    final generalInsight = InsightEngine.generateGeneralInsight('Test', 'Aries');
    final emotionalInsight = InsightEngine.generateEmotionalInsight('Test', 'Aries');
    final careerInsight = InsightEngine.generateCareerInsight('Test', 'Aries');
    final relationshipInsight = InsightEngine.generateRelationshipInsight('Test', 'Aries');
    final affirmation = InsightEngine.generateAffirmation();
    final energyStatus = InsightEngine.generateEnergyStatus();

    // Verify insights are not empty
    expect(generalInsight.isNotEmpty, true);
    expect(emotionalInsight.isNotEmpty, true);
    expect(careerInsight.isNotEmpty, true);
    expect(relationshipInsight.isNotEmpty, true);
    expect(affirmation.isNotEmpty, true);
    expect(energyStatus.isNotEmpty, true);
  });
}
