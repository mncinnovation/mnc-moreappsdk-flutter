import 'dart:convert';

class LayoutModel {
  String? layoutType;
  int? cardShadowOpacity;
  int? cardRoundedSize;
  String? buttonColor;
  String? buttonTextColor;
  int? buttonRoundedSize;
  int? buttonShadow;
  LayoutModel({
    this.layoutType,
    this.cardShadowOpacity,
    this.cardRoundedSize,
    this.buttonColor,
    this.buttonTextColor,
    this.buttonRoundedSize,
    this.buttonShadow,
  });

  Map<String, dynamic> toMap() {
    return {
      'layoutType': layoutType,
      'cardShadowOpacity': cardShadowOpacity,
      'cardRoundedSize': cardRoundedSize,
      'buttonColor': buttonColor,
      'buttonTextColor': buttonTextColor,
      'buttonRoundedSize': buttonRoundedSize,
      'buttonShadow': buttonShadow,
    };
  }

  factory LayoutModel.fromMap(Map<String, dynamic> map) {
    return LayoutModel(
      layoutType: map['layoutType'],
      cardShadowOpacity: map['cardShadowOpacity'],
      cardRoundedSize: map['cardRoundedSize'],
      buttonColor: map['buttonColor'],
      buttonTextColor: map['buttonTextColor'],
      buttonRoundedSize: map['buttonRoundedSize'],
      buttonShadow: map['buttonShadow'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LayoutModel.fromJson(String source) =>
      LayoutModel.fromMap(json.decode(source));
}
