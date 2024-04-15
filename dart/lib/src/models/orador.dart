// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part '../generated/orador.g.dart';

@JsonSerializable()
class Orador {
  final String nome;
  final String universidade;
  final String bio;
  final String role;
  final String foto;

  Orador({
    required this.nome,
    required this.universidade,
    required this.bio,
    required this.role,
    required this.foto,
  });

  // Fábrica nomeada para criar uma instância de Pessoa a partir de um mapa JSON.
  factory Orador.fromJson(Map<String, dynamic> json) => _$OradorFromJson(json);

  // Método toJson para serializar uma instância de Pessoa em um mapa JSON.
  Map<String, dynamic> toJson() => _$OradorToJson(this);
}
