class UserModel {
  final String? uid;
  final String? phoneNumber;
  final String? displayName;
  final String? photoUrl;
  final String? mode;
  final String? address;
  final String? email;
  final String? dateOfBirth;
  final String? gender;

  UserModel({
    required this.uid,
    required this.phoneNumber,
    this.displayName,
    this.photoUrl,
    this.mode,
    this.address,
    this.email,
    this.dateOfBirth,
    this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phoneNumber': phoneNumber,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'mode': mode,
      'address': address,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
    };
  }

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String?,
      phoneNumber: map['phoneNumber'] as String?,
      displayName: map['displayName'] as String?,
      photoUrl: map['photoUrl'] as String?,
      mode: map['mode'] as String?,
      address: map['address'] as String?,
      email: map['email'] as String?,
      dateOfBirth: map['dateOfBirth'] as String?,
      gender: map['gender'] as String?,
    );
  }

  UserModel copyWith({
    String? uid,
    String? phoneNumber,
    String? displayName,
    String? photoUrl,
    String? mode,
    String? address,
    String? email,
    String? dateOfBirth,
    String? gender,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      mode: mode ?? this.mode,
      address: address ?? this.address,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, phoneNumber: $phoneNumber, displayName: $displayName, photoUrl: $photoUrl, mode: $mode, address: $address, email: $email, dateOfBirth: $dateOfBirth, gender: $gender)';
  }
}
