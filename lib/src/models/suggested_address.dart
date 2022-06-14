class Suggested {
  Properties? properties;

  Suggested({this.properties});

  Suggested.fromJson(Map<String, dynamic> json) {
    properties = json['properties'] != null
        ? Properties.fromJson(json['properties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (properties != null) {
      data['properties'] = properties!.toJson();
    }
    return data;
  }
}

class Properties {
  int? osmId;
  List<double>? extent;
  String? country;
  String? city;
  String? countrycode;
  String? postcode;
  String? locality;
  String? county;
  String? type;
  String? osmType;
  String? osmKey;
  String? district;
  String? osmValue;
  String? name;
  String? state;

  Properties(
      {this.osmId,
      this.extent,
      this.country,
      this.city,
      this.countrycode,
      this.postcode,
      this.locality,
      this.county,
      this.type,
      this.osmType,
      this.osmKey,
      this.district,
      this.osmValue,
      this.name,
      this.state});

  Properties.fromJson(Map<String, dynamic> json) {
    osmId = json['osm_id'];
    extent = json['extent'].cast<double>();
    country = json['country'];
    city = json['city'];
    countrycode = json['countrycode'];
    postcode = json['postcode'];
    locality = json['locality'];
    county = json['county'];
    type = json['type'];
    osmType = json['osm_type'];
    osmKey = json['osm_key'];
    district = json['district'];
    osmValue = json['osm_value'];
    name = json['name'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['osm_id'] = osmId;
    data['extent'] = extent;
    data['country'] = country;
    data['city'] = city;
    data['countrycode'] = countrycode;
    data['postcode'] = postcode;
    data['locality'] = locality;
    data['county'] = county;
    data['type'] = type;
    data['osm_type'] = osmType;
    data['osm_key'] = osmKey;
    data['district'] = district;
    data['osm_value'] = osmValue;
    data['name'] = name;
    data['state'] = state;
    return data;
  }
}
