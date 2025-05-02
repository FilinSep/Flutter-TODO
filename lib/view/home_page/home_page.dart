import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo_item_model.dart';
import 'package:todo/viewmodel/todo_list_viewmodel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TodoListViewModel tlvm = context.watch<TodoListViewModel>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Push task creating page
          context.pushNamed('Create');
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Simple TODO'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(height: 1.0, width: 300, color: Colors.black45),
        ),
      ),
      body:
          tlvm.todoItems.isNotEmpty
              ? ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  TodoItemModel model = tlvm.todoItems[index];

                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.red,
                      child: Icon(Icons.delete, color: Colors.white, size: 30),
                    ),
                    onDismissed: (direction) {
                      // Remove task from vm
                      tlvm.removeTask(model.task);

                      // Send snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '"${model.task}" done!',
                            style: TextStyle(fontSize: 16),
                          ),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // This thing uses SizedBox to center task text
                          SizedBox(
                            width: 50,
                            child: Icon(model.icon, size: 50),
                          ),
                          SizedBox(
                            width: 250,
                            child: Text(
                              model.task,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // Push task edit page
                              context.pushNamed(
                                'Edit',
                                pathParameters: {'task': model.task},
                              );
                            },
                            child: SizedBox(width: 50, child: Icon(Icons.edit)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: tlvm.length,
              )
              : Center(
                child: Text(
                  'No to-do tasks',
                  style: TextStyle(color: Colors.black45, fontSize: 16),
                ),
              ),
    );
  }
}
