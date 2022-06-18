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
  String? country;
  String? city;
  String? name;
  String? state;
  String? houseNumber;
  String? street;

  Properties(
      {this.country,
      this.city,
      this.name,
      this.state,
      this.houseNumber,
      this.street});

  Properties.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    city = json['city'];
    name = json['name'];
    state = json['state'];
    houseNumber = json['housenumber'];
    street = json['street'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['city'] = city;
    data['name'] = name;
    data['state'] = state;
    data['housenumber'] = houseNumber;
    data['street'] = street;
    return data;
  }
}
