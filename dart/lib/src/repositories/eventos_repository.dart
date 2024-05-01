import 'dart:convert';
import 'package:chuva_dart/src/models/evento.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class EventosRepository {
  Future<List<Evento>> carregarTodosEventos() async {
    try {
      final dio = Dio();
      final response1 = await dio.get(
          'https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities.json');
      final response2 = await dio.get(
          'https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities-1.json');

      if (response1.statusCode == 200 && response2.statusCode == 200) {
        final jsonData1 = jsonDecode(response1.data);
        final jsonData2 = jsonDecode(response2.data);

        final List<dynamic> eventosJson1 = jsonData1['data'];
        final List<dynamic> eventosJson2 = jsonData2['data'];

        final List<Evento> eventos = [];

        // Adicionar eventos do primeiro response
        eventos.addAll(eventosJson1.map((eventoJson) => Evento.fromJson(eventoJson)));

        // Adicionar eventos do segundo response
        eventos.addAll(eventosJson2.map((eventoJson) => Evento.fromJson(eventoJson)));

        return eventos;
      } else {
        throw Exception('Erro ao carregar eventos');
      }
    } catch (e) {
      debugPrint('Erro ao obter dados da API: $e');
      return []; // Retorna uma lista vazia em caso de erro
    }
  }
}
