class Origin {
  String? ip;
  String? city;
  String? region;
  String? country;
  String? loc;
  String? org;
  String? timezone;

  Origin(
      {this.ip,
        this.city,
        this.region,
        this.country,
        this.loc,
        this.org,
        this.timezone});

  Origin.fromJson(Map<String, dynamic> json) {
    ip = json['ip'];
    city = json['city'];
    region = json['region'];
    country = json['country'];
    loc = json['loc'];
    org = json['org'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ip'] = ip;
    data['city'] = city;
    data['region'] = region;
    data['country'] = country;
    data['loc'] = loc;
    data['org'] = org;
    data['timezone'] = timezone;
    return data;
  }
}

Origin originModelInstance = Origin();