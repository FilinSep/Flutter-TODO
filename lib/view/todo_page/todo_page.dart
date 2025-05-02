import 'package:flutter/material.dart';

// MAKE CREATING TODOPAGE FOR NEW TODOS

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // MAKE WITH CHANGENOTIFIER
        },
        child: Icon(Icons.done),
      ),
      appBar: AppBar(
        title: Text('Create new TODO'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(height: 1.0, width: 300, color: Colors.black45),
        ),
      ),
    );
  }
}
