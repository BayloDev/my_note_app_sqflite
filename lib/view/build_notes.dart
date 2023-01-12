import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/note_contoller.dart';
import 'edit_note.dart';

class BuildNotes extends StatelessWidget {
  final controller = Get.put(NoteController());

  BuildNotes({super.key});

  @override
  Widget build(BuildContext context) {
    controller.listDisplay = !controller.isSearch
        ? controller.notes
        : controller.notes.where((element) {
            return element.title!
                    .toLowerCase()
                    .contains(controller.keyword.toLowerCase()) ||
                element.content!
                    .toLowerCase()
                    .contains(controller.keyword.toLowerCase()) ||
                element.dateTimeCreated!
                    .toLowerCase()
                    .contains(controller.keyword.toLowerCase()) ||
                element.dateTimeEdited!
                    .toLowerCase()
                    .contains(controller.keyword.toLowerCase());
          }).toList();
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 150),
      itemCount: controller.listDisplay.length,
      itemBuilder: (context, index) {
        return Container(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color.fromARGB(255, 252, 201, 126),
          ),
          margin: const EdgeInsets.only(top: 8),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      minVerticalPadding: 0,
                      title: controller.listDisplay[index].isExpand == 1
                          ? Text(
                              '${controller.listDisplay[index].title}',
                              overflow: TextOverflow.visible,
                              softWrap: true,
                              style: controller.myTheme.textTheme.headline1,
                            )
                          : Text(
                              '${controller.listDisplay[index].title}',
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 1,
                              style: controller.myTheme.textTheme.headline1,
                            ),
                      subtitle: controller.listDisplay[index].isExpand == 1
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Text(
                                '${controller.listDisplay[index].content}',
                                overflow: TextOverflow.visible,
                                softWrap: true,
                                style: controller.myTheme.textTheme.bodyText1,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Text(
                                '${controller.listDisplay[index].content}',
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 2,
                                style: controller.myTheme.textTheme.bodyText1,
                              ),
                            ),
                    ),
                  ),
                  GetBuilder<NoteController>(
                    builder: (controller) => IconButton(
                      onPressed: () {
                        controller.listDisplay[index].isExpand =
                            controller.listDisplay[index].isExpand == 0 ? 1 : 0;

                        controller.update();
                      },
                      icon: Icon(
                        controller.listDisplay[index].isExpand == 1
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        size: 55,
                        color: controller.listDisplay[index].isExpand == 1
                            ? Colors.orange
                            : Colors.black26,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                height: 2,
                color: Colors.black.withOpacity(0.14),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (controller.listDisplay[index].dateTimeCreated) ==
                            (controller.listDisplay[index].dateTimeEdited)
                        ? 'Created: ${controller.listDisplay[index].dateTimeCreated}'
                        : 'Created: ${controller.listDisplay[index].dateTimeCreated}\nUpdated: ${controller.listDisplay[index].dateTimeEdited}',
                    style: controller.myTheme.textTheme.bodyText2,
                  ),
                  SizedBox(width: controller.sizePhone(context).width / 50),
                  GestureDetector(
                    child: const Icon(
                      Icons.share,
                      color: Colors.orange,
                      size: 26,
                    ),
                    onTap: () => controller.shareNote(
                        controller.listDisplay[index].title!,
                        controller.listDisplay[index].content!),
                  ),
                  GestureDetector(
                    child: const Icon(
                      Icons.edit,
                      color: Colors.teal,
                      size: 26,
                    ),
                    onTap: () {
                      controller.titleController.text =
                          controller.listDisplay[index].title!;
                      controller.contentController.text =
                          controller.listDisplay[index].content!;
                      Get.to(
                        EditNote(
                          index: index,
                        ),
                      );
                    },
                  ),
                  GestureDetector(
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 26,
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Row(
                              children: [
                                const Icon(Icons.info, color: Colors.red),
                                const SizedBox(width: 16),
                                Text(
                                  'Delete Note',
                                  style: controller.myTheme.textTheme.headline1!
                                      .copyWith(
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Divider(
                                  thickness: 3,
                                  color: Colors.white24,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Are you sure you want to delete this note ?',
                                  style: controller.myTheme.textTheme.headline3!
                                      .copyWith(color: Colors.white38),
                                ),
                              ],
                            ),
                            actions: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white60,
                                  size: 16,
                                ),
                                label: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.deepOrange,
                                  ),
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () async {
                                  controller.deleteNoteFromDb(
                                    controller.listDisplay[index].id!,
                                  );
                                  controller.getAllNotes();
                                  Get.back();
                                },
                                icon: const Icon(
                                  Icons.done,
                                  color: Colors.white60,
                                  size: 16,
                                ),
                                label: const Text(
                                  'Done',
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.teal),
                                ),
                              ),
                            ],
                            backgroundColor: Colors.grey.shade900,
                            elevation: 5,
                            actionsAlignment: MainAxisAlignment.spaceAround,
                          );
                        },
                        barrierDismissible: true,
                        barrierColor: Colors.black54,
                        useSafeArea: true,
                      ).then((value) => null);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
