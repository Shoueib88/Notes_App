import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubit/note_cubit.dart';

void main() => runApp(Messages());

class Messages extends StatelessWidget {
  Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<NoteCubitBloc>();
    return AlertDialog(
      content: Form(
          key: controller.formstate,
          child: Container(
              width: 400,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                            controller: controller.title,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                              hintText: 'Title',
                              filled: true,
                            ),
                            maxLength: 20,
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Not Valid ';
                              }
                              return null;
                            }),
                        TextFormField(
                            controller: controller.message,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                              hintText: 'Message',
                              filled: true,
                            ),
                            maxLength: 500,
                            maxLines: 2,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Not Valid ';
                              }
                              return null;
                            })
                      ])))),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel')),
        TextButton(
            onPressed: () {
              //should you define forme state as final
              if (controller.formstate.currentState!.validate()) {
                String message;
                try {
                  controller.insertDataBase(
                      title: controller.title.text,
                      message: controller.message.text);

                  message = 'Feedback sent successfully';
                  Navigator.pop(context);
                } catch (e) {
                  message = 'Error when sending feedback';
                }

                // Show a snackbar with the result
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message)));
              }
            },
            child: Text('Send'))
      ],
    );
  }
}
