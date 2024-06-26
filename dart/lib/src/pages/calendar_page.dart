import 'package:chuva_dart/src/database/shared_preferences.dart';
import 'package:chuva_dart/src/models/evento.dart';
import 'package:chuva_dart/src/repositories/eventos_repository.dart';
import 'package:chuva_dart/src/widgets/my_widgets.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final EventosRepository evento = EventosRepository();
  final List<int> dias = [26, 27, 28, 29, 30];
  int _clickedIndex = 0;
  var qtdEventos = 0;
  List<Evento> eventosDoDia = [];
  List<Evento> todosEventos = [];
  final sharedPreferences = SharedPreferencesHelper();

  final MyWidgets myWidgets = MyWidgets();
  int diaSelecionado = 0;

  @override
  void initState() {
    super.initState();
    _carregarEventosIniciais();
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
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
                  style: TextStyle(fontSize: 21),
                ),
                Text(
                  "2023",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
                        diaSelecionado = dias[index];
                        _carregarEventosDoDia(diaSelecionado);
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
      eventosDoDia.isNotEmpty
          ? Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
                    child: myWidgets.eventsCard(eventosDoDia[index], context),
                  );
                },
                itemCount: eventosDoDia.length,
              ),
            )
          : const Center(child: CircularProgressIndicator())
    ]);
  }

  Future<void> _carregarEventosIniciais() async {
    await _todosEventos();
    _carregarEventosDoDia(dias[0]);
  }

  Future<void> _todosEventos() async {
    todosEventos = await evento.carregarTodosEventos(); // Obter todos os eventos
  }

  Future<void> _carregarEventosDoDia(int diaSelecionado) async {
    final eventosFavoritados = await sharedPreferences.recuperarTitulosEventosFavoritos();

    try {
      final eventosDoDia = todosEventos.where((evento) {
        // Filtrar eventos com base no dia selecionado
        final diaDoEvento = evento.inicio.day;
        if (eventosFavoritados.isNotEmpty && eventosFavoritados.contains(evento.titulo)) {
          evento.isFavorite = true;
        }
        return diaDoEvento == diaSelecionado;
      }).toList();

      //organiza a lista com base no horario de inicio e termino dos eventos
      eventosDoDia.sort((a, b) {
        // Comparar o horário de início primeiro
        final comparacaoInicio = a.inicio.compareTo(b.inicio);
        if (comparacaoInicio != 0) {
          return comparacaoInicio;
        }
        // Se os horários de início forem iguais, comparar o horário de término
        return a.fim.compareTo(b.fim);
      });

      setState(() {
        this.eventosDoDia = eventosDoDia; // Definir apenas os eventos do dia selecionado
        qtdEventos = eventosDoDia.length;
      });
    } catch (e) {
      debugPrint('Erro ao carregar eventos: $e');
      rethrow;
    }
  }
}
