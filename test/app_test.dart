import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:imc_calculator/main.dart' as imc_app;

class FakeStdin implements Stdin {
  FakeStdin(this.value);

  final String? value;

  @override
  String? readLineSync({
    Encoding encoding = systemEncoding,
    bool retainNewlines = false,
  }) => value;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

String readMock(String? value) => IOOverrides.runZoned(
  () => imc_app.readFromInput(label: 'label', errorMessage: 'erro'),
  stdin: () => FakeStdin(value),
);

Matcher argumentErrorWith(String message) =>
    throwsA(isA<ArgumentError>().having((e) => e.message, 'message', message));

void main() {
  group('readFromInput', () {
    test('retorna o valor digitado', () {
      expect(readMock('Diego'), 'Diego');
    });

    test('lança erro quando a entrada é null', () {
      expect(() => readMock(null), throwsArgumentError);
    });

    test('lança erro com a mensagem recebida quando a entrada é vazia', () {
      expect(() => readMock('   '), argumentErrorWith('erro'));
    });
  });

  group('parseStringToDouble', () {
    test('converte número com ponto', () {
      expect(imc_app.parseStringToDouble('1.75'), 1.75);
    });

    test('aceita vírgula como separador decimal', () {
      expect(imc_app.parseStringToDouble('1,75'), 1.75);
    });

    test('lança erro com a mensagem recebida para texto inválido', () {
      expect(
        () => imc_app.parseStringToDouble('abc', errorMessage: 'inválido'),
        argumentErrorWith('inválido'),
      );
    });
  });
}
