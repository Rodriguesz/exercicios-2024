import 'package:chuva_dart/src/models/evento.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

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
                onPressed: () => GoRouter.of(context).go('/', extra: evento),
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

    return GestureDetector(
      onTap: () => GoRouter.of(context).go('/calendar/activity', extra: evento),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3), // Raio da borda
        ),
        child: Container(
          height: 87,
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
            padding: const EdgeInsets.fromLTRB(13, 6, 0, 8),
            child: SizedBox(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${evento.tipo} de $horaInicio até $horaFim', // Adiciona zero à esquerda se necessário
                        style: const TextStyle(
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (evento.isFavorite == true) const Icon(Icons.bookmark),
                    ],
                  ),

                  // flex: 1,
                  SizedBox(
                    width: 300,
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
      ),
    );
  }
}
