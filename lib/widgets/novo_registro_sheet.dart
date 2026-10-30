import 'package:flutter/material.dart';

import '../models/registro.dart';

/// Abre o bottom sheet de novo registro e devolve o [Registro] criado,
/// ou `null` se o usuário fechar sem salvar.
Future<Registro?> showNovoRegistroSheet(BuildContext context) {
  return showModalBottomSheet<Registro>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => const _NovoRegistroSheet(),
  );
}

class _NovoRegistroSheet extends StatefulWidget {
  const _NovoRegistroSheet();

  @override
  State<_NovoRegistroSheet> createState() => _NovoRegistroSheetState();
}

class _NovoRegistroSheetState extends State<_NovoRegistroSheet> {
  final _formKey = GlobalKey<FormState>();
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();

  @override
  void dispose() {
    _pesoController.dispose();
    _alturaController.dispose();
    super.dispose();
  }

  void _salvar() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop(
      context,
      Registro(
        peso: _parse(_pesoController.text)!,
        altura: _parse(_alturaController.text)!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          24,
          0,
          24,
          24 + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Novo registro',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _pesoController,
                autofocus: true,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Peso (kg)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => _parse(value) == null
                    ? 'Informe um peso maior que zero'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _alturaController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _salvar(),
                decoration: const InputDecoration(
                  labelText: 'Altura (m)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => _parse(value) == null
                    ? 'Informe uma altura maior que zero'
                    : null,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _salvar,
                child: const Text('Calcular e salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Aceita vírgula ou ponto como separador decimal; `null` se vazio, inválido
/// ou menor/igual a zero.
double? _parse(String? text) {
  final value = double.tryParse((text ?? '').trim().replaceAll(',', '.'));
  return value != null && value > 0 ? value : null;
}
