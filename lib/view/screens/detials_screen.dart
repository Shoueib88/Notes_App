import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/const/style.dart';
import 'package:notes_app/cubit/note_cubit.dart';

void main() => runApp(Detials());

// ignore: must_be_immutable
class Detials extends StatelessWidget {
  Detials({super.key, this.index});
  int? index;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<NoteCubitBloc>();
    return Scaffold(
        appBar: AppBar(
          title: Text('Details', style: TextStyle(color: N.whitecolor)),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Title : ${controller.notesList[index!]['title']}',
                      style: N.textStyle),
                  const Divider(height: 20),
                  Text('Note : ${controller.notesList[index!]['message']}',
                      style: N.textStyle),
                ])));
  }
}
