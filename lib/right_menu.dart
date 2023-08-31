import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RightMenu {

  static Future showRightMenu(BuildContext context, dx, dy,
      {required List<MapEntry<String, dynamic>> items, required Size size, required Widget menu}) async {
    double sw = MediaQuery.of(context).size.width; //screen width
    double sh = MediaQuery.of(context).size.height; //screen height
    Border border = dy < sh / 2
        ? //
        Border(top: BorderSide(color: Colors.green[200]!, width: 2))
        : Border(bottom: BorderSide(color: Colors.green[200]!, width: 2));
//Generate menu based on item
    if (items != null && items.length > 0) {
      double itemWidth = 100.0;
      double itemHeight = 50.0;
      double menuHeight = itemHeight * items.length + 2;

      size = Size(itemWidth, menuHeight);

      menu = Container(
        decoration: BoxDecoration(color: Colors.white, border: border),
        child: Column(
          children: items
              .map<Widget>((e) => InkWell(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: itemWidth,
                      height: itemHeight,
                      child: Text(
                        e.key,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context, e.value);
                    },
                  ))
              .toList(),
        ),
      );
    }
    Size sSize = MediaQuery.of(context).size;

// PopupMenuItem

    double menuW = size.width; //Menu width
    double menuH = size.height; //Menu height

    double endL = dx < sw / 2 ? dx : dx - menuW;
    double endT = dy < sh / 2 ? dy : dy - menuH;
    double endR = dx < sw / 2 ? dx + menuW : dx;
    double endB = dy < sh / 2 ? dy + menuH : dy;

    return await showGeneralDialog(
        context: context,
        pageBuilder: (context, anim1, anim2) {

          return SingleChildScrollView(child: menu);
        },
        barrierColor: Colors.grey.withOpacity(0),

        barrierDismissible: true,
        barrierLabel: "",
        transitionDuration: Duration(milliseconds: 200),

        transitionBuilder: (context, anim1, anim2, child) {
          return Stack(
            children: [

              PositionedTransition(
                  rect: RelativeRectTween(
                    begin: RelativeRect.fromSize(

                        Rect.fromLTWH(dx, dy, 1, 1),
                        sSize),
                    end: RelativeRect.fromSize(

                        Rect.fromLTRB(endL, endT, endR, endB),
                        sSize),
                  ).animate(CurvedAnimation(parent: anim1, curve: Curves.ease)),
                  child: child)
            ],
          );
        });
  }
}
