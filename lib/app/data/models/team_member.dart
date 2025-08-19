class TeamMember {
  final int rank; // new field for leaderboard
  final String name;
  final String status; // can be used as location or role
  final bool isActive; // can determine topper maybe
  final int progress; // score percentage
  final String startTime; // optional, can be used for additional info
  final String avatarLetter; // first letter for avatar
  final String location; // first letter for avatar

  TeamMember({
    required this.rank,
    required this.name,
    required this.status,
    required this.isActive,
    required this.progress,
    required this.startTime,
    required this.avatarLetter,
    required this.location,
  });
}
