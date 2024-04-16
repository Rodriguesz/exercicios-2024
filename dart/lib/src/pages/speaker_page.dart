import 'package:cached_network_image/cached_network_image.dart';
import 'package:chuva_dart/src/models/orador.dart';
import 'package:flutter/material.dart';
import '../models/evento.dart';
import '../repositories/eventos_repository.dart';
import '../widgets/my_widgets.dart';

class SpeakerPage extends StatefulWidget {
  const SpeakerPage({super.key, required this.orador});
  final Orador orador;

  @override
  State<SpeakerPage> createState() => _SpeakerPageState();
}

class _SpeakerPageState extends State<SpeakerPage> {
  final EventosRepository eventoObject = EventosRepository();
  final MyWidgets myWidgets = MyWidgets();
  late Evento evento;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myWidgets.standardAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
                title: Text(
                  widget.orador.nome,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                   widget.orador.nome,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                leading: CircleAvatar(
                    maxRadius: 30,
                    backgroundImage: CachedNetworkImageProvider(
                      evento.orador[0].foto == ''
                          ? 'src/assets/perfil_image.jpg'
                          : widget.orador.foto,
                    )))
          ],
        ),
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
