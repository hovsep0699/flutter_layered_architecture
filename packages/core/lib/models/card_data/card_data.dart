import 'package:json_annotation/json_annotation.dart';

part 'card_data.g.dart';

@JsonSerializable(explicitToJson: true)
class CardData {

  CardData(
      {required this.items});

  @JsonKey(name: "items", defaultValue: [])
  List<Items> items;


  factory CardData.fromJson(Map<String, dynamic> json) => _$CardDataFromJson(json);
  
  Map<String, dynamic> toJson() => _$CardDataToJson(this);
  
  factory CardData.emptyInstance() => CardData(items: []);
}

@JsonSerializable(explicitToJson: true)
class Items {

  Items(
      {required this.logoType,
      required this.logoUrl,
      required this.bankName,
      required this.type,
      required this.purpose,
      required this.date,
      required this.effect});

  @JsonKey(name: "logoType", defaultValue: "")
  String logoType;

  @JsonKey(name: "logoUrl", defaultValue: "")
  String logoUrl;

  @JsonKey(name: "bankName", defaultValue: "")
  String bankName;

  @JsonKey(name: "type", defaultValue: "")
  String type;

  @JsonKey(name: "purpose", defaultValue: "")
  String purpose;

  @JsonKey(name: "date", defaultValue: "")
  String date;

  @JsonKey(name: "effect", defaultValue: false)
  bool effect;


  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);
  
  Map<String, dynamic> toJson() => _$ItemsToJson(this);
  
  factory Items.emptyInstance() => Items(logoType: "", logoUrl: "", bankName: "", type: "", purpose: "", date: "", effect: false);
}


