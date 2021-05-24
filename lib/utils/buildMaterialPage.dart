import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/material_info.dart';
import 'package:lms_pro/models/material_data.dart';
import 'package:lms_pro/models/subject.dart';
import 'package:provider/provider.dart';
import 'package:custom_dropdown/custom_dropdown.dart';

import '../app_style.dart';
import '../main.dart';
import '../testpage.dart';

class BuildMaterialPage extends StatefulWidget {
  @override
  _BuildMaterialPageState createState() => _BuildMaterialPageState();
}

class _BuildMaterialPageState extends State<BuildMaterialPage> {
  int currentPage = 0;
  Subject subject;
  static var subjectCode;
  static var code;
  void initState() {
    subject = Subject();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    subject = ModalRoute.of(context).settings.arguments;
    setState(() {
      code = Provider.of<APIService>(context, listen: false).code;
      subjectCode = subject.subjectCode;
    });
    return FutureBuilder<List<Materials>>(
        future: MaterialInfo().getMaterial(int.parse(code), subjectCode),
        builder: (context , snapshot){
          if(snapshot.hasData){
            return snapshot.data.length==0?Center(child: Text("No Material was found",style: AppTextStyle.headerStyle2,)):Padding(
              padding: const EdgeInsets.only(top: 10),
              child: GroupedListView<Materials, int>(
                elements: snapshot.data.toList(),
                groupBy: (Materials e) => e.subjectChapterCode,
                  groupHeaderBuilder: (Materials e)=> FCustomDropDown(
                    text: e.chapterNameAr,
                  ),
                itemBuilder: (context, Materials e){
                  return null;
                },
                order: GroupedListOrder.ASC,
              ),
            );
          }
          else if(snapshot.hasError){
            return Center(child: Text("Error"));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
  tryGroup() async{
    List<Materials>_items = await MaterialInfo().getMaterial(int.parse(code), subjectCode) ;
    Map<String, Materials> groups = {};
    for (Materials item in _items) {
  if(groups[(item.subjectChapterCode).toString() +" "+(item.subjectChapterLessonCode).toString()]==null){}
    }
  }
}

class FCustomDropDown extends StatefulWidget {
  final String text;


  const FCustomDropDown({Key key, this.text }) : super(key: key);

  @override
  _FCustomDropDownState createState() => _FCustomDropDownState();
}

class _FCustomDropDownState extends State<FCustomDropDown> with RouteAware {
  //static GlobalKey actionKey;
  static double height, width, xPosition, yPosition;
  static bool isDropdownOpened = false;
  static OverlayEntry floatingDropdown;

  @override
  void initState() {
   // actionKey = LabeledGlobalKey(widget.text);
    super.initState();
  }

  void findDropdownData() {
    RenderBox renderBox = context.findRenderObject();
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
    print("first $xPosition");
    print("first $yPosition");
  }

 static OverlayEntry _createFloatingDropdown()  {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: xPosition,
        width: width,
        top: yPosition + height,
        height: 4 * height + 40,
        child: FutureBuilder<List<Materials>>(
          future: MaterialInfo().getMaterial(int.parse(_BuildMaterialPageState.code), _BuildMaterialPageState.subjectCode),
      builder: (context , snapshot){
            if(snapshot.hasData){
              return GroupedListView<Materials, int>(
                elements: snapshot.data.toList(),
                groupBy: (Materials e) => e.subjectChapterCode,
                  groupHeaderBuilder: (Materials e) => Padding(
                    padding: EdgeInsets.only(top: 10 , left:25 ,right: 20,bottom: 10),
                    child:  subDropdown(
                      text: e.lessonNameAr,
                      ChapterCode: e.subjectChapterCode,
                    ),
                 ),
                  itemBuilder: (context, Materials e){
                  return null;
                },
                order: GroupedListOrder.ASC,
              );
            }
            else if(snapshot.hasError){
              return Center(
                child: Text("Error"),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
      }
      ),
        // child: subDropdown(
        //       text: "try me",
        //     ),

        //child:Text("hi"),
      );
    });
  }
  Future<bool> _onWillPop() {
    if(_subDropdownState.floatingDropdown != null ){
      _subDropdownState.floatingDropdown.remove();
      _subDropdownState.floatingDropdown = null;
      _subDropdownState.isDropdownOpened = !(_subDropdownState.isDropdownOpened);
      return Future.value(false);
    }
    if(_FCustomDropDownState.floatingDropdown != null ){
      _FCustomDropDownState.floatingDropdown.remove();
      _FCustomDropDownState.floatingDropdown = null;
      _FCustomDropDownState.isDropdownOpened = !(_FCustomDropDownState.isDropdownOpened);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        //key: actionKey,
        onTap: () {
          setState(()  {
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
        child: Padding(
          padding: const EdgeInsets.only(right: 20,left: 20,bottom: 10),
          child: Container(
            decoration: BoxDecoration(
                color: ColorSet.whiteColor,
                borderRadius:BorderRadius.all(Radius.circular(15)),
                boxShadow:[ BoxShadow(
                  color: ColorSet.shadowcolour,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(4, 3),
                ),]
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: <Widget>[
                Material(
                  child: Text(
                    widget.text,
                    style: TextStyle(
                        color: ColorSet.primaryColor,
                        fontSize: 18,),
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_drop_down,
                  color: ColorSet.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class subDropdown extends StatefulWidget {
  final String text;
  final int ChapterCode;
  const subDropdown({Key key, this.text ,this.ChapterCode}) : super(key: key);
  @override
  _subDropdownState createState() => _subDropdownState();
}

class _subDropdownState extends State<subDropdown> {
 // static GlobalKey NewKey;
  static double height, width, xPosition, yPosition;
  static bool isDropdownOpened = false;
 static OverlayEntry floatingDropdown;

  @override
  void initState() {
   // NewKey = LabeledGlobalKey(widget.text);
    super.initState();
  }

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

 static OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: xPosition,
        width: width,
        top: yPosition + height,
        //height: 4 * height + 40,
        child: DropDown(
itemHeight: height,
        ),
        //child:Text("hi"),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     // key: NewKey,
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
            color: ColorSet.whiteColor,
            borderRadius:BorderRadius.all(Radius.circular(15)),
            boxShadow:[ BoxShadow(
              color: ColorSet.shadowcolour,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(4, 3),
            ),]
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: <Widget>[
            Text(
              widget.text,
              style: TextStyle(
                color: ColorSet.primaryColor,
                fontSize: 18,),
            ),
            Spacer(),
            Icon(
              Icons.arrow_drop_down,
              color: ColorSet.primaryColor,
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

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 5,
        ),
        Container(
          height: 4 * widget.itemHeight,
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

class DropDownItem extends StatefulWidget {
  final String text;
  final IconData iconData;
  final bool isSelected;
  final bool isFirstItem;
  final bool isLastItem;

  const DropDownItem({Key key, this.text, this.iconData, this.isSelected = false, this.isFirstItem = false, this.isLastItem = false})
      : super(key: key);

  factory DropDownItem.first({String text, IconData iconData, bool isSelected}) {
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

class _DropDownItemState extends State<DropDownItem> with RouteAware{
  Future<bool> _onWillPop() {
    if(_FCustomDropDownState.floatingDropdown != null ||_subDropdownState.floatingDropdown != null ){
      _FCustomDropDownState.floatingDropdown.remove();
      _FCustomDropDownState.floatingDropdown = null;
      _subDropdownState.floatingDropdown.remove();
      _subDropdownState.floatingDropdown = null;
      _FCustomDropDownState.isDropdownOpened = !(_FCustomDropDownState.isDropdownOpened);
      _subDropdownState.isDropdownOpened = !(_subDropdownState.isDropdownOpened);
      return Future.value(false);
    }
    return Future.value(true);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: widget.isFirstItem ? Radius.circular(8) : Radius.zero,
          bottom: widget.isLastItem ? Radius.circular(8) : Radius.zero,
        ),
        color: widget.isSelected ? Colors.red.shade900 : Colors.red.shade600,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: <Widget>[
          GestureDetector(
            child:Text(widget.text.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),),
          onTap: (){
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
          ),
        ],
      ),
    );
  }
}
