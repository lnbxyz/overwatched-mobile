import 'dart:io';

import 'package:flutter/material.dart';
import 'package:overwatched/models/serie.dart';
import 'package:overwatched/repositories/serie_repository.dart';

import '../components/simple_alert.dart';

class EditSeriePage extends StatefulWidget {
  const EditSeriePage({Key? key, this.serie}) : super(key: key);

  final Serie? serie;

  @override
  State<EditSeriePage> createState() => _EditSeriePageState();
}

class _EditSeriePageState extends State<EditSeriePage> {
  final serieRepository = SerieRepository();

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _coverUrlController;
  late TextEditingController _releaseYearController;
  late TextEditingController _endingYearController;
  late TextEditingController _scoreController;
  late TextEditingController _textEditingGenresController;
  late List<String> _genreValues;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.serie?.name); // required
    _descriptionController = TextEditingController(text: widget.serie?.description);
    _coverUrlController = TextEditingController(text: widget.serie?.coverUrl);
    _releaseYearController = TextEditingController(text: widget.serie?.releaseYear); // required
    _endingYearController = TextEditingController(text: widget.serie?.endingYear);
    _scoreController = TextEditingController(text: widget.serie?.score?.toStringAsFixed(1)); // required 0 - 10
    _textEditingGenresController = TextEditingController();
    _genreValues = widget.serie?.genres ?? [];
    super.initState();
  }

  void _onClickSave(BuildContext context) async {
    final newSerie = Serie(
      name: _nameController.text,
      description: _descriptionController.text,
      coverUrl: _coverUrlController.text,
      releaseYear: _releaseYearController.text,
      endingYear: _endingYearController.text,
      score: _scoreController.text.isNotEmpty ? double.parse(
          _scoreController.text) : null,
      genres: _genreValues,
    );

    try {
      if (widget.serie == null) {
        await serieRepository.create(newSerie);
      } else {
        newSerie.id = widget.serie!.id;
        await serieRepository.update(newSerie);
      }

      showDialog(
        context: context,
        builder: (BuildContext context) =>
        const SimpleAlert(title: 'Série salva com sucesso'),
      ).whenComplete(() => Navigator.of(context).pop(true));
    } catch (err) {
      String message = 'Um erro ocorreu ao salvar a série';
      if (err is HttpException) {
        message += ' (${err.message})';
      }
      message += '. Tente novamente.';
      showSnackbar(context, message);
    }
  }

  void _addChip() {
    _genreValues.add(_textEditingGenresController.text);
    _textEditingGenresController.clear();

    setState(() {
      _genreValues = _genreValues;
    });
  }

  void showSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text))
    );
  }

  @override
  void dispose() {
    _textEditingGenresController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.serie?.name ?? "Nova série"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  widget.serie?.name ?? "Nova série",
                  style: Theme.of(context).textTheme.headline2
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(),
                  ),
                  minLines: 3,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  controller: _coverUrlController,
                  decoration: const InputDecoration(
                    labelText: 'URL da imagem de capa',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.next
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  controller: _releaseYearController,
                  decoration: const InputDecoration(
                    labelText: 'Ano de lançamento',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  controller: _endingYearController,
                  decoration: const InputDecoration(
                    labelText: 'Ano de encerramento',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next
                ),
              ),
              SizedBox(
                height: _genreValues.isNotEmpty ? 30 : 0,
                child: buildChips(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  controller: _textEditingGenresController,
                  decoration: InputDecoration(
                      labelText: 'Gêneros cinematográficos',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: _addChip,
                        icon: const Icon(Icons.add),
                      )
                  ),
                  onEditingComplete: _addChip,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  controller: _scoreController,
                  decoration: const InputDecoration(
                    labelText: 'Nota IMDb',
                    border: OutlineInputBorder(),
                    suffixText: '/ 10.0'
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () => _onClickSave(context),
                      child: const Text('Salvar')
                    ),
                  ],
                )
              )
            ]
          ),
        ),
      )
    );
  }

  Widget buildChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _genreValues.length; i++) {
      InputChip actionChip = InputChip(
        label: Text(_genreValues[i]),
        onDeleted: () {
          _genreValues.removeAt(i);

          setState(() {
            _genreValues = _genreValues;
          });
        },
      );

      chips.add(
        Padding(
            padding: const EdgeInsets.only(right: 8),
            child: actionChip
        )
      );
    }

    return ListView(
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }
}
