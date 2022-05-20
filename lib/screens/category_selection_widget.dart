import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategorySelectionWidget extends StatefulWidget {
  final Map<String, IconData> categories;

  const CategorySelectionWidget({Key? key, required this.categories})
      : super(key: key);

  @override
  State<CategorySelectionWidget> createState() =>
      _CategorySelectionWidgetState();
}

class _CategorySelectionWidgetState extends State<CategorySelectionWidget> {
  String currentItem = "Alcohol";

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];

    widget.categories.forEach((name, icon) {
      widgets.add(GestureDetector(
        onTap: () {
          setState(() {
            currentItem = name;
          });
        },
        child: CategoryWidget(
          name: name,
          icon: icon,
          selected: name == currentItem,
        ),
      ));
    });

    return ListView(
      scrollDirection: Axis.horizontal,
      children: widgets,
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget(
      {Key? key,
      required this.name,
      required this.icon,
      required this.selected})
      : super(key: key);

  final String name;
  final IconData icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(
                    color: selected ? Colors.deepPurpleAccent : Colors.grey,
                    width: selected ? 3.0 : 1.0)),
            width: 50,
            height: 50,
            child: Icon(icon),
          ),
          Text(name)
        ],
      ),
    );
  }
}
