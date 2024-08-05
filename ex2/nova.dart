import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_application_1/dados_json.dart';

class Nova extends StatefulWidget {
  const Nova({super.key});

  @override
  State<Nova> createState() => _NovaState();
}

// Preparando para receber dados no futuro
Future<String> _carregaDadosRemotos() async {
  final response = await (http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/2')));
  if (response.statusCode == 200) {
    print('response statusCode is 200');
    return response.body;
  } else {
    print('Http Error: ${response.statusCode}!');
    throw Exception('Invalid data source.');
  }
}

class _NovaState extends State<Nova> {
  late Future<DadosJSON> meusDados;

  @override
  void initState() {
    super.initState();
    meusDados = buscaDados();
  }

  Future<DadosJSON> buscaDados() async {
    String original = await _carregaDadosRemotos();
    final decodificada = json.decode(original);
    return DadosJSON.fromJson(decodificada);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('API'),
        ),
        body: Center(
          // nomes virão de outro lugar
          child: FutureBuilder<DadosJSON>(
            future: meusDados,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Exibir um indicador de carregamento enquanto espera os dados
              } else if (snapshot.hasError) {
                return Text('Erro ao carregar dados: ${snapshot.error}');
              } else {
                return Text(
                    "${snapshot.data?.title}"); // Exibir os dados quando estiverem prontos
              }
            },
          ),
        ),
      ),
    );
  }
}
