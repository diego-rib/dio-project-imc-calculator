import 'dart:io';

import 'package:imc_calculator/pessoa.dart';

String readFromInput({required String label, required String errorMessage}) {
  print(label);
  String? input = stdin.readLineSync();

  if (input == null || input.trim().isEmpty) {
    throw ArgumentError(errorMessage);
  }

  return input;
}

double parseStringToDouble(String string, {String? errorMessage}) {
  final number = double.tryParse(string.trim().replaceAll(',', '.'));

  if (number == null) throw ArgumentError(errorMessage);

  return number;
}

Pessoa readPessoa() {
  final nome = readFromInput(
    label: 'Qual o seu nome?',
    errorMessage: 'Você deve inserir um nome válido',
  );

  final altura = parseStringToDouble(
    readFromInput(
      label: 'Qual a sua altura (em metros)?',
      errorMessage: 'Você deve inserir uma altura válida',
    ),
    errorMessage: 'Você deve inserir uma altura válida',
  );

  final peso = parseStringToDouble(
    readFromInput(
      label: 'Qual o seu peso (em kg)?',
      errorMessage: 'Você deve inserir um peso válido',
    ),
    errorMessage: 'Você deve inserir um peso válido',
  );

  return Pessoa(nome: nome, peso: peso, altura: altura);
}

void main() {
  try {
    final pessoa = readPessoa();

    print('nome -> ${pessoa.nome}');
    print('altura -> ${pessoa.altura} m');
    print('peso -> ${pessoa.peso} kg');
    print('imc -> ${pessoa.imc.toStringAsFixed(2)}');
    print('classificação -> ${pessoa.classificacao}');
  } on ArgumentError catch (e) {
    print('Erro: ${e.message}');
    exitCode = 1;
  }
}
