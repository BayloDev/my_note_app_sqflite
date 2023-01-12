import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/note_contoller.dart';

class AddNotesPage extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey();

  final DateTime date = DateTime.now();
  final controller = Get.put(NoteController());

  AddNotesPage({super.key});

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
          title: const Text('Add Note'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Note Description',
                      style: controller.myTheme.textTheme.headline2,
                      textAlign: TextAlign.center,
                    ),
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
                          return 'Please enter title';
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: controller.sizePhone(context).height / 20),
                    TextFormField(
                      controller: controller.contentController,
                      autovalidateMode: AutovalidateMode.always,
                      maxLines: 6,
                      style: controller.myTheme.textTheme.headline4,
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
                          return 'Please enter note';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextButton.icon(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          controller.addNoteToDataBase();
                          Get.back();
                        }
                      },
                      icon: const Icon(Icons.add, size: 20),
                      label: const Text(
                        'Add Now',
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
