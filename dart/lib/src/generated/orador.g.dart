// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/orador.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Orador _$OradorFromJson(Map<String, dynamic> json) => Orador(
      nome: json['name'] ?? '',
      universidade: json['institution'] ?? '',
      bio: json['bio']['pt-br'] ?? '',
      role: json['role']['label']['pt-br'] ?? '',
      foto: json['picture'] ?? '',
    );

Map<String, dynamic> _$OradorToJson(Orador instance) => <String, dynamic>{
      'nome': instance.nome,
      'bio': instance.bio,
      'universidade': instance.universidade,
      'role': instance.role,
      'foto': instance.foto
    };
