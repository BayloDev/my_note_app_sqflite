import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/note_contoller.dart';
import 'view/add_notes.dart';
import 'view/build_notes.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(NoteController());

  HomePage({super.key});
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldKey,
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      darkTheme: controller.myTheme,
      themeMode: ThemeMode.dark,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
          actions: [
            Container(
              margin: const EdgeInsets.only(top: 16, right: 20),
              child: GetBuilder<NoteController>(
                builder: (_) => GestureDetector(
                  onTap: controller.isEmpty()
                      ? () {}
                      : () {
                          controller.isSearch = !controller.isSearch;
                          controller.update();
                        },
                  child: Row(
                    children: [
                      Text(
                        controller.isSearch ? 'Close' : 'Search',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        controller.isSearch ? Icons.close : Icons.search,
                        size: 18,
                        color: Colors.white70,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Align(
          alignment: const Alignment(0.9, 0.87),
          child: FloatingActionButton(
            onPressed: () => Get.to(AddNotesPage()),
            child: const Icon(
              Icons.add,
              size: 30,
              color: Colors.white54,
            ),
          ),
        ),
        body: GetBuilder<NoteController>(
          builder: (control) => controller.isEmpty()
              ? Center(
                  child: Text(
                    'Empty',
                    style: controller.myTheme.textTheme.headline3,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16, top: 8),
                  child: Column(
                    children: [
                      if (controller.isSearch)
                        TextFormField(
                          style: controller.myTheme.textTheme.headline3!
                              .copyWith(fontWeight: FontWeight.normal),
                          decoration: InputDecoration(
                            labelText: 'Keyword',
                            labelStyle: controller.myTheme.textTheme.headline4!
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                          onChanged: (value) {
                            controller.keyword = value;
                            controller.update();
                          },
                        ),
                      Expanded(child: BuildNotes()),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
