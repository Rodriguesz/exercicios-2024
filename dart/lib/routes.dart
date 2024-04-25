import 'package:chuva_dart/src/pages/activity_page.dart';
import 'package:chuva_dart/src/pages/calendar_page.dart';
import 'package:chuva_dart/src/pages/speaker_page.dart';
// import 'package:chuva_dart/src/pages/home_page.dart';
import 'package:go_router/go_router.dart';

import 'src/models/evento.dart';

final routes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CalendarPage(),
    ),
    GoRoute(
      path: '/calendar/activity',
      builder: (context, state) {
        final Evento evento = state.extra as Evento;
        return ActivityPage(evento: evento);
      },
    ),
    GoRoute(
      path: '/calendar/speaker',
      builder: (context, state) {
        final Evento evento = state.extra as Evento;
        return SpeakerPage(evento: evento);
      },
    ),
  ],
);
