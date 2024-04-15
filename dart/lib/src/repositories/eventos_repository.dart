import 'dart:convert';
import 'package:chuva_dart/src/models/evento.dart';
import 'package:dio/dio.dart';

class EventosRepository {
  Future<List<Evento>> carregarTodosEventos() async {
    try {
      final dio = Dio();
      final response = await dio.get(
          'https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities.json');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.data);

        final List<dynamic> eventosJson = jsonData['data'];
        final List<Evento> eventos =
            eventosJson.map((eventoJson) => Evento.fromJson(eventoJson)).toList();

        return eventos;
      } else {
        throw Exception('Erro ao carregar eventos (Status Code: ${response.statusCode})');
      }
    } catch (e) {
      print('Erro ao obter dados da API: $e');
      return []; // Return empty list on error
    }
  }

  Future<Evento> carregarEvento(int index) async {
    try {
      final dio = Dio();
      final response = await dio.get(
          'https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities.json');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.data);

        // Obtenha o evento correspondente ao índice fornecido
        final eventoJson = jsonData['data'][index];

        // Converta o JSON do evento em um objeto Evento
        final Evento evento = Evento.fromJson(eventoJson);

        return evento;
      } else {
        throw Exception('Erro ao carregar eventos (Status Code: ${response.statusCode})');
      }
    } catch (e) {
      print('Erro ao obter dados da API: $e');
      rethrow; // Rethrow a exceção para que ela possa ser tratada onde a função foi chamada
    }
  }

  // Future<Evento> carregarEvento(int index) async {
  //   try {
  //     final dio = Dio();
  //     final response = await dio.get(
  //         'https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities.json');

  //     if (response.statusCode == 200) {
  //       final jsonData = jsonDecode(response.data);

  //       final List<dynamic> eventoJson = jsonData['data'][index];
  //       final Evento evento = Evento.fromJson(eventoJson).toList();
  //       return evento;
  //     } else {
  //       throw Exception('Erro ao carregar eventos (Status Code: ${response.statusCode})');
  //     }
  //   } catch (e) {
  //     print('Erro ao obter dados da API: $e'); // Return empty list on error
  //   }
  //   return
  // }
}

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:chuva_dart/src/models/evento.dart';
// import 'package:dio/dio.dart';

// class EventosRepository {
//   final void Function(List<Evento>) onUpdateEventos;

//   EventosRepository({required this.onUpdateEventos});

//   Future<List<Evento>> _carregarEventos() async {
//     try {
//       final dio = Dio();
//       final response = await dio.get(
//           'https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities.json');

//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.data);

//         final List<dynamic> eventosJson = jsonData['data'];
//         final List<Evento> eventos =
//             eventosJson.map((eventoJson) => Evento.fromJson(eventoJson)).toList();
//         // print(eventos);
//         setState(() {
//           // Atualiza o estado com os eventos recebidos
//           this.eventos = eventos;
//           qtdEventos = eventos.length;
//         });
//         return eventos;
//       } else {
//         throw Exception('Erro ao carregar eventos (Status Code: ${response.statusCode})');
//       }
//     } catch (e) {
//       print('Erro ao obter dados da API: $e');
//       return []; // Retorna uma lista vazia em caso de erro
//     }
//   }
// }
