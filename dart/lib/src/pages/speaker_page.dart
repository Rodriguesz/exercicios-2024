import 'package:cached_network_image/cached_network_image.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/evento.dart';
import '../repositories/eventos_repository.dart';
import '../widgets/my_widgets.dart';

class SpeakerPage extends StatefulWidget {
  const SpeakerPage({super.key, required this.evento});
  final Evento evento;

  @override
  State<SpeakerPage> createState() => _SpeakerPageState();
}

class _SpeakerPageState extends State<SpeakerPage> {
  final MyWidgets myWidgets = MyWidgets();
  final EventosRepository evento = EventosRepository();
  List<Evento> eventos = [];

  @override
  void initState() {
    super.initState();
    _carregarEventos();
    initializeDateFormatting('pt_BR');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myWidgets.standardAppBar(context, widget.evento),
      body: speakerPageBody(widget.evento),
    );
  }

  Widget speakerPageBody(Evento evento) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                    radius: 50,
                    backgroundImage: CachedNetworkImageProvider(
                      evento.orador[0].foto == ''
                          ? 'https://conteudo.imguol.com.br/blogs/174/files/2018/05/iStock-648229868-1024x909.jpg'
                          : evento.orador[0].foto,
                      maxHeight: 80,
                      maxWidth: 80,
                    )
                    // maxRadius: 30,
                    // child: ,
                    ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        evento.orador[0].nome,
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        evento.orador[0].universidade,
                        style: const TextStyle(fontSize: 19),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bio',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  myWidgets.removerHtmlString(widget.evento.orador[0].bio),
                  style: const TextStyle(fontSize: 15),
                ),
                const Text(
                  'Atividades',
                  style: TextStyle(fontSize: 18),
                ),
                Text(DateFormat('EEE d/M/y', 'pt_BR').format(widget.evento.inicio))
              ],
            ),
          ),
          eventos.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true, // this property means that the ListView will wrap its content
                  physics: const NeverScrollableScrollPhysics(), // to disable ListView's scrolling
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
                      child: myWidgets.eventsCard(eventos[index], context),
                    );
                  },
                  itemCount: eventos.length,
                )
              : const Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }

  Future<void> _carregarEventos() async {
    try {
      final eventos = await evento.carregarTodosEventos(); // Obter todos os eventos
      final eventosDoDia = eventos.where((evento) {
        // Filtrar eventos com base no dia selecionado
        final diaDoEvento = evento.inicio.day;
        final nomeOradores =
            evento.orador.isNotEmpty ? evento.orador.map((orador) => orador.nome).toList() : [];
        return diaDoEvento == widget.evento.inicio.day &&
            nomeOradores.contains(widget.evento.orador[0].nome);
      }).toList();

      setState(() {
        this.eventos = eventosDoDia; // Definir apenas os eventos do dia selecionado

        // for (int i = 0; i < eventosDoDia.length; i++) {
        //   print('eventos setState carregarEventos ${eventosDoDia[i].orador[0].nome}');
        // }
      });
    } catch (e) {
      debugPrint('Erro ao carregar eventos SpeakerPage: $e');
    }
  }
}
