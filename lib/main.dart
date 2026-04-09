import 'package:flutter/material.dart';
import 'DataBaseHelper.dart';
import 'User.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: MyHomePage()));
}


TextEditingController txtNome = TextEditingController();
TextEditingController txtEmail = TextEditingController();
TextEditingController txtID = TextEditingController();
TextEditingController txtProduto = TextEditingController();
TextEditingController txtMarca = TextEditingController();
TextEditingController txtPreco = TextEditingController();
TextEditingController txtEstoque = TextEditingController();

late Databasehelper dbHelper;
List<User> usuarios = [];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    dbHelper = Databasehelper();
    dbHelper.conectaDB.whenComplete(() async {
      usuarios = await dbHelper.consultaUsers();
      setState(() {});
    });
    return Scaffold(
        appBar: AppBar(title: Text('Login')), 
        body: Column(children: [
          // caixaEmail(),
          // caixaSenha(),
          // botao(),
          TextField(controller: txtID),
          ElevatedButton(onPressed: () => busca(), child: const Text('Buscar')),
          TextField(controller: txtProduto),
          TextField(controller: txtMarca),
          TextField(controller: txtPreco),
          TextField(controller: txtEstoque),
          if (foto != '') Image.network(foto),
        ],
      ),
    );
  }

    String foto = '';

  busca() async {
    String id = txtID.text;

    final url = Uri.parse('https://dummyjson.com/products/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      txtProduto.text = data['title'];
      txtMarca.text = data['brand'];
      txtPreco.text = double.parse(data['price'].toString()).toString();
      txtEstoque.text = double.parse(data['stock'].toString()).toString(); 
      setState(() {
        foto = data['thumbnail'];
      });      
    } else {
      throw Exception('Requisção Inválida');
    }
  }

  botao(){
    return ElevatedButton(
      onPressed: () => 
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          final main2 = () {
            runApp(const MaterialApp(home: MyHomePage()));
          }();
          return main2;
        })), 
      child: Text("Entrar"));
  }

botaoIncluir(){
  return ElevatedButton(
    child: const Text('Incluir'), onPressed: () => incluir());
}
}

caixaNome(){
  return TextField(
    controller: txtNome,
    decoration: const InputDecoration(labelText: 'Informe o nome'));
}

caixaEmail(){
  return TextField(
    controller: txtEmail,
    decoration: const InputDecoration(labelText: 'Informe o email'));
}

lista(){
  return ListView.builder(
    itemCount: usuarios.length,
    itemBuilder: (context, index) {
      return Card(
        child: ListTile(
          onTap: () => carregarDados(usuarios[index].nome.toString(), usuarios[index].email.toString()),
          leading: CircleAvatar(child: Text(usuarios[index].id.toString())),
          title: Text(usuarios[index].nome),
          subtitle: Text(usuarios[index].email),
          trailing: Row(mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed:()=> alterar(int.parse(usuarios[index].id.toString())), 
              icon: const Icon(Icons.delete)),
          ])
          ));
    });
}

carregarDados(){
  
}


extension on Future<dynamic> Function() {
  void whenComplete(Future<Null> Function() param0) {}
}


