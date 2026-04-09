import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: MyHomePage()));
}

TextEditingController txtID = TextEditingController();
TextEditingController txtProduto = TextEditingController();
TextEditingController txtMarca = TextEditingController();
TextEditingController txtPreco = TextEditingController();
TextEditingController txtEstoque = TextEditingController();


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
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

}


