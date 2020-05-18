import 'package:flutter/material.dart';
import 'customs/custom_icons_icons.dart';
import 'instagram_data/insta_data.dart';

const bottomNavIconSize = 35.0;


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  bool _isNoBorderFavIcon = true;
  bool _isNoBorderBookmarkIcon = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(
          CustomIcons.camera,
          color: Colors.black,
          size: 28,
        ),
        onPressed: () {},
      ),
      title: Text(
        'Instagram',
        style: TextStyle(color: Colors.black),
      ),
      titleSpacing: 8,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            CustomIcons.live_tv,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {},
        ),
        Transform.rotate(
          angle: 0.4,
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: IconButton(
              icon: Icon(
                CustomIcons.paper_plane_empty,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  _buildBody() {
    return RefreshIndicator(
      onRefresh: () async {},
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildStory(),
              _buildPostList(),
            ],
          ),
        ),
      ),
    );
  }

  _buildBottomNav() {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          //home icon
          IconButton(
            icon: Icon(
              CustomIcons.home,
              size: 27,
            ),
            onPressed: () {},
          ),
          //explore icon
          IconButton(
            icon: Icon(
              CustomIcons.search,
              size: bottomNavIconSize,
            ),
            onPressed: () {},
          ),
          //add photo icon
          IconButton(
            icon: Icon(
              CustomIcons.add_circle_outline,
              size: bottomNavIconSize,
            ),
            onPressed: () {},
          ),
          //notification icon
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: IconButton(
              icon: Icon(
                CustomIcons.heart_empty,
                size: 31,
              ),
              onPressed: () {},
            ),
          ),
          //profile icon
          IconButton(
            icon: Icon(
              Icons.person_outline,
              size: bottomNavIconSize,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  _buildStory() {
    List<Widget> storyWidgetList = [];
    storyList.forEach((Post post) {
      Column c = Column(
        children: <Widget>[
          //outside circle border container that has gradient color
          Container(
            width: 80,
            height: 75,
            margin: EdgeInsets.only(top: 13, left: 12, bottom: 6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.pink,
                  Colors.yellow,
                ],
              ),
            ),

            // White background circle container between image and gradient
            child: Container(
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),

              // Image container
              child: FittedBox(
                child: Container(
                  margin: EdgeInsets.all(4),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(post.profileImage),
                    ),
                  ),
                ),
              ),
            ),
          ),

          //username in story
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Text(post.id),
          )
        ],
      );
      storyWidgetList.add(c);
    });

    // Base container for story
    return Container(
      height: 120,
      decoration: BoxDecoration(
        // a line that seperate story and post
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200],
            width: 1,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: storyWidgetList,
        ),
      ),
    );
  }

  _buildPostList() {
    // random name from list to put in like number section
    var randomItem = (postList.toList()..shuffle()).first;

    List<Widget> postWidgetList = [];
    postList.forEach((Post post) {
      Container c = Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            //profile name, image and option icon
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 6, left: 6, right: 8),
                  child: CircleAvatar(
                    radius: 19,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(post.profileImage),
                  ),
                ),
                Text(post.id),
                Expanded(child: SizedBox()),
                // add space to push option Icon to the right
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                )
              ],
            ),
            //post image
            Container(
              constraints: BoxConstraints(
                maxHeight: 500,
                minHeight: 200,
                maxWidth: double.infinity,
                minWidth: double.infinity,
              ),
              child: Image.network(
                post.image,
                fit: BoxFit.cover,
              ),
            ),
            //like comment share bookmark button
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: IconButton(
                    icon: Icon(_isNoBorderFavIcon ? CustomIcons.heart_empty : Icons.favorite),
                    iconSize: 22,
                    onPressed: () {
                      setState(() {
                        _isNoBorderFavIcon = !_isNoBorderFavIcon;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(CustomIcons.comment_empty),
                  iconSize: 22,
                  onPressed: () {},
                ),
                Transform.rotate(
                  angle: 0.3,
                  child: IconButton(
                    icon: Icon(CustomIcons.paper_plane_empty),
                    iconSize: 22,
                    onPressed: () {},
                  ),
                ),
                // add space to push Bookmark Icon to the right
                Spacer(
                  flex: 1,
                ),
                IconButton(
                  icon: Icon(_isNoBorderBookmarkIcon ? CustomIcons.bookmark : Icons.bookmark),
                  onPressed: () {
                    setState(() {
                      _isNoBorderBookmarkIcon = !_isNoBorderBookmarkIcon;
                    });
                  },
                )
              ],
            ),
            //like number
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Liked by ',
                      style: TextStyle(color: Colors.black54),
                    ),
                    TextSpan(
                      text: randomItem.id.toString(),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ' and ',
                      style: TextStyle(color: Colors.black54),
                    ),
                    TextSpan(
                      text: post.like + " others",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ]),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            //post owner description
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: RichText(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: post.id,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w800),
                        ),
                        TextSpan(text: " ", style: TextStyle(fontSize: 15.0)),
                        TextSpan(
                          text: post.desc,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
            //view comment
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    'View all 12 comments',
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
            //add comment
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 6, right: 8),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(post.profileImage),
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: -5),
                        hintText: 'Add a comment...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 14)),
                  ),
                ),
                Text('👍', style: TextStyle(fontSize: 14.0)),
                SizedBox(width: 10.0),
                Text('😛', style: TextStyle(fontSize: 14.0)),
                SizedBox(width: 10.0),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Icon(
                    Icons.add_circle_outline,
                    size: 15.0,
                    color: Colors.black26,
                  ),
                ),
                SizedBox(width: 12.0),
              ],
            ),
            //upload time
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 8),
                  child: Text(
                    '1 hours ago ',
                    style: TextStyle(color: Colors.black54, fontSize: 10),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
      postWidgetList.add(c);
    });

    return Column(
      children: postWidgetList,
    );
  }
}

