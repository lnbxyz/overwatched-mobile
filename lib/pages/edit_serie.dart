import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:overwatched/models/serie.dart';

import '../components/simple_alert.dart';
import '../stores/serie_store.dart';

class EditSeriePage extends StatefulWidget {
  const EditSeriePage({Key? key, this.serie}) : super(key: key);

  final Serie? serie;

  @override
  State<EditSeriePage> createState() => _EditSeriePageState();
}

class _EditSeriePageState extends State<EditSeriePage> {
  SerieStore serieStore = SerieStore();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _coverUrlController = TextEditingController();
  final _releaseYearController = TextEditingController();
  final _endingYearController = TextEditingController();
  final _scoreController = TextEditingController();
  final _textEditingGenresController = TextEditingController();
  late List<String> _genreValues;

  @override
  void initState() {
    _genreValues = widget.serie?.genres ?? [];
    super.initState();
  }

  void _onClickSave(BuildContext context) async {

    try {
      await serieStore.create(Serie(
        name: _nameController.text,
        description: _descriptionController.text,
        coverUrl: _coverUrlController.text,
        releaseYear: _releaseYearController.text,
        endingYear: _endingYearController.text,
        score: _scoreController.text.isNotEmpty ? double.parse(_scoreController.text) : null,
        genres: _genreValues,
      ));

      showDialog(
        context: context,
        builder: (BuildContext context) =>
        const SimpleAlert(title: 'Série salva com sucesso'),
      ).whenComplete(() => Navigator.of(context).pop());
    } catch (err) {
      print(err);
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(widget.serie?.name ?? "Nova série",
                          style: Theme.of(context).textTheme.headline2)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nome',
                        ),
                        initialValue: widget.serie?.name,
                        controller: _nameController,
                        textInputAction: TextInputAction.next),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Descrição',
                      ),
                      minLines: 3,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      initialValue: widget.serie?.description,
                      controller: _descriptionController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'URL da imagem de capa',
                        ),
                        keyboardType: TextInputType.url,
                        initialValue: widget.serie?.coverUrl,
                        controller: _coverUrlController,
                        textInputAction: TextInputAction.next),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Ano de lançamento',
                        ),
                        keyboardType: TextInputType.number,
                        initialValue: widget.serie?.releaseYear,
                        controller: _releaseYearController,
                        textInputAction: TextInputAction.next),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Ano de encerramento',
                        ),
                        keyboardType: TextInputType.number,
                        initialValue: widget.serie?.endingYear,
                        controller: _endingYearController,
                        textInputAction: TextInputAction.next),
                  ),
                  SizedBox(
                    height: _genreValues.isNotEmpty ? 30 : 0,
                    child: buildChips(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Gêneros cinematográficos',
                          suffixIcon: IconButton(
                            visualDensity: VisualDensity.compact,
                            onPressed: _addChip,
                            icon: const Icon(Icons.add),
                          )),
                      controller: _textEditingGenresController,
                      onEditingComplete: _addChip,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nota IMDb',
                        suffixText: '/ 10.0'),
                    keyboardType: TextInputType.number,
                    controller: _scoreController,
                    initialValue: widget.serie?.score?.toStringAsFixed(1)),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          onPressed: () => _onClickSave(context),
                          child: const Text('Salvar')),
                    ],
                  ))
            ]),
          ),
        ));
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
          Padding(padding: const EdgeInsets.only(right: 8), child: actionChip));
    }

    return ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }
}
