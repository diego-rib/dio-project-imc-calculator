import 'package:flutter/material.dart';

import '../models/registro.dart';
import '../widgets/novo_registro_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Registro> _registros = [];

  Future<void> _adicionar() async {
    final registro = await showNovoRegistroSheet(context);
    if (registro == null) return;

    setState(() => _registros.insert(0, registro));
  }

  Future<void> _excluir(Registro registro) async {
    final confirmou = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir registro?'),
        content: const Text('Essa ação não pode ser desfeita.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
    if (confirmou != true) return;

    setState(() => _registros.remove(registro));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Calculadora de IMC'),
      ),
      body: _registros.isEmpty
          ? const Center(child: Text('Nenhum registro ainda'))
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
              itemCount: _registros.length,
              itemBuilder: (context, index) {
                final registro = _registros[index];

                return Card(
                  child: ListTile(
                    title: Text(
                      'IMC ${_formatar(registro.imc, 1)} · '
                      '${registro.classificacao}',
                    ),
                    subtitle: Text(
                      '${_formatar(registro.peso, 1, trim: true)} kg · '
                      '${_formatar(registro.altura, 2)} m',
                    ),
                    trailing: IconButton(
                      tooltip: 'Excluir',
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _excluir(registro),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionar,
        tooltip: 'Novo registro',
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Formata com vírgula decimal; com [trim], remove zeros à direita (70,0 → 70).
String _formatar(double value, int decimals, {bool trim = false}) {
  var text = value.toStringAsFixed(decimals);
  if (trim && text.contains('.')) {
    text = text.replaceFirst(RegExp(r'\.?0+$'), '');
  }
  return text.replaceAll('.', ',');
}
