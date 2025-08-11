import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const ProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: List.generate(totalSteps * 2 - 1, (index) {
          if (index.isEven) {
            // Bolinha
            final stepIndex = index ~/ 2;
            final isActive = stepIndex <= currentStep;
            return Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive
                    ? const Color(0xFF71A151)
                    : const Color(0xFFD9D9D9),
              ),
            );
          } else {
            final barIndex = (index - 1) ~/ 2;
            final isActive = barIndex < currentStep;
            return Expanded(
              child: Container(
                height: 5,
                color: isActive
                    ? const Color(0xFF71A151)
                    : const Color(0xFFD9D9D9),
              ),
            );
          }
        }),
      ),
    );
  }
}