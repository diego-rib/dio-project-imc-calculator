import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:imc_calculator/main.dart';

Future<void> adicionarRegistro(
  WidgetTester tester, {
  required String peso,
  required String altura,
}) async {
  await tester.tap(find.byType(FloatingActionButton));
  await tester.pumpAndSettle();

  await tester.enterText(find.widgetWithText(TextFormField, 'Peso (kg)'), peso);
  await tester.enterText(
    find.widgetWithText(TextFormField, 'Altura (m)'),
    altura,
  );
  await tester.tap(find.text('Calcular e salvar'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('começa com a lista vazia', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Nenhum registro ainda'), findsOneWidget);
    expect(find.byType(ListTile), findsNothing);
  });

  testWidgets('adiciona um registro pelo bottom sheet', (tester) async {
    await tester.pumpWidget(const MyApp());

    await adicionarRegistro(tester, peso: '70', altura: '1,75');

    expect(find.text('Nenhum registro ainda'), findsNothing);
    expect(find.text('IMC 22,9 · Saudável'), findsOneWidget);
    expect(find.text('70 kg · 1,75 m'), findsOneWidget);
  });

  testWidgets('aceita ponto como separador decimal', (tester) async {
    await tester.pumpWidget(const MyApp());

    await adicionarRegistro(tester, peso: '81', altura: '1.8');

    expect(find.text('IMC 25,0 · Sobrepeso'), findsOneWidget);
  });

  testWidgets('o registro mais novo aparece primeiro', (tester) async {
    await tester.pumpWidget(const MyApp());

    await adicionarRegistro(tester, peso: '70', altura: '1,75');
    await adicionarRegistro(tester, peso: '81', altura: '1,8');

    final primeiro = tester.getTopLeft(find.text('IMC 25,0 · Sobrepeso'));
    final segundo = tester.getTopLeft(find.text('IMC 22,9 · Saudável'));
    expect(primeiro.dy, lessThan(segundo.dy));
  });

  testWidgets('não salva com campos inválidos e mantém o sheet aberto', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await adicionarRegistro(tester, peso: '0', altura: '');

    expect(find.text('Informe um peso maior que zero'), findsOneWidget);
    expect(find.text('Informe uma altura maior que zero'), findsOneWidget);
    expect(find.text('Calcular e salvar'), findsOneWidget);

    await tester.tapAt(const Offset(10, 10)); // fecha o sheet pela barreira
    await tester.pumpAndSettle();
    expect(find.text('Nenhum registro ainda'), findsOneWidget);
  });

  group('excluir', () {
    testWidgets('cancelar mantém o registro', (tester) async {
      await tester.pumpWidget(const MyApp());
      await adicionarRegistro(tester, peso: '70', altura: '1,75');

      await tester.tap(find.byTooltip('Excluir'));
      await tester.pumpAndSettle();

      expect(find.text('Excluir registro?'), findsOneWidget);

      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();

      expect(find.text('Excluir registro?'), findsNothing);
      expect(find.text('IMC 22,9 · Saudável'), findsOneWidget);
    });

    testWidgets('confirmar remove o registro', (tester) async {
      await tester.pumpWidget(const MyApp());
      await adicionarRegistro(tester, peso: '70', altura: '1,75');

      await tester.tap(find.byTooltip('Excluir'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Excluir'));
      await tester.pumpAndSettle();

      expect(find.text('IMC 22,9 · Saudável'), findsNothing);
      expect(find.text('Nenhum registro ainda'), findsOneWidget);
    });
  });
}
