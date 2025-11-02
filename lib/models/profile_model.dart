class Profile {
  final String name;
  final String profession;
  final String bio;
  final String email;
  final String phone;
  final String location;
  final List<Skill> skills;
  final List<String> education;
  final List<String> hobbies;

  const Profile({
    required this.name,
    required this.profession,
    required this.bio,
    required this.email,
    required this.phone,
    required this.location,
    required this.skills,
    required this.education,
    required this.hobbies,
  });
}

class Skill {
  final String name;
  final double level; // 0.0 – 1.0

  const Skill(this.name, this.level);
}
