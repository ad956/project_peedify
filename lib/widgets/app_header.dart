import 'package:flutter/material.dart';

class HalfCircleShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.5);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 80,
      size.width,
      size.height * 0.5,
    );
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final Widget actionButtons;

  const AppHeader({Key? key, required this.actionButtons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HalfCircleShape(),
      child: Container(
        color: Colors.red,
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: const Icon(Icons.settings, color: Colors.white),
                title: const Text(
                  'Peedify',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                actions: const [
                  Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Icon(Icons.star, color: Colors.yellow),
                  ),
                ],
              ),
              actionButtons,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 80);
}
