import 'package:flutter/material.dart';
import 'package:quick_quiz/Constant/Constant.dart';
import 'package:quick_quiz/View/DetailView.dart';
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
        IconButton(icon: Icon(Icons.person), onPressed: (){},),
      ],
    );
  }

  Widget _body() {
    return GridView.count(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      shrinkWrap: true,
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
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(String label, IconData iconData) {
    return BottomNavigationBarItem(icon: Icon(iconData), label: label,);
  }
}
