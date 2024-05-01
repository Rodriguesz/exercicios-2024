import 'package:chuva_dart/src/database/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import '../models/evento.dart';

class FavoritosProvider extends ChangeNotifier {
  final List<Evento> _favoritos = [];

  List<Evento> get favoritos => _favoritos;
  final sharedPreferences = SharedPreferencesHelper();

  void adicionarFavorito(Evento evento) async {
    if (evento.isFavorite) {
      evento.isFavorite = false;
      await sharedPreferences.removerTituloEventoFavorito(evento.titulo);
    } else {
      evento.isFavorite = true;
      await sharedPreferences.adicionarTituloEventoFavorito(evento.titulo);
    }
    notifyListeners(); // Notifica os ouvintes sobre a mudança no estado
  }
}
