import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/application/auth_providers.dart';
import '../../coupons/data/coupon_repository.dart';
import '../../coupons/data/mock_coupon_repository.dart';
import '../data/firestore_wallet_repository.dart';
import '../data/wallet_repository.dart';
import '../models/wallet_account.dart';
import '../models/wallet_transaction.dart';

final walletRepositoryProvider = Provider<WalletRepository>(
  (ref) => FirestoreWalletRepository(),
);

final couponRepositoryProvider = Provider<CouponRepository>(
  (ref) => const MockCouponRepository(),
);

final walletProvider = StreamProvider<WalletAccount>((ref) {
  final user = ref.watch(authStateProvider).valueOrNull;

  if (user == null) {
    return const Stream.empty();
  }

  return ref.watch(walletRepositoryProvider).watchWallet(user.uid);
});

final walletTransactionsProvider =
    StreamProvider<List<WalletTransaction>>((ref) {
  final user = ref.watch(authStateProvider).valueOrNull;

  if (user == null) {
    return const Stream.empty();
  }

  return ref
      .watch(walletRepositoryProvider)
      .watchTransactions(user.uid);
});
