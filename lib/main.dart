import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'Todos'),
    );
  }
}

class TodoItem {
  TodoItem({required this.title, this.resolved = false});
  
  String title;
  bool resolved;
}

class TodoList extends StatefulWidget {
  const TodoList({ Key? key }) : super(key: key);

  @override
  TodoListState createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  
  final _todos = <TodoItem>[];
  
  @override
  Widget build(BuildContext context) {
    
    final textFieldControllerPrepend = TextEditingController();
    final textFieldControllerAppend = TextEditingController();
    
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ListTile(
                title: TextField(
                  controller: textFieldControllerPrepend,
                  decoration: const InputDecoration(
                    hintText: "Add to the beginning",
                  ),
                ),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                  ),
                  onPressed: () {
                    var todo = TodoItem(title: textFieldControllerPrepend.text);
                    textFieldControllerPrepend.clear();
                    setState(() {
                      _todos.insert(0, todo);
                    });
                  },
                  child: const Icon(Icons.add)),
              ),
            )
          ],
        ),
        _todos.isNotEmpty ?
          Expanded (
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                var todo = _todos[index];
                return ListTile(
                  leading: Checkbox.adaptive(
                    value: todo.resolved,
                    onChanged: (var _) {},
                  ),
                  title: Text(
                    todo.title,
                    style: todo.resolved ? const TextStyle(
                      decoration: TextDecoration.lineThrough
                    ) : null,
                  ),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                    ),
                    onPressed: () {
                      setState(() {
                        _todos.removeAt(index);
                      });
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      todo.resolved = !todo.resolved;
                    });
                  },
                );
              },
            ),
          )
        :
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No Todos yet',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  fontSize: 30,
                ),
              )
            ],
          ),
        ),
        if (_todos.isNotEmpty) ListTile(
              title: TextField(
                controller: textFieldControllerAppend,
                decoration: const InputDecoration(
                  hintText: "Add to the end",
                ),
              ),
              trailing: FilledButton.tonal(
                onPressed: () {
                  var todo = TodoItem(title: textFieldControllerAppend.text);
                  textFieldControllerAppend.clear();
                  setState(() {
                    _todos.add(todo);
                  });
                },
                child: const Icon(Icons.add)
              ),
          ),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const TodoList(),
    );
  }
}
