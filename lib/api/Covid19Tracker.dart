class Covid19Tracker {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
  String date;
  List<Countries> countries;
  int confirmed;
  int deaths;
  int recovered;
  int active;
  int deltaConfirmed;
  int deltaDeaths;
  int deltaRecovered;
  int deltaActive;

  Covid19Tracker(
      {this.date,
      this.countries,
      this.confirmed,
      this.deaths,
      this.recovered,
      this.active,
      this.deltaConfirmed,
      this.deltaDeaths,
      this.deltaRecovered,
      this.deltaActive});

  Covid19Tracker.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['countries'] != null) {
      countries = new List<Countries>();
      json['countries'].forEach((v) {
        countries.add(new Countries.fromJson(v));
      });
    }
    confirmed = json['confirmed'];
    deaths = json['deaths'];
    recovered = json['recovered'];
    active = json['active'];
    deltaConfirmed = json['deltaConfirmed'];
    deltaDeaths = json['deltaDeaths'];
    deltaRecovered = json['deltaRecovered'];
    deltaActive = json['deltaActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.countries != null) {
      data['countries'] = this.countries.map((v) => v.toJson()).toList();
    }
    data['confirmed'] = this.confirmed;
    data['deaths'] = this.deaths;
    data['recovered'] = this.recovered;
    data['active'] = this.active;
    data['deltaConfirmed'] = this.deltaConfirmed;
    data['deltaDeaths'] = this.deltaDeaths;
    data['deltaRecovered'] = this.deltaRecovered;
    data['deltaActive'] = this.deltaActive;
    return data;
  }
}

class Countries {
  String country;
  String countryCode;

  int confirmed;
  int deaths;
  int recovered;
  int active;
  String updatedAt;
  int deltaConfirmed;
  int deltaDeaths;
  int deltaRecovered;
  int deltaActive;

  Countries(
      {this.country,
      this.countryCode,
      this.confirmed,
      this.deaths,
      this.recovered,
      this.active,
      this.updatedAt,
      this.deltaConfirmed,
      this.deltaDeaths,
      this.deltaRecovered,
      this.deltaActive});

  Countries.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    countryCode = json['countryCode'];
    confirmed = json['confirmed'];
    deaths = json['deaths'];
    recovered = json['recovered'];
    active = json['active'];
    updatedAt = json['updatedAt'];
    deltaConfirmed = json['deltaConfirmed'];
    deltaDeaths = json['deltaDeaths'];
    deltaRecovered = json['deltaRecovered'];
    deltaActive = json['deltaActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['countryCode'] = this.countryCode;
    data['confirmed'] = this.confirmed;
    data['deaths'] = this.deaths;
    data['recovered'] = this.recovered;
    data['active'] = this.active;
    data['updatedAt'] = this.updatedAt;
    data['deltaConfirmed'] = this.deltaConfirmed;
    data['deltaDeaths'] = this.deltaDeaths;
    data['deltaRecovered'] = this.deltaRecovered;
    data['deltaActive'] = this.deltaActive;
    return data;
  }
}
