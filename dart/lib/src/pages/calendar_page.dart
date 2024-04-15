import 'package:chuva_dart/src/models/evento.dart';
import 'package:chuva_dart/src/repositories/eventos_repository.dart';
import 'package:chuva_dart/src/widgets/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final EventosRepository evento = EventosRepository();
  final List<int> dias = [26, 27, 28, 29, 30];
  int _clickedIndex = -1;
  var qtdEventos = 0;
  List<Evento> eventos = [];
  final MyWidgets myWidgets = MyWidgets();

  @override
  void initState() {
    super.initState();
    _carregarEventos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: myBody(),
    );
  }

  AppBar myAppBar() {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: const Color(0xff456189),
      centerTitle: true,
      shadowColor: Colors.black,
      elevation: 3,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50.0), // Altura do subtítulo
        child: Column(children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back_ios_new),
                color: Colors.white,
              ),
              const SizedBox(
                width: 65,
              ),
              const Column(
                children: [
                  Text(
                    'Chuva 💜 Flutter',
                    style: TextStyle(color: Colors.white, fontSize: 21.0),
                  ),
                  Text(
                    'Programação',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 3, 15, 3),
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                    shadowColor: Colors.black),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 45,
                      height: 37,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Color(0xff306dc3),
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(16), right: Radius.circular(16))),
                      child: const Icon(
                        size: 25,
                        color: Colors.black,
                        Icons.calendar_month_outlined,
                      ),
                    ),
                    const SizedBox(
                      width: 43,
                    ),
                    const Text(
                      "Exibindo todas as atividades",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                )),
          ),
          const SizedBox(
            height: 5,
          ),
        ]),
      ),
    );
  }

  Widget myBody() {
    return eventos.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 0.5,
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Column(
                      children: [
                        Text(
                          "Nov",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "2023",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      crossAxisCount: 7,
                      shrinkWrap: true,
                      children: List.generate(7, (index) {
                        return GestureDetector(
                          onTap: () {
                            if (index < dias.length) {
                              setState(() {
                                _clickedIndex = index;
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            decoration: const BoxDecoration(
                              color: Color(0xff306dc3),
                            ),
                            child: Center(
                              child: Text(
                                index < dias.length ? dias[index].toString() : '',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: _clickedIndex == index
                                      ? const Color.fromARGB(255, 255, 255, 255)
                                      : const Color.fromARGB(199, 255, 255, 255),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
                      child: eventsCard(eventos[index], index),
                    );
                  },
                  itemCount: eventos.length,
                ),
              )
            ],
          )
        : const Center(child: CircularProgressIndicator());
  }

  Widget eventsCard(Evento evento, int index) {
    var hexColor = myWidgets.convertHexToColor(evento.corCategoria);
    var horaInicio = DateFormat('HH:mm').format(evento.inicio);

    var horaFim = DateFormat('HH:mm').format(evento.fim);

    return GestureDetector(
      onTap: () => GoRouter.of(context).push('/calendar/activity/$index'),
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
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${evento.tipo} de $horaInicio até $horaFim', // Adiciona zero à esquerda se necessário
                  style: const TextStyle(
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: 1,
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
                        idx < evento.orador.length - 1 ? '${palestrante.nome}, ' : palestrante.nome,
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
  }

  Future<void> _carregarEventos() async {
    try {
      final eventos = await evento.carregarTodosEventos(); // Use the ApiService instance
      setState(() {
        this.eventos = eventos;
        qtdEventos = eventos.length;
      });
    } catch (e) {
      print('Erro ao carregar eventos: $e');
    }
  }
}
