import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/club/PostStream/my_post_button.dart';
import 'package:flutter_application_1/componants/my_textfield.dart';
import 'package:intl/intl.dart';
import '../../../componants/mt_list_tile.dart';
import 'firestore.dart';

class PostsStreamPage extends StatelessWidget {
  final String clubName;

  PostsStreamPage({super.key, required this.clubName});
  
  // firestore access
  final FirestoreDatabase database = FirestoreDatabase();

// text controller
final TextEditingController newPostController = TextEditingController();

// post message
void postMessage() {
  // only post club if there is something in the textfield
  if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message, clubName);
  }
  // clear the controller
  newPostController.clear();
}

void  _goBack(BuildContext context) {
    Navigator.pop(context);
  }
  
  @override
    Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text ('A N N O U N C E M E N T S', style: TextStyle(fontSize: 20),  ),
        ),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            children: [
              // textfield
              Expanded(
                child: MyTextField(
                hintText: "New announcement..",
                 obscureText: false,
                  controller: newPostController
                  ),
                  ),
                  // create post button
                  PostButton(
                    onTap: postMessage,
                    )
            ],
          ),
        ),
        
        
        // POSTS
        
       StreamBuilder(
          stream: database.getPostStream(clubName),
          builder: (context, snapshot) {
            // show loading circle
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
                );
            }
          
            // get all posts
            final posts = snapshot.data!.docs;

            // no data?
            if (snapshot.data == null || posts.isEmpty) {
              return const Center(
                child:  Padding(
                  padding: EdgeInsets.all(25),
                  child: Text("No posts.. Post Something")
                  ),
              );
            }
            // return as a list
            return Expanded(
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  // get each indivisual post
                  final post = posts[index];
                  // get data from each post
                  final data = post.data() as Map<String, dynamic>;

                  // get data from each post
                  String message = data.containsKey('PostMessage') ? data['PostMessage'] : 'No message';
                  String userEmail = data.containsKey('UserEmail') ? data['UserEmail'] : 'No email';
                  Timestamp timestamp = data.containsKey('TimeStamp') ? data['TimeStamp'] : Timestamp.now();

                  // Convert to DateTime
                  DateTime date = timestamp.toDate();

                  // Format the date (YYYY-MM-DD)
                  String formattedDate = DateFormat('MM/dd/yyyy').format(date);

                  // return as a list title
                  return MyListTile(
                    title: message,
                     subTitle: userEmail,
                      trailing: formattedDate,
                     );
                },
                ));
          },
          )

          
      ]
    ),
    );
  }
}