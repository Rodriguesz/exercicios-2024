import 'package:chuva_dart/src/models/evento.dart';
import 'package:chuva_dart/src/repositories/provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyWidgets {
  /// CONVERTE A COR QUE VEIO DO JSON EM HEXADICIMAL
  Color convertHexToColor(String hexColor) {
    // Remove o caractere '#' do início do código de cor
    String hex = hexColor.replaceAll('#', '');

    // Converte o código de cor hexadecimal em um número inteiro
    int colorValue = int.parse('0xFF$hex');

    // Retorna um objeto Color com base no valor inteiro calculado
    return Color(colorValue);
  }

  /// TRANSOFORMA A PRIMEIRA LETRA DA STRING EM MAIUSCULA
  String primeiraLetraMaiuscula(String string) {
    return string[0].toUpperCase() + string.substring(1);
  }

  /// REMOVE AS TAGS HTML
  String removerHtmlString(String htmlString) {
    final document = parse(htmlString);
    final texto = document.body?.text;

    return texto ?? '';
  }

  AppBar standardAppBar(BuildContext context, Evento evento) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 24,
      backgroundColor: const Color(0xff456189),
      centerTitle: true,
      shadowColor: Colors.black,
      elevation: 3,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: Column(children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new),
                color: Colors.white,
              ),
              const SizedBox(width: 65),
              const Text(
                'Chuva 💜 Flutter',
                style: TextStyle(color: Colors.white, fontSize: 21.0),
              ),
            ],
          ),
          const SizedBox(height: 7),
        ]),
      ),
    );
  }

  Widget eventsCard(Evento evento, BuildContext context) {
    var hexColor = convertHexToColor(evento.corCategoria);
    var horaInicio = DateFormat('HH:mm').format(evento.inicio);
    var horaFim = DateFormat('HH:mm').format(evento.fim);

    final mediaQuery = MediaQuery.of(context);
    final myWidth = mediaQuery.size.width;
    final myHeight = mediaQuery.size.height;

    return Consumer<FavoritosProvider>(builder: (context, favoritosProvider, _) {
      return GestureDetector(
        onTap: () => GoRouter.of(context).push('/calendar/activity', extra: evento),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3), // Raio da borda
          ),
          child: Container(
            height: myHeight * 0.12,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3),
              shape: BoxShape.rectangle,
              border: Border(
                left: BorderSide(
                  color: hexColor,
                  width: 4,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 5),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0, bottom: 2),
                    child: Row(
                      children: [
                        Text(
                          '${evento.tipo} de $horaInicio até $horaFim', // Adiciona zero à esquerda se necessário
                          style: const TextStyle(
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Spacer(),
                        if (evento.isFavorite == true) const Icon(Icons.bookmark),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: myWidth * 0.7,
                    child: Text(
                      evento.titulo,
                      style: const TextStyle(
                        fontSize: 16.5,
                        overflow: TextOverflow.ellipsis,
                        height: 1.1,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(
                    height: myHeight * 0.003,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: evento.orador.asMap().entries.map((entry) {
                      // Obtém o índice e o palestrante do par chave-valor
                      int idx = entry.key;
                      final palestrante = entry.value;

                      // Verifica se é o último palestrante na lista
                      return Flexible(
                        child: Text(
                          idx < evento.orador.length - 1
                              ? '${palestrante.nome}, '
                              : palestrante.nome,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 114, 114, 114),
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      );
                    }).toList(), // Converte o iterável resultante de volta em uma lista de widgets Text
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
