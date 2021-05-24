import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:school/src/config/constants.dart';

import 'package:school/src/screens/test.dart';
import 'package:school/src/services/provider.dart';

class BuildMaterialPage extends StatefulWidget {
  @override
  _BuildMaterialPageState createState() => _BuildMaterialPageState();
}

class _BuildMaterialPageState extends State<BuildMaterialPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      fit: StackFit.loose,
      children: [
        Positioned(
          child: FCustomDropDown(
            text: 'mainDropdown',
          ),
        ),
      ],
    );
  }
}

// fire from dropDown
class FCustomDropDown extends StatefulWidget {
  final String text;

  const FCustomDropDown({Key key, this.text}) : super(key: key);

  @override
  _FCustomDropDownState createState() => _FCustomDropDownState();
}

class _FCustomDropDownState extends State<FCustomDropDown> with RouteAware {
  // static GlobalKey actionKey;
  static double height, width, xPosition, yPosition;
  static bool isDropdownOpened = false;
  static OverlayEntry floatingDropdown;

  void findDropdownData() {
    RenderBox renderBox = context.findRenderObject();
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
  }

  static OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Stack(
        children: [
          Positioned(
            left: 50,
            width: width / 1.4,
            top: yPosition + height,
            height: height,
            child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
              child: subDropdown(
                text: "try me",
              ),
            ),
          ),
        ],
      );
    });
  }

  Future<bool> _onWillPop() {
    if (_subDropdownState.floatingDropdown != null) {
      _subDropdownState.floatingDropdown.remove();
      _subDropdownState.floatingDropdown = null;
      _subDropdownState.isDropdownOpened =
          !(_subDropdownState.isDropdownOpened);
      return Future.value(false);
    }
    if (_FCustomDropDownState.floatingDropdown != null) {
      _FCustomDropDownState.floatingDropdown.remove();
      _FCustomDropDownState.floatingDropdown = null;
      _FCustomDropDownState.isDropdownOpened =
          !(_FCustomDropDownState.isDropdownOpened); // imortant....
      return Future.value(false);
    }
    return Future.value(true);
  }

  go() {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        // key: actionKey,
        onTap: () {
          setState(() {
            if (isDropdownOpened) {
              floatingDropdown.remove();

              Provider.of<ProvOne>(context, listen: false).doSomeThing(true, 0);
            } else {
              // click on main dropdown >>>
              Provider.of<ProvOne>(context, listen: false)
                  .doSomeThing(true, 50);
              findDropdownData();
              floatingDropdown = _createFloatingDropdown();
              Overlay.of(context).insert(floatingDropdown);
              print('click >>>');
            }
            isDropdownOpened = !isDropdownOpened;
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [defultShadow],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_drop_down,
                  color: secondryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// fire from Dropdown
class subDropdown extends StatefulWidget {
  final String text;

  const subDropdown({Key key, this.text}) : super(key: key);
  @override
  _subDropdownState createState() => _subDropdownState();
}

class _subDropdownState extends State<subDropdown>
    with TickerProviderStateMixin {
  // static GlobalKey NewKey;
  static double height, width, xPosition, yPosition;
  static bool isDropdownOpened = false;
  static OverlayEntry floatingDropdown;

  void findDropdownData() {
    RenderBox renderBox = context.findRenderObject();
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
    print("sub $xPosition");
    print("sub $yPosition");
  }

// targget >>>>>>>>>>>>>>>>>>>
  static OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Stack(
        children: [
          Positioned(
            left: xPosition,
            width: width,
            top: yPosition + height,
            child: DropDown(
              itemHeight: height,
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //key: NewKey,
      onTap: () {
        setState(() {
          if (isDropdownOpened) {
            Provider.of<ProvTwo>(context, listen: false).doSomeThing(true, 0);
            floatingDropdown.remove();
            print('NO NO try mee');
          } else {
            Provider.of<ProvTwo>(context, listen: false).doSomeThing(true, 200);
            print('try mee');
            findDropdownData();
            floatingDropdown = _createFloatingDropdown();
            Overlay.of(context).insert(floatingDropdown);
          }

          isDropdownOpened = !isDropdownOpened;
        });
      },
      child: Material(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [defultShadow]),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: <Widget>[
                  Text(
                    widget.text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DropDown extends StatefulWidget {
  final double itemHeight;

  const DropDown({Key key, this.itemHeight}) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
              // color: primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Material(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(20),
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
          ),
        ],
      ),
    );
  }
}

class DropDownItem extends StatefulWidget {
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
  _DropDownItemState createState() => _DropDownItemState();
}

class _DropDownItemState extends State<DropDownItem> with RouteAware {
  Future<bool> _onWillPop() {
    if (_FCustomDropDownState.floatingDropdown != null ||
        _subDropdownState.floatingDropdown != null) {
      _FCustomDropDownState.floatingDropdown.remove();
      _subDropdownState.floatingDropdown.remove();
      _FCustomDropDownState.floatingDropdown = null;
      _subDropdownState.floatingDropdown = null;
      _FCustomDropDownState.isDropdownOpened =
          !(_FCustomDropDownState.isDropdownOpened);
      _subDropdownState.isDropdownOpened =
          !(_subDropdownState.isDropdownOpened);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
          bottom: Radius.circular(8),
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
      child: Row(
        children: <Widget>[
          GestureDetector(
            child: Text(
              widget.text.toUpperCase(),
              style: TextStyle(
                // color: Colors.white,
                fontSize: 15,
                // fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  maintainState: true,
                  builder: (context) => Test(),
                ),
              );
              _onWillPop();
              // _FCustomDropDownState.isDropdownOpened = !(_FCustomDropDownState.isDropdownOpened);
              // _subDropdownState.isDropdownOpened = !(_subDropdownState.isDropdownOpened);
            },
          ),
          Spacer(),
          Icon(
            widget.iconData,
            color: Colors.white,
            size: 17,
          ),
        ],
      ),
    );
  }
}
