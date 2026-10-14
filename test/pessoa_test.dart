import 'package:flutter_test/flutter_test.dart';

import 'package:imc_calculator/pessoa.dart' as pessoa_class;

void main() {
  group('calculateImc', () {
    test('calcula peso / altura²', () {
      expect(
        pessoa_class.calculateImc(weight: 81, height: 1.8),
        closeTo(25, 0.001),
      );
    });

    test('lança erro para altura zero', () {
      expect(
        () => pessoa_class.calculateImc(weight: 70, height: 0),
        throwsArgumentError,
      );
    });
  });

  group('classifyImc', () {
    final cases = <double, String>{
      15.9: 'Magreza grave',
      16: 'Magreza moderada',
      16.9: 'Magreza moderada',
      17: 'Magreza leve',
      18.4: 'Magreza leve',
      18.5: 'Saudável',
      24.9: 'Saudável',
      25: 'Sobrepeso',
      29.9: 'Sobrepeso',
      30: 'Obesidade Grau I',
      34.9: 'Obesidade Grau I',
      35: 'Obesidade Grau II (severa)',
      39.9: 'Obesidade Grau II (severa)',
      40: 'Obesidade Grau III (mórbida)',
      55: 'Obesidade Grau III (mórbida)',
    };

    cases.forEach((imc, expected) {
      test('$imc -> $expected', () {
        expect(pessoa_class.classifyImc(imc), expected);
      });
    });
  });

  group('Pessoa', () {
    test('calcula imc e classificação', () {
      final pessoa = pessoa_class.Pessoa(nome: 'Diego', peso: 70, altura: 1.75);

      expect(pessoa.imc, closeTo(22.86, 0.01));
      expect(pessoa.classificacao, 'Saudável');
    });

    test('lança erro para nome vazio', () {
      expect(
        () => pessoa_class.Pessoa(nome: ' ', peso: 70, altura: 1.75),
        throwsArgumentError,
      );
    });

    test('lança erro para peso inválido', () {
      expect(
        () => pessoa_class.Pessoa(nome: 'Diego', peso: 0, altura: 1.75),
        throwsArgumentError,
      );
    });

    test('lança erro para altura inválida', () {
      expect(
        () => pessoa_class.Pessoa(nome: 'Diego', peso: 70, altura: -1),
        throwsArgumentError,
      );
    });
  });
}
