class SignupModel {
  String? _fullName;
  String? _email;
  String? _address;
  int? _phone;
  String? _password;

  SignupModel(
      {String? fullName,
      String? email,
      String? address,
      int? phone,
      String? password}) {
    if (fullName != null) {
      this._fullName = fullName;
    }
    if (email != null) {
      this._email = email;
    }
    if (address != null) {
      this._address = address;
    }
    if (phone != null) {
      this._phone = phone;
    }
    if (password != null) {
      this._password = password;
    }
  }

  String? get fullName => _fullName;
  set fullName(String? fullName) => _fullName = fullName;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get address => _address;
  set address(String? address) => _address = address;
  int? get phone => _phone;
  set phone(int? phone) => _phone = phone;
  String? get password => _password;
  set password(String? password) => _password = password;

  SignupModel.fromJson(Map<String, dynamic> json) {
    _fullName = json['full_Name'];
    _email = json['email'];
    _address = json['address'];
    _phone = json['phone'];
    _password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_Name'] = this._fullName;
    data['email'] = this._email;
    data['address'] = this._address;
    data['phone'] = this._phone;
    data['password'] = this._password;
    return data;
  }
}
