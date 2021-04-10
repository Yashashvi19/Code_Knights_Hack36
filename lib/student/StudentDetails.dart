class StudentDetails {
  String name;
  String course;
  String specialization;
  String institute;
  String username;
  String email;
  String password;
  StudentDetails({this.name, this.course, this.specialization, this.institute, this.username, this.email, this.password});

  factory StudentDetails.fromJson(Map<String, dynamic> json){
    return StudentDetails(name: json['name'],
      course: json['course'],
      specialization: json['specialization'],
      institute: json['institute'],
      username: json['username'],
      email: json['email'],
      password: json['password'],);
  }
}