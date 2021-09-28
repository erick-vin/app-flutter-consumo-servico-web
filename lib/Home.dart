import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _resultado = "";
  TextEditingController _controllerCep = TextEditingController();

  void _pesquisar() async {
    String _cep = _controllerCep.text;
    var url = Uri.parse("https://viacep.com.br/ws/${_cep}/json/");
    http.Response response;

    response = await http.get(url);

    Map<String, dynamic> retorno = jsonDecode(response.body);
    String localidade = retorno["localidade"];
    String uf = retorno["uf"];
    String bairro = retorno["bairro"];
    String logradouro = retorno["logradouro"];

    setState(() {
      _resultado = "${logradouro}, ${bairro}, ${localidade}, ${uf}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço web"),
      ),
      body: Container(
          padding: EdgeInsets.all(30),
          width: double.infinity,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    "Consulta de CEP",
                    style: TextStyle(fontSize: 40, fontFamily: "Arial"),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 100),
                          child: Text(
                            "Preencha a informação abaixo: ",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Digite o CEP"),
                  controller: _controllerCep,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      onPressed: _pesquisar, child: Text("Clique aqui")),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(_resultado),
                ),
              ],
            ),
          )),
    );
  }
}
