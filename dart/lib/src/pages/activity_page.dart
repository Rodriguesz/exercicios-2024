import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:chuva_dart/src/repositories/eventos_repository.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../widgets/my_widgets.dart';
import 'package:chuva_dart/src/models/evento.dart';
import 'package:intl/intl.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final EventosRepository eventoObject = EventosRepository();
  final MyWidgets myWidgets = MyWidgets();
  late Evento evento;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myWidgets.standardAppBar(context),
      body: FutureBuilder(
        future: _carregarEvento(widget.index),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return activityPageBody(evento);
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget activityPageBody(Evento evento) {
    initializeDateFormatting('pt_BR');
    var diaInicio =
        myWidgets.primeiraLetraMaiuscula(DateFormat('EEEE', 'pt_BR').format(evento.inicio));
    var horaInicio = DateFormat('HH:mm').format(evento.inicio);

    var horaFim = DateFormat('HH:mm').format(evento.fim);

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

          /// TEXT DO TITULO
          Text(
            textAlign: TextAlign.center,
            evento.titulo,
            style: const TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              // fontFamily: 'YourFontNameHere', // Set if you know the exact font name
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
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff306dc3),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                  onPressed: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Adicionar à sua agenda',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  )),
            ),
          ),

          /// DESCRIÇÃO
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              myWidgets.removerHtmlString(evento.descricao),
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
                  ListTile(
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
                                ? 'src/assets/perfil_image.jpg'
                                : evento.orador[0].foto,
                          )))
                ])
              : const SizedBox()
        ],
      ),
    );
  }

  Future<Evento> _carregarEvento(int index) async {
    try {
      final eventos = await eventoObject.carregarEvento(index);
      setState(() {
        evento = eventos;
      });
      return evento;
    } catch (e) {
      print('Erro ao carregar eventos: $e');
      rethrow;
    }
  }
}
