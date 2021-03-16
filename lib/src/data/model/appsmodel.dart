import 'dart:convert';

class AppsModel {
  String? appID;
  String? appName;
  String? webUrl;
  String? youtube;
  String? image;
  String? open;
  int? order;
  Translation? category;
  Translation? description;
  AppMeta? android;
  AppMeta? ios;
  AppsModel({
    this.appID,
    this.appName,
    this.webUrl,
    this.youtube,
    this.image,
    this.open,
    this.order,
    this.category,
    this.description,
    this.android,
    this.ios,
  });

  Map<String, dynamic> toMap() {
    return {
      'appID': appID,
      'appName': appName,
      'webUrl': webUrl,
      'youtube': youtube,
      'image': image,
      'open': open,
      'order': order,
      'category': category?.toMap(),
      'description': description?.toMap(),
      'android': android?.toMap(),
      'ios': ios?.toMap(),
    };
  }

  factory AppsModel.fromMap(Map<String, dynamic> map) {
    return AppsModel(
      appID: map['appID'],
      appName: map['appName'],
      webUrl: map['webUrl'],
      youtube: map['youtube'],
      image: map['image'],
      open: map['open'],
      order: map['order'],
      category: Translation.fromMap(map['category']),
      description: Translation.fromMap(map['description']),
      android: AppMeta.fromMap(map['android']),
      ios: AppMeta.fromMap(map['ios']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppsModel.fromJson(String source) => AppsModel.fromMap(json.decode(source));
}

class AppMeta {
  String? scheme;
  String? store;
  AppMeta({
    this.scheme,
    this.store,
  });

  Map<String, dynamic> toMap() {
    return {
      'scheme': scheme,
      'store': store,
    };
  }

  factory AppMeta.fromMap(Map<String, dynamic> map) {
    return AppMeta(
      scheme: map['scheme'],
      store: map['store'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppMeta.fromJson(String source) => AppMeta.fromMap(json.decode(source));
}

class Translation {
  String? en;
  String? id;
  Translation({
    this.en,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'en': en,
      'id': id,
    };
  }

  factory Translation.fromMap(Map<String, dynamic> map) {
    return Translation(
      en: map['en'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Translation.fromJson(String source) => Translation.fromMap(json.decode(source));
}
