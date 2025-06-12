class User {
  int? userId;
  String? name;
  String? email;
  int? phone;
  String? userQualification;
  String? college;
  List<String>? userInterests;

  User(
      {this.userId,
        this.name,
        this.email,
        this.phone,
        this.userQualification,
        this.college,
        this.userInterests});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    userQualification = json['user_qualification'];
    college = json['college'];
    userInterests = json['user_interests'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['user_qualification'] = this.userQualification;
    data['college'] = this.college;
    data['user_interests'] = this.userInterests;
    return data;
  }

  double getFilledPercentage() {
    int totalFields = 7; // total fields in the User class
    int filledFields = 0;

    // List of all fields in the User class
    List<dynamic> fields = [
      userId,
      name,
      email,
      phone,
      userQualification,
      college,
      userInterests
    ];

    // Count the number of non-null fields
    for (var field in fields) {
      if (field != null) {
        filledFields++;
      }
    }

    // Calculate the percentage
    return (filledFields / totalFields) * 100;
  }

}
