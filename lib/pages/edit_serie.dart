
import 'package:flutter/material.dart';
import 'package:overwatched/models/serie.dart';


class EditSeriePage extends StatefulWidget {
  const EditSeriePage({Key? key, this.serie}) : super(key: key);

  final Serie? serie;

  @override
  State<EditSeriePage> createState() => _EditSeriePageState();
}

class _EditSeriePageState extends State<EditSeriePage> {
  void _onClickSave(BuildContext context) {
    // TODO modal de sucesso
    Navigator.of(context).pop();
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
                ),
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ano de lançamento',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ano de encerramento',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Gêneros cinematográficos',
                  ),
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
                          child: const Text('Salvar')),
                    ],
                  ))
            ]),
          ),
        ));
  }
}
