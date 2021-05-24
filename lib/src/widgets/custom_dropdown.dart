import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school/src/routes/routes_names.dart';

import '../../main.dart';

class BuildMaterialPage extends StatefulWidget {
  @override
  _BuildMaterialPageState createState() => _BuildMaterialPageState();
}

class _BuildMaterialPageState extends State<BuildMaterialPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FCustomDropDown(
          text: "try new List",
        ),
      ],
    );
  }
}

class FCustomDropDown extends StatefulWidget {
  final String text;

  const FCustomDropDown({Key key, this.text}) : super(key: key);

  @override
  _FCustomDropDownState createState() => _FCustomDropDownState();
}

class _FCustomDropDownState extends State<FCustomDropDown> with RouteAware {
  GlobalKey actionKey;
  double height, width, xPosition, yPosition;
  bool isDropdownOpened = false;
  static OverlayEntry floatingDropdown;

  @override
  void initState() {
    actionKey = LabeledGlobalKey(widget.text);
    super.initState();
  }

  void findDropdownData() {
    RenderBox renderBox = actionKey.currentContext.findRenderObject();
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
  }

  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: xPosition,
        width: width,
        top: yPosition + height,
        //height: 4 * height + 40,
        child: subDropdown(
          text: "try me",
        ),
      );
    });
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    // routeObserver.subscribe(this, ModalRoute.of(context));
  }

  void dispose() {
    // routeObserver.unsubscribe(this);
    super.dispose();
  }

  // void didPush() {
  //   floatingDropdown.remove();
  // }

  void didPopNext() {
    Overlay.of(context).insert(floatingDropdown);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: actionKey,
      onTap: () {
        setState(() {
          if (isDropdownOpened) {
            floatingDropdown.remove();
            //floatingDropdown.dispose();
          } else {
            findDropdownData();
            floatingDropdown = _createFloatingDropdown();
            Overlay.of(context).insert(floatingDropdown);
          }
          isDropdownOpened = !isDropdownOpened;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.red.shade600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: <Widget>[
            Text(
              widget.text.toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
            Spacer(),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class subDropdown extends StatefulWidget {
  final String text;

  const subDropdown({Key key, this.text}) : super(key: key);
  @override
  _subDropdownState createState() => _subDropdownState();
}

class _subDropdownState extends State<subDropdown> {
  GlobalKey NewKey;
  double height, width, xPosition, yPosition;
  bool isDropdownOpened = false;
  static OverlayEntry floatingDropdown;

  @override
  void initState() {
    NewKey = LabeledGlobalKey(widget.text);
    super.initState();
  }

  void findDropdownData() {
    RenderBox renderBox = NewKey.currentContext.findRenderObject();
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
  }

  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: xPosition,
        width: width,
        top: yPosition + height,
        child: DropDown(
          itemHeight: height,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: NewKey,
      onTap: () {
        setState(() {
          if (isDropdownOpened) {
            floatingDropdown.remove();
          } else {
            findDropdownData();
            floatingDropdown = _createFloatingDropdown();
            Overlay.of(context).insert(floatingDropdown);
          }

          isDropdownOpened = !isDropdownOpened;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.red.shade600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: <Widget>[
            Text(
              widget.text.toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
            Spacer(),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class DropDown extends StatelessWidget {
  final double itemHeight;

  const DropDown({Key key, this.itemHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 5,
        ),
        Container(
          height: 4 * itemHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: <Widget>[
              DropDownItem.first(
                text: "Add new",
                iconData: Icons.add_circle_outline,
                isSelected: false,
              ),
              DropDownItem(
                text: "View Profile",
                iconData: Icons.person_outline,
                isSelected: false,
              ),
              DropDownItem(
                text: "Settings",
                iconData: Icons.settings,
                isSelected: false,
              ),
              DropDownItem.last(
                text: "Logout",
                iconData: Icons.exit_to_app,
                isSelected: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DropDownItem extends StatelessWidget {
  final String text;
  final IconData iconData;
  final bool isSelected;
  final bool isFirstItem;
  final bool isLastItem;

  const DropDownItem(
      {Key key,
      this.text,
      this.iconData,
      this.isSelected = false,
      this.isFirstItem = false,
      this.isLastItem = false})
      : super(key: key);

  factory DropDownItem.first(
      {String text, IconData iconData, bool isSelected}) {
    return DropDownItem(
      text: text,
      iconData: iconData,
      isSelected: isSelected,
      isFirstItem: true,
    );
  }

  factory DropDownItem.last({String text, IconData iconData, bool isSelected}) {
    return DropDownItem(
      text: text,
      iconData: iconData,
      isSelected: isSelected,
      isLastItem: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: isFirstItem ? Radius.circular(8) : Radius.zero,
          bottom: isLastItem ? Radius.circular(8) : Radius.zero,
        ),
        color: isSelected ? Colors.red.shade900 : Colors.red.shade600,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: <Widget>[
          GestureDetector(
            child: Text(
              text.toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     maintainState: true,
              //     builder: (context) => Test(),
              //   ),
              // );

              _FCustomDropDownState.floatingDropdown.remove();
              _subDropdownState.floatingDropdown.remove();
              Navigator.pushNamed(context, testRoute);
            },
          ),
          Spacer(),
          Icon(
            iconData,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
