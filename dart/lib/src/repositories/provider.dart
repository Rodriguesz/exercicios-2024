import 'package:chuva_dart/src/database/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import '../models/evento.dart';

class FavoritosProvider extends ChangeNotifier {
  List<Evento> _favoritos = [];

  List<Evento> get favoritos => _favoritos;
  final shared_preferences = SharedPreferencesHelper();

  void adicionarFavorito(Evento evento) async {
    if (evento.isFavorite) {
      evento.isFavorite = false;
      await shared_preferences.removerTituloEventoFavorito(evento.titulo);
    } else {
      evento.isFavorite = true;
      await shared_preferences.adicionarTituloEventoFavorito(evento.titulo);
    }
    notifyListeners(); // Notifica os ouvintes sobre a mudança no estado
  }
}
