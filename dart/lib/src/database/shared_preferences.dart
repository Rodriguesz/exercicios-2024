import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const _keyEventosFavoritos = 'eventos_favoritos';

  Future<void> adicionarTituloEventoFavorito(String tituloEvento) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> eventosFavoritos = await recuperarTitulosEventosFavoritos();
    eventosFavoritos.add(tituloEvento);
    await prefs.setStringList(_keyEventosFavoritos, eventosFavoritos);
  }

  Future<void> removerTituloEventoFavorito(String tituloEvento) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? eventosFavoritos = prefs.getStringList(_keyEventosFavoritos);

    if (eventosFavoritos != null) {
      eventosFavoritos.remove(tituloEvento);
      await prefs.setStringList(_keyEventosFavoritos, eventosFavoritos);
    }
  }

  Future<List<String>> recuperarTitulosEventosFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? titulosEventos = prefs.getStringList(_keyEventosFavoritos);
    return titulosEventos ?? [];
  }

  Future<void> removerArquivoSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
