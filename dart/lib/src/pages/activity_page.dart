import 'package:cached_network_image/cached_network_image.dart';
import 'package:chuva_dart/src/repositories/provider.dart';
import 'package:flutter/material.dart';
import 'package:chuva_dart/src/repositories/eventos_repository.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import '../widgets/my_widgets.dart';
import 'package:chuva_dart/src/models/evento.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key, required this.evento}) : super(key: key);
  final Evento evento;

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final EventosRepository eventoObject = EventosRepository();
  final MyWidgets myWidgets = MyWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myWidgets.standardAppBar(context, widget.evento),
        body: activityPageBody(widget.evento));
  }

  Widget activityPageBody(Evento evento) {
    initializeDateFormatting('pt_BR'); // Inicializa o formato de data para o idioma pt br
    var diaInicio = myWidgets.primeiraLetraMaiuscula(DateFormat('EEEE', 'pt_BR')
        .format(evento.inicio)); // Obtém o dia da semana do início do evento
    var horaInicio = DateFormat('HH:mm').format(evento.inicio); // Obtém a hora de início do evento
    var horaFim = DateFormat('HH:mm').format(evento.fim); // Obtém a hora de fim do evento

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 35,
                  color: myWidgets.convertHexToColor(evento.corCategoria),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 6, 0, 0),
                    child: Text(
                      evento.nomeCategoria,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),

          /// TÍTULO DO EVENTO
          Text(
            textAlign: TextAlign.center,
            evento.titulo,
            style: const TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            maxLines: 2,
          ),
          const SizedBox(
            height: 10,
          ),

          /// ROWS DA DATA E LOCAL
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(6, 4, 4, 4),
                child: Icon(
                  Icons.access_time_outlined,
                  size: 15.0,
                  color: Colors.blue,
                ),
              ),
              Text(
                '$diaInicio ${horaInicio}h - ${horaFim}h',
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(6, 4, 4, 4),
                child: Icon(
                  Icons.location_on,
                  size: 15.0,
                  color: Colors.blue,
                ),
              ),
              Text(
                evento.local,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
                height: 37,
                width: 400,

                /// BOTÃO DE FAVORITO
                child: Consumer<FavoritosProvider>(
                  builder: (context, favoritosProvider, _) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff306dc3),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                        onPressed: () {
                          final provider = Provider.of<FavoritosProvider>(context, listen: false);

                          /// Adiciona ou remove o evento favorito
                          provider.adicionarFavorito(widget.evento);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: widget.evento.isFavorite ? Colors.yellow : Colors.white,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              widget.evento.isFavorite
                                  ? 'Remover da agenda'
                                  : 'Adicionar à sua agenda',
                              style: const TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ));
                  },
                )),
          ),

          /// DESCRIÇÃO
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              myWidgets
                  .removerHtmlString(evento.descricao), // Remove tags HTML da descrição do evento
              textAlign: TextAlign.start,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.5),
            ),
          ),

          /// PALESTRANTE
          evento.orador.isNotEmpty
              ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      evento.orador[0].role,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        GoRouter.of(context).push('/calendar/activity/speaker', extra: evento);
                      },
                      child: ListTile(
                          title: Text(
                            evento.orador[0].nome,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            evento.orador[0].universidade,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          leading: CircleAvatar(
                              maxRadius: 30,
                              backgroundImage: CachedNetworkImageProvider(
                                evento.orador[0].foto == ''
                                    ? 'https://conteudo.imguol.com.br/blogs/174/files/2018/05/iStock-648229868-1024x909.jpg'
                                    : evento.orador[0].foto,
                              ))))
                ])
              : const SizedBox()
        ],
      ),
    );
  }
}
