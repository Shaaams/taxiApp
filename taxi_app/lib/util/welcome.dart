import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'welcome_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxiapp/home.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List<WelcomeModel> welcomes = [
    WelcomeModel(
        image: 'assets/images/taxiapp1.png',
        title: 'Download, call, go',
        body: 'Praesent tellus mauris, tincidunt nec ipsum id, faucibus pellentesque leo. Nunc congue ac tellus quis porttitor. '),
    WelcomeModel(
        image: 'assets/images/taxiapp2.png',
        title: 'Welcome To GoTaxi 2',
        body: 'Praesent tellus mauris, tincidunt nec ipsum id, faucibus pellentesque leo. Nunc congue ac tellus quis porttitor. '),
    WelcomeModel(
        image: 'assets/images/taxiapp3.png',
        title: 'Welcome To GoTaxi 3',
        body: 'Praesent tellus mauris, tincidunt nec ipsum id, faucibus pellentesque leo. Nunc congue ac tellus quis porttitor. '),
    WelcomeModel(
        image: 'assets/images/taxiapp2.png',
        title: 'Welcome To GoTaxi 4',
        body: 'Praesent tellus mauris, tincidunt nec ipsum id, faucibus pellentesque leo. Nunc congue ac tellus quis porttitor. '),
  ];
  PageController _pageController;
  String nextText = 'Next';
  bool amInLastPage = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 1,
      viewportFraction: 0.75
    );

  }

    @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double radius = MediaQuery.of(context).size.width * 0.09;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _slider(context),
          _bottomNavigation(context, radius),
        ],
      ),
    );
  }
  // Slider Method
  Widget _slider(BuildContext context){
      return Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: PageView.builder(
            controller: _pageController,
            itemCount: this.welcomes.length,
              // Check if last page end (nextText = Get Started) or no
              onPageChanged: (position){
                  if(position == (welcomes.length -1 )){
                    setState(() {
                      nextText = 'Get Started';
                      amInLastPage = true;
                    });
                  }else{
                    setState(() {
                      nextText = 'Next';
                      amInLastPage = false;
                    });
                  }
              },
              itemBuilder: (context, position){
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Image.asset(welcomes[position].image, fit: BoxFit.cover,),
                    _pageIndicators(context, position),
                    Text(welcomes[position].title,style:Theme.of(context).textTheme.title.copyWith(fontSize: 16),),
                    Text(welcomes[position].body, style: Theme.of(context).textTheme.subhead.copyWith(fontSize: 14),),
                  ],
                ),
              );
              }
          ),
        ),
      );
  }
  // Page Indicators Method
  Widget _pageIndicators(BuildContext context, int position) {
    return Row();
  }

  // Bottom Button Navigation Method
  Widget _bottomNavigation( BuildContext context, double radius ){
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius),
                    topRight: Radius.circular(radius)),
              ),
              height: MediaQuery.of(context).size.height * 0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                      onPressed: () async{
                        // TODO: Skip
                        SharedPreferences shard =await SharedPreferences.getInstance();
                        shard.setBool('seen', true);
                        goToHomePage(context);
                      },
                      child: Text('Skip')
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: MaterialButton(
                      minWidth: 150,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(radius)),
                      ),
                      elevation: 0,
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColorLight,
                      onPressed: (){
                        // Go Next Slide
                        if( amInLastPage ){
                          goToHomePage(context);
                        }else{

                        _pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
                        }
                      },
                      child: Text(nextText),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  void goToHomePage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context){return HomeScreen();}));
  }

}
