import 'package:flutter/material.dart';

class TopbarWidget extends StatelessWidget {
  final String title;

  final VoidCallback onMenuPressed;
  final String roleName;

  const TopbarWidget({
    super.key,

    required this.title,

    required this.onMenuPressed,
    required this.roleName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(bottom: BorderSide(color: Color(0xffe2e8f0))),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton.filledTonal(
            onPressed: onMenuPressed,
            tooltip: 'Menu',
            icon: const Icon(Icons.menu),
          ),
          const SizedBox(width: 14),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff0f172a),
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Gestion operativa de cartera',
                style: TextStyle(fontSize: 12, color: Color(0xff64748b)),
              ),
            ],
          ),
          const Spacer(),
          Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xfff8fafc),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: const Color(0xffe2e8f0)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.verified_user,
                  size: 17,
                  color: Color(0xff14532d),
                ),
                const SizedBox(width: 8),
                Text(
                  roleName,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const CircleAvatar(
            radius: 19,
            backgroundColor: Color(0xffdcfce7),
            child: Icon(Icons.person, color: Color(0xff14532d)),
          ),
        ],
      ),
    );
  }
}
