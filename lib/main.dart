import 'package:flutter/material.dart';

final List<Tarefa> tarefas = [];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tarefas",
      home: Inicial(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Inicial extends StatefulWidget {
  const Inicial({Key? key}) : super(key: key);

  @override
  State<Inicial> createState() => TelaInicial();
}

class TelaInicial extends State<Inicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 24.0),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            if (tarefas.isEmpty)
              Center(
                child: Opacity(
                  opacity: 0.2,
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/1/1560.png',
                    width: 300,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: tarefas.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.deepPurple,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              tarefas[index].titulo,
                              style: TextStyle(
                                color: Colors.deepPurple.shade800,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.check_circle_outline),
                            color: Colors.deepPurple,
                            onPressed: () {
                              setState(() {
                                tarefas.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: NewTaskAction(
        onTaskAdded: () {
          setState(() {});
        },
      ),
    );
  }
}

class NewTaskAction extends StatefulWidget {
  final VoidCallback onTaskAdded;

  NewTaskAction({required this.onTaskAdded});

  @override
  _NewTaskActionState createState() => _NewTaskActionState();
}

class _NewTaskActionState extends State<NewTaskAction> {
  TextEditingController tituloController = TextEditingController();

  void _abrirModal() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Digite a tarefa"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tituloController,
                decoration: InputDecoration(labelText: 'Tarefa'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Salvar"),
              onPressed: () {
                setState(() {
                  tarefas.add(Tarefa(titulo: tituloController.text));
                  widget.onTaskAdded(); // Atualiza a lista!
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _abrirModal,
      backgroundColor: Colors.deepPurple,
      child: Icon(Icons.add, color: Colors.white),
      mini: false,
    );
  }
}

// Modelo da tarefa
class Tarefa {
  String titulo;
  bool concluido;

  Tarefa({required this.titulo, this.concluido = false});
}
