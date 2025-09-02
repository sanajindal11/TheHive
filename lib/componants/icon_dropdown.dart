import 'package:flutter/material.dart';

class IconDropdownSearch extends StatefulWidget {
  @override
  _IconDropdownSearchState createState() => _IconDropdownSearchState();
}

class _IconDropdownSearchState extends State<IconDropdownSearch> {
  List<String> items = ["Apple", "Banana", "Cherry", "Date", "Elderberry", "Fig", "Grapes"];
  List<String> filteredItems = [];
  String? selectedItem;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = List.from(items);
  }

  void filterSearch(String query) {
    setState(() {
      filteredItems = items.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Search & Select"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search...",
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: filterSearch,
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 200,
                      child: ListView(
                        children: filteredItems.map((item) {
                          return ListTile(
                            title: Text(item),
                            onTap: () {
                              setState(() {
                                selectedItem = item;
                              });
                              Navigator.pop(context);
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_drop_down),
                SizedBox(width: 10),
                Text(selectedItem ?? "Select an item"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

