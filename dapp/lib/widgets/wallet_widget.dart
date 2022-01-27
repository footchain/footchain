import 'package:flutter/material.dart';

import '../dto/user_dto.dart';

class WalletWidget extends StatelessWidget {
  final UserDto user;
  const WalletWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TokenBalanceWidget(balance: user.balance),
        const SizedBox(
          width: 16,
        ),
        WalletNumberWidget(
          address: user.address!,
        ),
      ],
    );
  }
}

class WalletNumberWidget extends StatelessWidget {
  final String address;
  const WalletNumberWidget({Key? key, required this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.white),
          top: BorderSide(color: Colors.white),
          bottom: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${address.substring(0, 6)}...${address.substring(address.length - 3)}',
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 20),
          ),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
    );
  }
}

class TokenBalanceWidget extends StatelessWidget {
  final String? balance;
  const TokenBalanceWidget({Key? key, this.balance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.white),
          bottom: BorderSide(color: Colors.white),
          top: BorderSide(color: Colors.transparent),
          left: BorderSide(color: Colors.transparent),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Text(
        '\$FTC: ${balance ?? '0'}',
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
      ),
    );
  }
}
