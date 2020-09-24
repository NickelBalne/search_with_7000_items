class User {
  String ctry;
  String peopnameincountry;
  int population;
  String primarylanguagename;
  int biblestatus;
  String primaryreligion;
  String continent;

  User(
      {this.ctry,
        this.peopnameincountry,
        this.population,
        this.primarylanguagename,
        this.biblestatus,
        this.primaryreligion,
        this.continent});

  User.fromJson(Map<String, dynamic> json) {
    ctry = json['ctry'];
    peopnameincountry = json['peopnameincountry'];
    population = json['population'];
    primarylanguagename = json['primarylanguagename'];
    biblestatus = json['biblestatus'];
    primaryreligion = json['primaryreligion'];
    continent = json['continent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ctry'] = this.ctry;
    data['peopnameincountry'] = this.peopnameincountry;
    data['population'] = this.population;
    data['primarylanguagename'] = this.primarylanguagename;
    data['biblestatus'] = this.biblestatus;
    data['primaryreligion'] = this.primaryreligion;
    data['continent'] = this.continent;
    return data;
  }
}

