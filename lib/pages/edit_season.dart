import 'dart:io';

import 'package:flutter/material.dart';
import 'package:overwatched/repositories/season_repository.dart';

import '../models/season.dart';
import '../models/serie.dart';

class EditSeasonPage extends StatefulWidget {
  const EditSeasonPage({Key? key, required this.serie, this.season})
      : super(key: key);

  final Season? season;
  final Serie serie;

  @override
  State<EditSeasonPage> createState() => _EditSeasonPageState();
}

class _EditSeasonPageState extends State<EditSeasonPage> {
  final seasonRepository = SeasonRepository();

  late TextEditingController _nameController;
  late TextEditingController _numberController;

  @override
  void initState() {
    _nameController =
        TextEditingController(text: widget.season?.name); // required
    _numberController =
        TextEditingController(text: widget.season?.number.toString());
    super.initState();
  }

  void _onClickSave(BuildContext context) async {
    final newSeason = Season(
        name: _nameController.text,
        number: int.parse(_numberController.text),
        series: widget.serie.id);

    try {
      if (widget.season == null) {
        await seasonRepository.create(newSeason);
      } else {
        newSeason.id = widget.season!.id;
        await seasonRepository.update(newSeason);
      }

      showSnackbar(context, "Temporada salva com sucesso");
      Navigator.of(context).pop(newSeason);
    } catch (err) {
      String message = 'Um erro ocorreu ao salvar a série';
      if (err is HttpException) {
        message += ' (${err.message})';
      }
      message += '. Tente novamente.';
      showSnackbar(context, message);
    }
  }

  void showSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text('Temporada - ${widget.serie.name}'),
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: TextFormField(
              controller: _numberController,
              decoration: const InputDecoration(
                  labelText: 'Número', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
      actions: [
        OutlinedButton(
            child: const Text("Salvar"), onPressed: () => _onClickSave(context))
      ],
    );
  }
}
