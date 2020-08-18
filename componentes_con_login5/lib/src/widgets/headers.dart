import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconHeader extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final Color color1;
  final Color color2;

  const IconHeader(
      {@required this.icon,
      @required this.titulo,
      this.color1 = Colors.grey,
      this.color2 = Colors.blueGrey});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _IconHeaderBackground(color1: this.color1, color2: this.color2),
        /* SvgPicture.asset(
          "data/logo.svg",
          height: 350,
          width: 350,
        ), */
        Positioned(
          top: 80,
          left: 75,
          child: SvgPicture.asset(
            "data/logo.svg",
            height: 150,
            width: 150,
          ),
        ),
        /* Column(
          children: <Widget>[
            SizedBox(height: 90),
            FaIcon(FontAwesomeIcons.plus,
                size: 300, color: Colors.white.withOpacity(0.2))
          ],
        ) */
      ],
    );
  }
}

class _IconHeaderBackground extends StatelessWidget {
  final Color color1;
  final Color color2;

  const _IconHeaderBackground({
    Key key,
    @required this.color1,
    @required this.color2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(100),
              bottomRight: Radius.circular(100)),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[this.color1, this.color2])),
    );
  }
}

/////
class IconHeaderMenu extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final Color color1;
  final Color color2;

  const IconHeaderMenu(
      {@required this.icon,
      @required this.titulo,
      this.color1 = Colors.grey,
      this.color2 = Colors.blueGrey});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _IconHeaderBackground(color1: this.color1, color2: this.color2),
        /* SvgPicture.asset(
          "data/logo.svg",
          height: 350,
          width: 350,
        ), */
        Positioned(
            top: -50,
            left: -70,
            child: FaIcon(FontAwesomeIcons.plus,
                size: 300, color: Colors.white.withOpacity(0.2))),
        Column(
          children: <Widget>[
            SizedBox(height: 150, width: double.infinity),
            Text(this.titulo,
                style: TextStyle(fontSize: 35, color: Colors.white))
          ],
        )
      ],
    );
  }
}
