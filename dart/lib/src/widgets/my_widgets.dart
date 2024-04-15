import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:html/parser.dart';

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

  AppBar standardAppBar(BuildContext context) {
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
                onPressed: () => GoRouter.of(context).pop(),
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
}
