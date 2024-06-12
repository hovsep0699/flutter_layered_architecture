// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardData _$CardDataFromJson(Map<String, dynamic> json) => CardData(
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => Items.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$CardDataToJson(CardData instance) => <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      logoType: json['logoType'] as String? ?? '',
      logoUrl: json['logoUrl'] as String? ?? '',
      bankName: json['bankName'] as String? ?? '',
      type: json['type'] as String? ?? '',
      purpose: json['purpose'] as String? ?? '',
      date: json['date'] as String? ?? '',
      effect: json['effect'] as bool? ?? false,
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'logoType': instance.logoType,
      'logoUrl': instance.logoUrl,
      'bankName': instance.bankName,
      'type': instance.type,
      'purpose': instance.purpose,
      'date': instance.date,
      'effect': instance.effect,
    };
