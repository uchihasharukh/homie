import 'package:flutter/material.dart';

class Filter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          textTheme: TextTheme(
              title: TextStyle(
                  color: Colors.purple[900],
                  fontSize: 40,
                  fontWeight: FontWeight.bold)),
          elevation: 0,
          title: new Text('FILTER'),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: IconButton(
                icon: new Icon(
                  Icons.close,
                  size: 40,
                ),
                color: Colors.grey,
                onPressed: () => Navigator.pop(context),
              ),
            )
          ]),
      body: FilterItems(),
    );
  }
}

class FilterItems extends StatefulWidget {
  @override
  _FilterItemsState createState() => _FilterItemsState();
}

class _FilterItemsState extends State<FilterItems> {
  //for gridview
  Item item1 = new Item(image: "AC", title: "assets/oven.png");
  Item item2 = new Item(image: "WI-FI", title: "assets/wifi.png");
  Item item3 = new Item(image: "Fridge", title: "assets/fridge.png");
  Item item4 = new Item(image: "Washing Machine", title: "assets/heater.png");
  Item item5 = new Item(image: "Water Heater", title: "assets/heater.png");
  Item item6 = new Item(image: "T.V", title: "assets/tv.png");
  Item item7 = new Item(image: "Microwave Oven", title: "assets/oven.png");
  Item item8 = new Item(image: "R.O Water", title: "assets/ro.png");
  Item item9 = new Item(image: "Parking", title: "assets/parking.png");
  //end of grid view vars
  List<bool> isSelected = [false, false, false];
  RangeValues _values = RangeValues(5, 60); //for budget slider
  double _value = 18;
  bool _isRadioSelected = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar size alright*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    List<Item> myList = [
      item1,
      item2,
      item3,
      item4,
      item5,
      item6,
      item7,
      item8,
      item9
    ];
    return SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              child: Column(
            children: [
              Text("HOUSE TYPE"),
              ToggleButtons(
                renderBorder: false,
                fillColor: Colors.transparent,
                selectedColor: Colors.purple[900],
                children: <Widget>[
                  Column(
                    children: [Icon(Icons.person), Text("Room")],
                  ),
                  Column(
                    children: [Icon(Icons.group), Text("Twin Sharing")],
                  ),
                  Column(
                    children: [Icon(Icons.group_add), Text("Multi-Sharing")],
                  )
                ],
                isSelected: isSelected,
                onPressed: (int index) {
                  setState(() {
                    isSelected[index] = !isSelected[index];
                  });
                },
              )
            ],
          )),
          Container(
            child: Column(
              children: [
                Text("Budget"),
                RangeSlider(
                  values: _values,
                  activeColor: Colors.purple[900],
                  labels: RangeLabels(_values.start.toInt().toString(),
                      _values.end.toInt().toString()),
                  min: 5,
                  max: 60,
                  divisions: 11,
                  onChanged: (RangeValues values) {
                    setState(() {
                      if (values.end - values.start >= 20) {
                        _values = values;
                      } else {
                        if (_values.start == values.start) {
                          _values =
                              RangeValues(_values.start, _values.start + 20);
                        } else {
                          _values = RangeValues(_values.end - 20, _values.end);
                        }
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Text("Age"),
                Slider(
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                  min: 18,
                  max: 60,
                  divisions: 42,
                  value: _value,
                  activeColor: Colors.purple[900],
                  label: _value.toInt().toString(),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Sex"),
                RadioListTile(
                  title: const Text('Male'),
                  value: true,
                  groupValue: _isRadioSelected,
                  onChanged: (bool newValue) {
                    setState(() {
                      _isRadioSelected = newValue;
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Female'),
                  value: false,
                  groupValue: _isRadioSelected,
                  onChanged: (bool newValue) {
                    setState(() {
                      _isRadioSelected = newValue;
                    });
                  },
                )
              ],
            ),
          ),
          /* Container(
            child: Column(
              children: [
                Text("Ammeneties"),
                new Expanded(
                  child: GridView.count(
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: (itemWidth / itemHeight),
                    controller: new ScrollController(keepScrollOffset: false),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 3,
                    children: myList.map((data) {
                      return Container(
                        child: Column(
                          children: [
                            Image.asset(data.image, width: 20),
                            Text(data.title)
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ) */
        ], //main children
      ),
    );
  }
}

class Item {
  String image;
  String title;

  Item({this.image, this.title});
}
