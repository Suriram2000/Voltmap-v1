import '../models/wallet_account.dart';
import '../models/wallet_transaction.dart';

abstract interface class WalletRepository {
  Stream<WalletAccount> watchWallet(String userId);
  Stream<List<WalletTransaction>> watchTransactions(String userId);
  Future<void> addFunds({
    required String userId,
    required int amountCents,
  });
  Future<void> deductFunds({
    required String userId,
    required int amountCents,
    required String description,
  });
}
