import 'dart:io';

import 'package:flutter/material.dart';
import 'package:overwatched/models/episode.dart';
import 'package:overwatched/repositories/episode_repository.dart';

import '../components/simple_alert.dart';

class EditEpisodeDialog extends StatefulWidget {
  const EditEpisodeDialog({Key? key, this.episode, required this.seasonId}) : super(key: key);

  final Episode? episode;
  final String seasonId;

  @override
  State<EditEpisodeDialog> createState() => _EditEpisodeDialogState();
}

class _EditEpisodeDialogState extends State<EditEpisodeDialog> {
  final episodeRepository = EpisodeRepository();

  late TextEditingController _nameController;
  late TextEditingController _numberController;
  late TextEditingController _durationController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.episode?.name);
    _numberController = TextEditingController(text: widget.episode?.number.toString());
    _durationController = TextEditingController(text: widget.episode?.duration.toString());
    super.initState();
  }

  void _onClickSave(BuildContext context) async {
    final newEpisode = Episode(
      season: widget.seasonId,
      name: _nameController.text,
      number: int.tryParse(_numberController.text) ?? 0,
      duration: int.tryParse(_durationController.text) ?? 0,
    );

    try {
      if (widget.episode == null) {
        await episodeRepository.create(newEpisode);
      } else {
        newEpisode.id = widget.episode!.id;
        await episodeRepository.update(newEpisode);
      }

      showSnackbar(context, 'Episódio salvo com sucesso.');
      Navigator.of(context).pop(newEpisode);
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
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text))
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(widget.episode == null ? 'Novo episódio' : 'Editar episódio'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              controller: _numberController,
              decoration: const InputDecoration(
                labelText: 'Número',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: TextFormField(
              controller: _durationController,
              decoration: const InputDecoration(
                labelText: 'Duração',
                border: OutlineInputBorder(),
                suffixText: 'min.'
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
      actions: [
        OutlinedButton(
            onPressed: () => _onClickSave(context),
            child: const Text('Salvar')
        ),
      ],
    );
  }
}
