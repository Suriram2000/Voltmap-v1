import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/wallet_account.dart';
import '../models/wallet_transaction.dart';
import 'wallet_repository.dart';

class FirestoreWalletRepository implements WalletRepository {
  FirestoreWalletRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _wallets =>
      _firestore.collection('wallets');

  CollectionReference<Map<String, dynamic>> _transactions(
    String userId,
  ) {
    return _wallets.doc(userId).collection('transactions');
  }

  @override
  Stream<WalletAccount> watchWallet(String userId) {
    return _wallets.doc(userId).snapshots().map((snapshot) {
      final data = snapshot.data();

      if (data == null) {
        return WalletAccount(userId: userId);
      }

      return WalletAccount.fromMap(data);
    });
  }

  @override
  Stream<List<WalletTransaction>> watchTransactions(String userId) {
    return _transactions(userId)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (document) => WalletTransaction.fromMap(
                  document.id,
                  document.data(),
                ),
              )
              .toList(),
        );
  }

  @override
  Future<void> addFunds({
    required String userId,
    required int amountCents,
  }) async {
    if (amountCents <= 0) {
      throw ArgumentError.value(
        amountCents,
        'amountCents',
        'Amount must be greater than zero.',
      );
    }

    final walletReference = _wallets.doc(userId);
    final transactionReference = _transactions(userId).doc();

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(walletReference);
      final currentBalance =
          snapshot.data()?['balanceCents'] as int? ?? 0;

      transaction.set(
        walletReference,
        {
          'userId': userId,
          'balanceCents': currentBalance + amountCents,
          'updatedAt': DateTime.now().toIso8601String(),
        },
        SetOptions(merge: true),
      );

      transaction.set(transactionReference, {
        'userId': userId,
        'type': WalletTransactionType.topUp.name,
        'amountCents': amountCents,
        'description': 'Wallet top-up',
        'createdAt': DateTime.now().toIso8601String(),
      });
    });
  }

  @override
  Future<void> deductFunds({
    required String userId,
    required int amountCents,
    required String description,
  }) async {
    final walletReference = _wallets.doc(userId);
    final transactionReference = _transactions(userId).doc();

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(walletReference);
      final currentBalance =
          snapshot.data()?['balanceCents'] as int? ?? 0;

      if (currentBalance < amountCents) {
        throw StateError('Insufficient wallet balance.');
      }

      transaction.update(walletReference, {
        'balanceCents': currentBalance - amountCents,
        'updatedAt': DateTime.now().toIso8601String(),
      });

      transaction.set(transactionReference, {
        'userId': userId,
        'type': WalletTransactionType.chargingPayment.name,
        'amountCents': amountCents,
        'description': description,
        'createdAt': DateTime.now().toIso8601String(),
      });
    });
  }
}
