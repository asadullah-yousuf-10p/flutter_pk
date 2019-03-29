import 'package:flutter/material.dart';
import 'package:sprung/sprung.dart';

typedef void BoolCallback(bool val);

class SprungBox extends StatefulWidget {
  final Damped damped;
  final Duration duration;
  final BoolCallback callback;
  final String sponsorImageUrl;

  SprungBox({
    this.damped = Damped.over,
    this.callback,
    this.sponsorImageUrl,
    duration,
  }) : this.duration = duration ?? Duration(milliseconds: 3500);

  @override
  _SprungBoxState createState() => _SprungBoxState();
}

class _SprungBoxState extends State<SprungBox>
    with SingleTickerProviderStateMixin {
  bool _isOffset = false;
  bool showFlag = false;

  @override
  void initState() {
    super.initState();
    _toggleOffset();
  }

  void _toggleOffset() async {
    await Future.delayed(
      new Duration(milliseconds: 500),
      () => setState(() {
            this._isOffset = !this._isOffset;
          }),
    );
    await Future.delayed(
      new Duration(milliseconds: 1500),
      () => widget.callback(true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxWidth * 2;
        final left = !this._isOffset ? height + 100.0 : 40.0;

        final width = MediaQuery.of(context).size.width * 2;

        return Padding(
          padding: const EdgeInsets.only(right: 48.0),
          child: AnimatedContainer(
            duration: this.widget.duration,
            curve: Sprung(damped: this.widget.damped),
            margin: EdgeInsets.only(
              left: left,
            ),
            height: 400.0,
            width: width,
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 30,
                        child: Image(
                          image: AssetImage('assets/10p_uni_logo.png'),
                        ),
                      ),
                      SizedBox(width: 16),
                      Container(
                        height: 16,
                        width: 2,
                        color: Theme.of(context).dividerColor,
                      ),
                      SizedBox(width: 8),
                      Container(
                        height: 30,
                        child: Image(
                          image: AssetImage('assets/flutterKarachi.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 180,
                  child: Image(
                    image: AssetImage('assets/wtq_splash.png'),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Powered By:',
                  style: Theme.of(context).textTheme.subtitle,
                ),
                SizedBox(height: 8),
                Container(
                  height: 60,
                  child: widget.sponsorImageUrl != null
                      ? Image.network(widget.sponsorImageUrl)
                      : null,
                ),
              ],
            ),
          ),
          /* ),*/
        );
      },
    );
  }
}
