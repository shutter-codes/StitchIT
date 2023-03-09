import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tailor_made/dependencies.dart';
import 'package:tailor_made/models/measure.dart';
import 'package:tailor_made/providers/snack_bar_provider.dart';
import 'package:tailor_made/screens/measures/_partials/measures_slide_block_item.dart';
import 'package:tailor_made/screens/measures/_views/slide_down.dart';
import 'package:tailor_made/utils/ui/mk_child_dialog.dart';
import 'package:tailor_made/utils/ui/mk_choice_dialog.dart';

enum _ActionChoice { edit, delete }

class MeasureSlideBlock extends StatefulWidget {
  const MeasureSlideBlock({
    Key key,
    @required this.measures,
    @required this.title,
    @required this.userId,
  }) : super(key: key);

  final List<MeasureModel> measures;
  final String title;
  final String userId;

  @override
  _MeasureSlideBlockState createState() => _MeasureSlideBlockState();
}

class _MeasureSlideBlockState extends State<MeasureSlideBlock> {
  @override
  Widget build(BuildContext context) {
    return SlideDownItem(
      title: widget.title,
      body: Column(children: [
        for (var measure in widget.measures) MeasuresSlideBlockItem(measure: measure),
      ]),
      onLongPress: () async {
        final choice = await _showOptionsDialog();

        if (choice == null) {
          return;
        }

        if (choice == _ActionChoice.edit) {
          _onTapEditBlock();
        } else if (choice == _ActionChoice.delete) {
          _onTapDeleteBlock();
        }
      },
    );
  }

  Future<_ActionChoice> _showOptionsDialog() {
    return mkShowChildDialog<_ActionChoice>(
      context: context,
      child: SimpleDialog(
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, _ActionChoice.edit),
            child: Padding(
              child: const Text("Edit"),
              padding: const EdgeInsets.all(8.0),
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, _ActionChoice.delete),
            child: Padding(
              child: const Text("Delete"),
              padding: const EdgeInsets.all(8.0),
            ),
          ),
        ],
      ),
    );
  }

  void _onTapEditBlock() {
    Dependencies.di().measuresCoordinator.toCreateMeasures(widget.title, widget.measures.first.unit, widget.measures);
  }

  void _onTapDeleteBlock() async {
    final choice = await mkChoiceDialog(context: context, title: "", message: "Are you sure?");
    if (choice == null || choice == false) {
      return;
    }

    SnackBarProvider.of(context).loading();
    try {
      // TODO: move this out of here
      await Dependencies.di().measures.delete(widget.measures, widget.userId);

      SnackBarProvider.of(context).hide();
    } catch (e) {
      SnackBarProvider.of(context).show(e.toString());
    }
  }
}
