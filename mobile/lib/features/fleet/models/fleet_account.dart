class FleetAccount {
  const FleetAccount({
    required this.id,
    required this.name,
    required this.ownerUserId,
    this.billingEmail,
    this.monthlyBudgetCents,
    this.active = true,
  });

  final String id;
  final String name;
  final String ownerUserId;
  final String? billingEmail;
  final int? monthlyBudgetCents;
  final bool active;

  double? get monthlyBudget {
    final cents = monthlyBudgetCents;
    return cents == null ? null : cents / 100;
  }

  factory FleetAccount.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return FleetAccount(
      id: id,
      name: map['name'] as String? ?? 'Fleet',
      ownerUserId: map['ownerUserId'] as String? ?? '',
      billingEmail: map['billingEmail'] as String?,
      monthlyBudgetCents: map['monthlyBudgetCents'] as int?,
      active: map['active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ownerUserId': ownerUserId,
      'billingEmail': billingEmail,
      'monthlyBudgetCents': monthlyBudgetCents,
      'active': active,
    };
  }
}
