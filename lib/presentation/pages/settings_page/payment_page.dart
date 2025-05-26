import 'package:flutter/material.dart';
import 'package:movie/core/utils/components/button.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/core/utils/typography.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  static String tag = 'payment-page';

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment',
          style: Typographies.heading4,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 72,
              ),
              Text(
                'Select the payment method you want to use.',
                style: Typographies.bodyLargeMedium,
              ),
              const SizedBox(
                height: 32,
              ),
              const PaymentTypeItem(title: 'PayPal'),
              const SizedBox(
                height: 32,
              ),
              const PaymentTypeItem(title: 'Google Pay'),
              const SizedBox(
                height: 32,
              ),
              const PaymentTypeItem(title: 'Apple Pay'),
              const SizedBox(
                height: 32,
              ),
              const PaymentTypeItem(title: '•••• •••• •••• •••• 4679'),
              const SizedBox(
                height: 32,
              ),
              const Buttons.secondary(text: 'Add New Card'),
              const SizedBox(
                height: 72,
              ),
              const Buttons.primary(text: 'Continue'),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentTypeItem extends StatelessWidget {
  const PaymentTypeItem({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          AppIcons.icGoogle,
          const SizedBox(
            width: 12,
          ),
          Text(
            title,
            style: Typographies.heading6,
          ),
          AppIcons.icProfileSubscribetionCheckboxUnselected
        ],
      ),
    );
  }
}
