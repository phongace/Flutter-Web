import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_store/providers/token-provider.dart';
import 'package:time_store/router/routing-name.dart';
import 'package:time_store/screens/home/home-page.dart';
import 'package:time_store/screens/table/table-comments-api.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  List<bool> selected = [true, false, false, false, false];

  List listPage = [HomePage(), TableComments()];

  void select(int n) {
    for (var i = 0; i < 5; i++) {
      if (i != n) {
        selected[i] = false;
      } else {
        selected[i] = true;
      }
      for (var j = 0; j < listPage.length; j++) {
        if (j != n) {
          selected[j] = false;
        } else {
          selected[j] = true;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    print(selected);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 100.0,
        color: Color(0xFF333951),
        child: Stack(
          children: [
            _name(),
            buildAlign(),
            Align(
              alignment: Alignment.bottomCenter,
              child: NavBarItem(
                  active: false,
                  icon: Icons.logout,
                  touched: () {
                    Provider.of<TokenProvider>(context, listen: false).removeToken();
                    Navigator.pushNamedAndRemoveUntil(context, RoutingNameConstant.Login, (route) => false);
                  }),
            )
          ],
        ),
      ),
    );
  }

  Align buildAlign() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 350.0,
        child: Column(
          children: [
            NavBarItem(
              active: selected[0],
              icon: Icons.home,
              touched: () {
                setState(() {
                  select(0);
                  Navigator.pushNamed(context, RoutingNameConstant.Home);
                });
              },
            ),
            NavBarItem(
              active: selected[1],
              icon: Icons.list,
              touched: () {
                setState(() {
                  select(1);
                });
                Navigator.pushNamed(context, RoutingNameConstant.Table);
              },
            ),
            NavBarItem(
              active: selected[2],
              icon: Icons.folder,
              touched: () {
                setState(() {
                  select(2);
                });
              },
            ),
            NavBarItem(
              active: selected[3],
              icon: Icons.message,
              touched: () {
                setState(() {
                  select(3);
                });
              },
            ),
            NavBarItem(
              active: selected[4],
              icon: Icons.settings,
              touched: () {
                setState(() {
                  select(4);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Container _name() {
    return Container(
      height: 70.0,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'A',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            Text(
              'lex',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.white,
                fontSize: 16.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NavBarItem extends StatefulWidget {
  final IconData icon;
  final Function touched;
  final bool active;

  const NavBarItem({Key key, this.icon, this.touched, this.active}) : super(key: key);

  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          widget.touched();
        },
        splashColor: Colors.white,
        hoverColor: Colors.white12,
        child: Container(
          height: 70.0,
          width: 100.0,
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 475),
                height: 35.0,
                width: 5.0,
                decoration: BoxDecoration(
                  color: widget.active ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Icon(
                  widget.icon,
                  color: widget.active ? Colors.white : Colors.white54,
                  size: 19.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
