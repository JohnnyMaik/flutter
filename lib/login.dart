import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(home: MyHomePage()));
}

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
          caixaEmail(),
          caixaSenha(),
          botao()
        ])
    );
  }

  TextEditingController txtEmail = TextEditingController();

  TextEditingController txtSenha = TextEditingController();

   botao(){
    return ElevatedButton(
      onPressed: () => 
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Main())), 
      child: Text("Entrar"));
  }
 

  caixaEmail(){
    return TextField(
      controller: txtEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(label: Text("Email:"))
    );
  }

  caixaSenha(){
      return TextField(
      controller: txtSenha,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(label: Text("Senha:"))
    );
  }
}



