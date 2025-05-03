import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:todo/model/todo_item_model.dart';
import 'package:todo/repo/icons/icons_repo.dart';
import 'package:todo/viewmodel/todo_list_viewmodel.dart';

// MAKE CREATING TODOPAGE FOR NEW TODOS

class TodoPage extends StatefulWidget {
  const TodoPage({super.key, required this.creating, this.task});
  final bool creating;
  final String? task;

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _textEditingController = TextEditingController();

  String chosenIcon = 'To do';
  bool slidingPanelVisible = false;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    TodoListViewModel tlvm = context.read<TodoListViewModel>();
    IconsRepo iconsRepo = context.read<IconsRepo>();

    if (!widget.creating) {
      chosenIcon = iconsRepo.translateIcon(tlvm.getModel(widget.task!)!.icon);
      _textEditingController.text = widget.task as String;
    }
  }

  @override
  Widget build(BuildContext context) {
    TodoListViewModel tlvm = context.read<TodoListViewModel>();
    IconsRepo iconsRepo = context.read<IconsRepo>();

    return Scaffold(
      floatingActionButton: Visibility(
        visible: !slidingPanelVisible,
        child: FloatingActionButton(
          onPressed: () {
            if (widget.creating) {
              if (tlvm.canAddTask(_textEditingController.text)) {
                tlvm.addTask(
                  TodoItemModel.fromPreferences(
                    iconsRepo,
                    _textEditingController.text,
                    chosenIcon,
                  ),
                );
                context.pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Can\'t add task with this name',
                      style: TextStyle(fontSize: 16),
                    ),

                    duration: Duration(seconds: 2),
                  ),
                );
              }
              // If task editing
            } else {
              if (tlvm.canAddTask(_textEditingController.text) ||
                  _textEditingController.text == widget.task) {
                tlvm.replaceTask(
                  widget.task as String,
                  TodoItemModel.fromPreferences(
                    iconsRepo,
                    _textEditingController.text,
                    chosenIcon,
                  ),
                );
                context.pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Can\'t replace task with new data',
                      style: TextStyle(fontSize: 16),
                    ),

                    duration: Duration(seconds: 2),
                  ),
                );
              }
            }
          },
          child: Icon(Icons.done),
        ),
      ),
      appBar: AppBar(
        title: Text(widget.creating ? 'Create new TODO' : 'Editing TODO'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(height: 1.0, width: 300, color: Colors.black45),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            // SingleChildScrollView to avoid bottom inset
            child: SingleChildScrollView(
              child: Column(
                spacing: 10,
                children: [
                  Text(
                    'Choose icon',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),

                  InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    onTap:
                        () => setState(() {
                          slidingPanelVisible = !slidingPanelVisible;
                        }),
                    child: Card(
                      child: Icon(iconsRepo.getIcon(chosenIcon), size: 200),
                    ),
                  ),

                  Text(
                    'Task name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  TextField(
                    style: TextStyle(fontSize: 20),
                    controller: _textEditingController,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: slidingPanelVisible,
            child: SlidingUpPanel(
              minHeight: 500,
              maxHeight: 700,
              panel: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 3,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: GridView.builder(
                        itemCount: iconsRepo.icons.keys.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.8,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                chosenIcon =
                                    iconsRepo.icons.keys.toList()[index];
                                slidingPanelVisible = false;
                              });
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Spacer(),
                                    Icon(
                                      iconsRepo.getIcon(
                                        iconsRepo.icons.keys.toList()[index],
                                      ),
                                      size: 60,
                                    ),
                                    Spacer(),
                                    Text(
                                      iconsRepo.icons.keys.toList()[index],
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
