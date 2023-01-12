import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/note_contoller.dart';

class EditNote extends StatelessWidget {
  final controller = Get.put(NoteController());

  final int index;

  EditNote({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: controller.myTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_sharp,
              color: Colors.orange,
              size: 30,
            ),
          ),
          title: const Text('Edit Note'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: controller.formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controller.titleController,
                      autovalidateMode: AutovalidateMode.always,
                      style: controller.myTheme.textTheme.headline4,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        hintText: 'Title',
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          gapPadding: 4,
                        ),
                        prefixIcon: const Icon(Icons.title_sharp),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Title must not be null';
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: controller.sizePhone(context).height / 20),
                    TextFormField(
                      controller: controller.contentController,
                      autovalidateMode: AutovalidateMode.always,
                      style: controller.myTheme.textTheme.headline4,
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: 'Note',
                        labelText: 'Note',
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          gapPadding: 4,
                        ),
                        prefixIcon: const Icon(Icons.note_add_outlined),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Note must not be null';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextButton.icon(
                      onPressed: controller.isSearch
                          ? () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.updateNotes(
                                  controller.listDisplay[index].id!,
                                  controller
                                      .listDisplay[index].dateTimeCreated!,
                                );
                                controller.update();
                              }
                            }
                          : () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.updateNotes(
                                  controller.notes[index].id!,
                                  controller.notes[index].dateTimeCreated!,
                                );
                                controller.update();
                              }
                            },
                      icon: const Icon(Icons.add, size: 20),
                      label: const Text(
                        'Edit Now',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
