import 'dart:async';

import 'package:flutter/material.dart';
import 'package:overwatched/models/serie.dart';

import '../components/simple_alert.dart';

class EditSeriePage extends StatefulWidget {
  const EditSeriePage({Key? key, this.serie}) : super(key: key);

  final Serie? serie;

  @override
  State<EditSeriePage> createState() => _EditSeriePageState();
}

class _EditSeriePageState extends State<EditSeriePage> {
  final TextEditingController _textEditingGenresController =
      TextEditingController();
  late List<String> _genreValues;

  @override
  void initState() {
    _genreValues = widget.serie?.genres ?? [];
    super.initState();
  }

  void _onClickSave(BuildContext context) {
    Timer.run(() {
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            const SimpleAlert(title: 'Série salva com sucesso'),
      ).whenComplete(() => Navigator.of(context).pop());
    });
  }

  void _addChip() {
    _genreValues.add(_textEditingGenresController.text);
    _textEditingGenresController.clear();

    setState(() {
      _genreValues = _genreValues;
    });
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
