# Calculadora de IMC

## Como funciona

O IMC (Índice de Massa Corporal) é calculado dividindo o peso (em quilos) pela altura (em metros) elevada ao quadrado:

```
IMC = peso / altura²
```

O resultado é classificado conforme a tabela abaixo:

| IMC          | Classificação                |
| ------------ | ---------------------------- |
| < 16         | Magreza grave                |
| 16 a < 17    | Magreza moderada             |
| 17 a < 18,5  | Magreza leve                 |
| 18,5 a < 25  | Saudável                     |
| 25 a < 30    | Sobrepeso                    |
| 30 a < 35    | Obesidade Grau I             |
| 35 a < 40    | Obesidade Grau II (severa)   |
| ≥ 40         | Obesidade Grau III (mórbida) |

## Entendendo o Desafio

Neste Desafio você irá criar uma calculadora simples para calcular o IMC (Índice de Massa Corporal) utilizando a linguagem Dart e o Flutter.

## Como usar o app

- A tela inicial lista os registros calculados (peso, altura, IMC e classificação).
- O botão flutuante **+** abre um bottom sheet para informar peso (kg) e altura (m); vírgula ou ponto são aceitos.
- O ícone de lixeira de cada registro pede confirmação antes de excluir.
- Os registros ficam apenas em memória: a lista zera ao fechar o app.

## Checklist do Desafio

- [x] Criar classe Registro (Peso / Altura)
- [x] Ler dados no app
- [x] Tratar exceções
- [x] Calcular IMC
- [x] Exibir em uma lista
- [x] Testes
