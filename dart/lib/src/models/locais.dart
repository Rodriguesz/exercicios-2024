
import 'package:json_annotation/json_annotation.dart';

part '../generated/locais.g.dart';

@JsonSerializable()
class Locais {
  final String nomeLocal;

  Locais({required this.nomeLocal});

  factory Locais.fromJson(Map<String, dynamic> json) =>
      _$LocaisFromJson(json);

  Map<String, dynamic> toJson() => _$LocaisToJson(this);
}
