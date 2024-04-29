// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/evento.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************s

Evento _$EventoFromJson(Map<String, dynamic> json) => Evento(
      titulo: json['title']["pt-br"] ?? '',
      inicio: DateTime.parse(
          json['start'].substring(0, 19) ?? ''), // .substring(0, 19) esta cortando o fuso horario
      fim: DateTime.parse(json['end'].substring(0, 19) ?? ''),
      descricao: json['description']["pt-br"] ?? '',
      local: json['locations'][0]['title']['pt-br'],
      nomeCategoria: json['category']["title"]["pt-br"] ?? '',
      corCategoria: json['category']["color"] ?? '#c28d08',
      tipo: json['type']["title"]["pt-br"] ?? '',
      orador: (json['people'] as List<dynamic>)
          .map((item) => Orador.fromJson(item as Map<String, dynamic>))
          .toList(),
      isFavorite: false,
    );

Map<String, dynamic> _$EventoToJson(Evento instance) => <String, dynamic>{
      'titulo': instance.titulo,
      'inicio': instance.inicio.toIso8601String(),
      'descricao': instance.descricao,
      'local': instance.local,
      'nomeCategoria': instance.nomeCategoria,
      'tipo': instance.tipo,
      'orador': instance.orador,
      'corCategoria': instance.corCategoria
    };
