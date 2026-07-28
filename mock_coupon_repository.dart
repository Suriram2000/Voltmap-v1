import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../auth/application/auth_providers.dart';
import '../application/wallet_providers.dart';
import '../models/wallet_transaction.dart';

class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallet = ref.watch(walletProvider);
    final transactions = ref.watch(walletTransactionsProvider);
    final currency = NumberFormat.simpleCurrency(locale: 'en_US');

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wallet & Rewards',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(walletProvider);
          ref.invalidate(walletTransactionsProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            wallet.when(
              data: (account) => Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.tertiary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Available balance',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      currency.format(account.balance),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        const Icon(
                          Icons.stars,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${account.rewardPoints} reward points',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              loading: () => const Card(
                child: Padding(
                  padding: EdgeInsets.all(36),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              error: (error, _) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text('Unable to load wallet: $error'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => _showAddFunds(context, ref),
              icon: const Icon(Icons.add_card),
              label: const Text('Add Funds'),
            ),
            const SizedBox(height: 26),
            Text(
              'Recent transactions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 12),
            transactions.when(
              data: (items) {
                if (items.isEmpty) {
                  return const Card(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text('No wallet transactions yet.'),
                    ),
                  );
                }

                return Column(
                  children: items
                      .map(
                        (item) => _TransactionTile(
                          transaction: item,
                          currency: currency,
                        ),
                      )
                      .toList(),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, _) => Text(
                'Unable to load transactions: $error',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddFunds(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final user = ref.read(authStateProvider).valueOrNull;

    if (user == null) return;

    final controller = TextEditingController();

    final amount = await showDialog<double>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add wallet funds'),
        content: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          decoration: const InputDecoration(
            prefixText: r'$',
            labelText: 'Amount',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(
              dialogContext,
              double.tryParse(controller.text),
            ),
            child: const Text('Continue'),
          ),
        ],
      ),
    );

    controller.dispose();

    if (amount == null || amount <= 0) return;

    await ref.read(walletRepositoryProvider).addFunds(
          userId: user.uid,
          amountCents: (amount * 100).round(),
        );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({
    required this.transaction,
    required this.currency,
  });

  final WalletTransaction transaction;
  final NumberFormat currency;

  @override
  Widget build(BuildContext context) {
    final sign = transaction.isCredit ? '+' : '-';

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(
            transaction.isCredit
                ? Icons.arrow_downward
                : Icons.arrow_upward,
          ),
        ),
        title: Text(transaction.description),
        subtitle: Text(
          DateFormat.yMMMd().add_jm().format(
                transaction.createdAt,
              ),
        ),
        trailing: Text(
          '$sign${currency.format(transaction.amount)}',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: transaction.isCredit
                ? Colors.green
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
