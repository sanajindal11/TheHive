import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/componants/my_drawer.dart';
import 'package:flutter_application_1/pages/club/club_tile.dart';

class SearchPage extends StatefulWidget {
   const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
   final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("A L L  C L U B S"),
        elevation: 0,
        actions: [
          Row(
            children: [
              Image.asset(
                'lib/images/logo.png',
                height: 50,
              ),
              SizedBox(width: 10,)
            ],
          ),
        ],
      ),

      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
          // search bar
          Container (
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            ),
          child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: const InputDecoration(
                hintText: 'Search for clubs...',
                suffixIcon: Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('club')
                  .orderBy('clubName')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator()
                    );
                }
              
                final eventsData = snapshot.data!.docs;

                // Filter the data based on the search query
                final filteredData = eventsData.where((event) {
                  final clubName = event['clubName'].toString().toLowerCase();
                  return clubName.contains(_searchQuery);
                }).toList();
                
                return ListView.builder(
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    var event = filteredData[index];
                    return ClubTile(
                      clubName: event['clubName'],
                      clubDescription: event['clubDes'],
                      clubAdvisor: event['clubAdvisor'],
                      clubEmail: event['clubEmail'],
                    );
                  },
                );
              },
              ),
          ),
          ],
        ),
      ),
    );
  }
}
