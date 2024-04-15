// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chuva_dart/src/models/orador.dart';
import 'package:json_annotation/json_annotation.dart';

part '../generated/evento.g.dart';

@JsonSerializable()
class Evento {
  String titulo;
  DateTime inicio;
  DateTime fim;
  String descricao;
  String local;
  String nomeCategoria;
  String corCategoria;
  String tipo;
  List<Orador> orador;

  Evento({
    required this.titulo,
    required this.inicio,
    required this.fim,
    required this.descricao,
    required this.local,
    required this.nomeCategoria,
    required this.corCategoria,
    required this.tipo,
    required this.orador,
  });

  factory Evento.fromJson(Map<String, dynamic> json) => _$EventoFromJson(json);

  Map<String, dynamic> toJson() => _$EventoToJson(this);
}
