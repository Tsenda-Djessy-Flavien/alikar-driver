class MissionsModel {
  String? driverId;
  int? price;
  int? extraHourPrice;
  int? extraHour;
  String? status;
  String? beginAt;
  String? finishAt;
  String? mustFinishAt;
  String? delyTime;
  String? sId;
  String? userId;
  String? typeOffer;
  String? serveiceId;
  int? oldPrice;
  String? type;
  String? typeSubscription;
  String? createdAt;
  // CarAddress? carAddress;
  Address? address;
  String? keyContact;
  bool? withCar;
  String? obs;
  String? date;
  int? nbrtHour;
  int? startHour;


  MissionsModel({this.driverId, this.price, this.extraHourPrice, this.extraHour, this.status, this.beginAt, this.finishAt, this.mustFinishAt, this.delyTime, this.sId, this.userId, this.typeOffer, this.serveiceId, this.oldPrice, this.type, this.typeSubscription, this.createdAt, /*this.carAddress,*/ this.address, this.keyContact, this.withCar, this.obs, this.date, this.nbrtHour, this.startHour});

  MissionsModel.fromJson(Map<String, dynamic> json) {
    driverId = json['driverId'];
    price = json['price'];
    extraHourPrice = json['extraHourPrice'];
    extraHour = json['extraHour'];
    status = json['status'];
    beginAt = json['beginAt'];
    finishAt = json['finishAt'];
    mustFinishAt = json['mustFinishAt'];
    delyTime = json['delyTime'];
    sId = json['_id'];
    userId = json['userId'];
    typeOffer = json['typeOffer'];
    serveiceId = json['serveiceId'];
    oldPrice = json['oldPrice'];
    type = json['type'];
    typeSubscription = json['typeSubscription'];
    createdAt = json['createdAt'];
  //  carAddress = json['carAddress'] != null ? new CarAddress.fromJson(json['carAddress']) : null;
    address = json['address'] != null ? new Address.fromJson(json['address']) : null;
    keyContact = json['keyContact'];
    withCar = json['withCar'];
    obs = json['obs'];
    date = json['date'];
    nbrtHour = json['nbrtHour'];
    startHour = json['startHour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driverId'] = driverId;
    data['price'] = price;
    data['extraHourPrice'] = extraHourPrice;
    data['extraHour'] = extraHour;
    data['status'] = status;
    data['beginAt'] = beginAt;
    data['finishAt'] = finishAt;
    data['mustFinishAt'] = mustFinishAt;
    data['delyTime'] = delyTime;
    data['_id'] = sId;
    data['userId'] = userId;
    data['typeOffer'] = typeOffer;
    data['serveiceId'] = serveiceId;
    data['oldPrice'] = oldPrice;
    data['type'] = type;
    data['typeSubscription'] = typeSubscription;
    data['createdAt'] = createdAt;
  //  if (carAddress != null) {data['carAddress'] = carAddress!.toJson();}
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['keyContact'] = keyContact;
    data['withCar'] = withCar;
    data['obs'] = obs;
    data['date'] = date;
    data['nbrtHour'] = nbrtHour;
    data['startHour'] = startHour;
    return data;
  }
}

//
class Address {
  String? nameAddress;
  String? sId;

  Address({this.nameAddress, this.sId});

  Address.fromJson(Map<String, dynamic> json) {
    nameAddress = json['nameAddress'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameAddress'] = nameAddress;
    data['_id'] = sId;
    return data;
  }
}