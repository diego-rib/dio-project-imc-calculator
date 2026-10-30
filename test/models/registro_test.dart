import 'package:flutter_test/flutter_test.dart';

import 'package:imc_calculator/models/registro.dart';

void main() {
  group('calculateImc', () {
    test('calcula peso / altura²', () {
      expect(calculateImc(weight: 81, height: 1.8), closeTo(25, 0.001));
    });

    test('lança erro para altura zero', () {
      expect(() => calculateImc(weight: 70, height: 0), throwsArgumentError);
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
        expect(classifyImc(imc), expected);
      });
    });
  });

  group('Registro', () {
    test('calcula imc e classificação', () {
      final registro = Registro(peso: 70, altura: 1.75);

      expect(registro.imc, closeTo(22.86, 0.01));
      expect(registro.classificacao, 'Saudável');
    });

    test('usa a data informada', () {
      final data = DateTime(2026, 1, 2);

      expect(Registro(peso: 70, altura: 1.75, data: data).data, data);
    });

    test('lança erro para peso inválido', () {
      expect(() => Registro(peso: 0, altura: 1.75), throwsArgumentError);
    });

    test('lança erro para altura inválida', () {
      expect(() => Registro(peso: 70, altura: -1), throwsArgumentError);
    });
  });
}
