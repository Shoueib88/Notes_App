import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/componant/edit_notes_alertdialog.dart';
import 'package:notes_app/const/style.dart';
import 'package:notes_app/cubit/note_cubit.dart';
import 'package:notes_app/view/screens/detials_screen.dart';

void main() => runApp(const CustomItem());

class CustomItem extends StatefulWidget {
  const CustomItem({super.key});

  @override
  State<CustomItem> createState() => _CustomItemState();
}

class _CustomItemState extends State<CustomItem> {
  @override
  Widget build(BuildContext context) {
    final controller = context.read<NoteCubitBloc>();

    return Center(
        child: controller.notesList.isEmpty
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cancel_outlined, size: 50),
                  Text('Not Found', style: TextStyle(fontSize: 35))
                ],
              )
            : ListView.builder(
                itemCount: controller.notesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      //height: 100,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: N.primarycolor),
                          borderRadius: BorderRadius.circular(13),
                          gradient: const LinearGradient(
                              begin: AlignmentDirectional.bottomEnd,
                              end: AlignmentDirectional.centerStart,
                              colors: [
                                Color.fromARGB(255, 201, 52, 41),
                                Color.fromARGB(255, 98, 2, 115),
                              ])),
                      child: ListTile(
                        onTap: () {
                          //i will need index
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Detials(index: index)));
                        },
                        title: Text(controller.notesList[index]['title'],
                            style:
                                TextStyle(fontSize: 25, color: N.whitecolor)),
                        subtitle: Text(controller.notesList[index]['message'],
                            style:
                                TextStyle(fontSize: 25, color: N.whitecolor)),
                        trailing:
                            Row(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return EditMeassge(
                                        onpressed: () {
                                          //should you define forme state as final
                                          if (controller.formstate.currentState!
                                              .validate()) {
                                            String message;
                                            try {
                                              controller.updatemessageDataBase(
                                                  title: controller.title.text,
                                                  message:
                                                      controller.message.text,
                                                  id: controller
                                                      .notesList[index]['id']);

                                              message =
                                                  'Feedback sent successfully';
                                              Navigator.pop(context);
                                            } catch (e) {
                                              message =
                                                  'Error when sending feedback';
                                            }

                                            // Show a snackbar with the result
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(message)));
                                          }
                                        },
                                      );
                                    });
                              },
                              icon: Icon(Icons.edit_note,
                                  color: N.whitecolor, size: 30)),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Are you sure'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                controller.deleteDataBase(
                                                    id: controller
                                                            .notesList[index]
                                                        ['id']);
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Yes')),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('No')),
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(Icons.delete,
                                  color: N.whitecolor, size: 27)),
                        ]),
                      ));
                }));
  }
}
