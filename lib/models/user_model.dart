class UserModel {
  final String name;
  final String profilePic;
  final String uid;
  UserModel({
    required this.name,
    required this.profilePic,
    required this.uid,
  });

  UserModel copyWith({
    String? name,
    String? profilePic,
    String? uid,
  }) {
    return UserModel(
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return{
      'name': name,
      'profilePic': profilePic,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      profilePic: map['profilePic'] as String,
      uid: map['uid'] as String,
    );
  }

  @override
  String toString() =>
      'UserModel(name: $name, profilePic: $profilePic, uid: $uid)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.profilePic == profilePic &&
        other.uid == uid;
  }

  @override
  int get hashCode => name.hashCode ^ profilePic.hashCode ^ uid.hashCode;
}
