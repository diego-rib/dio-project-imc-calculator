class Pessoa {
  Pessoa({required this.nome, required this.peso, required this.altura}) {
    if (nome.trim().isEmpty) {
      throw ArgumentError('Você deve inserir um nome válido');
    }

    if (peso <= 0) {
      throw ArgumentError('Você deve inserir um peso válido');
    }

    if (altura <= 0) {
      throw ArgumentError('Você deve inserir uma altura válida');
    }
  }

  final String nome;

  /// Peso em quilos.
  final double peso;

  /// Altura em metros.
  final double altura;

  double get imc => calculateImc(weight: peso, height: altura);
  String get classificacao => classifyImc(imc);
}

/// IMC = peso (kg) / altura² (m).
double calculateImc({required double weight, required double height}) {
  if (height <= 0) {
    throw ArgumentError('Você deve inserir uma altura válida');
  }

  return weight / (height * height);
}

String classifyImc(double imc) {
  if (imc < 16) return 'Magreza grave';
  if (imc < 17) return 'Magreza moderada';
  if (imc < 18.5) return 'Magreza leve';
  if (imc < 25) return 'Saudável';
  if (imc < 30) return 'Sobrepeso';
  if (imc < 35) return 'Obesidade Grau I';
  if (imc < 40) return 'Obesidade Grau II (severa)';
  return 'Obesidade Grau III (mórbida)';
}
