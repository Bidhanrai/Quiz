import 'package:flutter/material.dart';
import 'package:quick_quiz/Constant/Constant.dart';
import 'package:quick_quiz/View/AboutView.dart';
import 'package:quick_quiz/View/Home/DetailView.dart';
import 'package:quick_quiz/View/ProfileView.dart';
import 'package:quick_quiz/ViewModel/HomeViewModel.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  HomeViewModel _homeViewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text("Categories"),
      centerTitle: true,
      actions: [
        IconButton(icon: Icon(Icons.person), onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileView()));
        },),
      ],
    );
  }

  Widget _body() {
    return GridView.count(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: List.generate(_homeViewModel.categories.length, (index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailView(
                    categoryNumber: _homeViewModel.categories[index]["categoryNumber"],
                    category: _homeViewModel.categories[index]["title"],
                    imageUrl: _homeViewModel.categories[index]["image"],
                  ),
                ),
              );
            },
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Hero(
                    tag: _homeViewModel.categories[index]["title"],
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(_homeViewModel.categories[index]["image"]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),

                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    //color: Constant.primaryColorLighter,
                    color: Constant.primaryColorLight,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    child: Text(
                      _homeViewModel.categories[index]["title"],
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16,),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      unselectedItemColor: Constant.primaryColor.withOpacity(0.7),
      selectedItemColor: Constant.primaryColor,
      items: [
        _bottomNavigationBarItem("Categories", Icons.home),
        _bottomNavigationBarItem("Profile", Icons.person),
        _bottomNavigationBarItem("About", Icons.menu),
      ],
      onTap: (int value) {
        if(value==1) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileView()));
        } else if(value==2){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutView()));
        }
      },
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(String label, IconData iconData) {
    return BottomNavigationBarItem(
      icon: Icon(iconData),
      label: label,
    );
  }
}
