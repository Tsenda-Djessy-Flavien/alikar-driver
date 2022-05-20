class Country {
  List<CountryModel>? countryModel;

  Country({this.countryModel});

  Country.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      countryModel = <CountryModel>[];
      json['results'].forEach((v) {
        countryModel!.add(CountryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (countryModel != null) {
      data['results'] = countryModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CountryModel {
  String? sId;
  String? name;
  String? code;
  String? iso;
  String? currency;
  String? dialCode;

  CountryModel(
      {this.sId,
        this.name,
        this.code,
        this.iso,
        this.currency,
        this.dialCode});

  CountryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    code = json['code'];
    iso = json['iso'];
    currency = json['currency'];
    dialCode = json['dialCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['name'] = name;
    data['code'] = code;
    data['iso'] = iso;
    data['currency'] = currency;
    data['dialCode'] = dialCode;
    return data;
  }
}


CountryModel countryModelInstance = CountryModel();
