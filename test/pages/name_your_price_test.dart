import 'package:app/pages/name_your_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Home page test', () {
    Finder checkBtn() => find.text('Check');
    Finder nextBtn() => find.text('Next');
    Finder priceInput() => find.byKey(const Key('priceInput'));
    Finder resultText() => find.byKey(const Key('result'));
    testWidgets('Show first product name', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: NameYourPricePage()));
      expect(find.text(products[0].name), findsOneWidget);

      for (var i = 1; i < 5; i++) {
        await tester.tap(checkBtn()); // nhấn vào nút check
        await tester.pump(); // render lại màn hình test
        await tester.tap(nextBtn());
        await tester.pump();
        expect(find.text(products[i].name), findsOneWidget); //tìm kiếm bằng
      }

      await tester.tap(checkBtn());
      await tester.pump();
      await tester.tap(checkBtn());
      await tester.pump();
      expect(find.text(products[4].name), findsOneWidget);
    });

    testWidgets('Show result after each click', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: NameYourPricePage()));

      expect(nextBtn(), findsNothing); // kiểm tra không hiện nút next
      expect(resultText(), findsNothing); // kiểm tra không hiện kể quả check

      await tester.enterText(priceInput(), '10');
      await tester.tap(checkBtn());
      await tester.pump();
      expect(nextBtn(), findsOneWidget);
      expect(resultText(), findsOneWidget);
      expect(find.text('pass'), findsOneWidget);

      await tester.tap(nextBtn());
      await tester.pump();

      expect(nextBtn(), findsNothing);
      expect(resultText(), findsNothing);

      await tester.enterText(priceInput(), '4');
      await tester.tap(checkBtn());
      await tester.pump();
      expect(nextBtn(), findsOneWidget);
      expect(resultText(), findsOneWidget);
      expect(find.text('fail'), findsOneWidget);

      await tester.enterText(priceInput(), '20');
      await tester.tap(checkBtn());
      await tester.pump();
      expect(find.text('pass'), findsOneWidget);
    });
  });
}
