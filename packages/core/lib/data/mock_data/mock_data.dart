import 'package:core/core.dart';
import 'package:core/domain/models/card_data/card_data.dart';

class MockData {
  late final CardData _data;

  MockData.fromJson(Map<String, dynamic> json) {
    _data = CardData.fromJson(json);
  }

  Map<String, dynamic> toJson() => _data.toJson();

  // final List<Items> _list = [
  //   Items(
  //       logoType: "svg",
  //       logoUrl: "assets/logos/defaultLogo.svg",
  //       bankName: "Վարկային կազմակերպություն",
  //       type: "ՖԱՅԿՈ Սքոր զեկույց",
  //       purpose: "Նոր վարկի դիմում",
  //       date: DateFormat("dd.MM.yyyy").format(DateTime.now()),
  //       effect: false),
  //   Items(
  //       logoType: "image",
  //       logoUrl: "assets/logos/evk_logo1.png",
  //       bankName: "Էվոկա բանկ",
  //       type: "ՖԱՅԿՈ Սքոր զեկույց",
  //       purpose: "Նոր վարկի դիմում",
  //       date: DateFormat("dd.MM.yyyy").format(DateTime.now()),
  //       effect: true),
  //   Items(
  //       logoType: "image",
  //       // logoUrl: "assets/id_logo.svg",
  //       logoUrl: "assets/logos/id_logo1.png",
  //       bankName: "Այ Դի բանկ",
  //       type: "ՖԱՅԿՈ Սքոր զեկույց",
  //       purpose: "Նոր վարկի դիմում",
  //       date: DateFormat("dd.MM.yyyy").format(DateTime.now()),
  //       effect: false),
  //   Items(
  //       logoType: "svg",
  //       logoUrl: "assets/logos/defaultLogo.svg",
  //       bankName: "Վարկային կազմակերպություն",
  //       type: "ՖԱՅԿՈ Սքոր զեկույց",
  //       purpose: "Նոր վարկի դիմում",
  //       date: DateFormat("dd.MM.yyyy").format(DateTime.now()),
  //       effect: false),
  // ];
  MockData() : _data = CardData(items: []);

  CardData get data => _data;
}
