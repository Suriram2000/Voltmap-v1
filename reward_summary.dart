class WalletAccount {
  const WalletAccount({
    required this.userId,
    this.balanceCents = 0,
    this.rewardPoints = 0,
    this.updatedAt,
  });

  final String userId;
  final int balanceCents;
  final int rewardPoints;
  final DateTime? updatedAt;

  double get balance => balanceCents / 100;

  WalletAccount copyWith({
    int? balanceCents,
    int? rewardPoints,
    DateTime? updatedAt,
  }) {
    return WalletAccount(
      userId: userId,
      balanceCents: balanceCents ?? this.balanceCents,
      rewardPoints: rewardPoints ?? this.rewardPoints,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'balanceCents': balanceCents,
      'rewardPoints': rewardPoints,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory WalletAccount.fromMap(Map<String, dynamic> map) {
    return WalletAccount(
      userId: map['userId'] as String? ?? '',
      balanceCents: map['balanceCents'] as int? ?? 0,
      rewardPoints: map['rewardPoints'] as int? ?? 0,
      updatedAt: DateTime.tryParse(
        map['updatedAt'] as String? ?? '',
      ),
    );
  }
}
