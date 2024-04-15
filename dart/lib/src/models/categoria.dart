import 'package:json_annotation/json_annotation.dart';

part '../generated/categoria.g.dart';

@JsonSerializable()
class Categoria {
  final String nome;
  final String cor;

  Categoria({
    required this.nome,
    required this.cor,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) =>
      _$CategoriaFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriaToJson(this);
}


// import 'package:json_annotation/json_annotation.dart';

// part '../generated/categoria.g.dart';

// @JsonSerializable()
// class Categoria {
//   @JsonKey(name: 'categoria')
//   final String categoriaEvento;
//   @JsonKey(name: 'color')
//   final String color;

//   Categoria({
//     required this.categoriaEvento,
//     required this.color,
//   });

//   // Fábrica nomeada para criar uma instância de Categoria a partir de um mapa JSON.
//   factory Categoria.fromJson(Map<String, dynamic> json) => _$CategoriaFromJson(json);

//   // Método toJson para serializar uma instância de Categoria em um mapa JSON.
//   Map<String, dynamic> toJson() => _$CategoriaToJson(this);
// }
