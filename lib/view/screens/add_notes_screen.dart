import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/componant/add_notes_alertdialog.dart';
import 'package:notes_app/componant/custom_item.dart';
import 'package:notes_app/const/style.dart';
import 'package:notes_app/cubit/note_cubit.dart';
import 'package:notes_app/cubit/note_state.dart';

class AddNotes extends StatelessWidget {
  const AddNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('Notes', style: TextStyle(color: N.whitecolor))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Messages();
                });
          },
          backgroundColor: N.primarycolor,
          child: Icon(Icons.add, color: N.whitecolor),
        ),
        body: BlocBuilder<NoteCubitBloc, NoteState>(
          builder: (context, state) {
            print('$state');
            return CustomItem();
          },
        ));
  }
}
