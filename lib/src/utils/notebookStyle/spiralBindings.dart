import 'package:flutter/material.dart';

class SpiralBinding extends StatelessWidget {
  const SpiralBinding({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: List.generate(
              20,
              (i) => Container(
                margin: EdgeInsets.only(top: i == 0 ? 20 : 0, bottom: 14),
                width: 18,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF252525),
                  border: Border.all(
                    color: const Color(0xFF4A4A4A),
                    width: 2.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                    // inner highlight to give it a metallic feel
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.04),
                      blurRadius: 1,
                      offset: const Offset(0, -1),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
