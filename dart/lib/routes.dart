import 'dart:convert';

import 'package:chuva_dart/src/models/orador.dart';
import 'package:chuva_dart/src/pages/activity_page.dart';
import 'package:chuva_dart/src/pages/calendar_page.dart';
import 'package:chuva_dart/src/pages/speaker_page.dart';
// import 'package:chuva_dart/src/pages/home_page.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CalendarPage(),
    ),
    GoRoute(
      path: '/calendar/activity/:index',
      builder: (context, state) {
        final params = state.pathParameters; // Obter os parâmetros da rota
        final index =
            int.parse(params['index']!); // Acessar o parâmetro 'index'
        return ActivityPage(index: index);
      },
    ),
    GoRoute(
      path: '/calendar/activity/speaker/:speaker',
      builder: (context, state) {
        final params = state.pathParameters;
        final speakerJson = params['speaker']!;
        final speaker = Orador.fromJson(jsonDecode(speakerJson));
        return SpeakerPage(orador: speaker);
      },
    ), // GoRoute(
    //   path: '/calendar/activity/speaker/:speaker',
    //   builder: (context, state) {
    //     final params = state.pathParameters; // Obter os parâmetros da rota
    //     final speakerJson = params['speaker']; // Obter o parâmetro 'speaker' como uma string JSON

    //     if (speakerJson != null) {
    //       final speakerMap = jsonDecode(speakerJson); // Converter a string JSON para um mapa
    //       final speaker = Orador.fromJson(speakerMap); // Desserializar o mapa para um objeto Orador
    //       return SpeakerPage(speaker: );
    //     } else {
    //       // Lida com o caso em que 'speakerJson' é nulo
    //       return Container(); // Ou qualquer outra coisa que você deseja retornar
    //     }
    //   },
    // ),
  ],
);
