import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxiapp/auth/clint_register_screen.dart';
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
  int _currentPosition = 1;

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
           child: Stack(
             children: <Widget>[
               PageView.builder(
                   controller: _pageController,
                   itemCount: this.welcomes.length,
                   // Check if last page end (nextText = Get Started) or no
                   onPageChanged: (position){
                      setState(() {
                        _currentPosition = position;
                      });
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
                       padding: const EdgeInsets.all(1.0),
                       child: Column(
                         children: <Widget>[
                           AnimatedBuilder(
                             child: Image.asset(
                               welcomes[position].image,
                               fit: BoxFit.cover,
                               height: MediaQuery.of(context).size.height*0.5,
                             ),
                             builder: (BuildContext context, child){
                               double transitionFactor = 1;
                               if (_pageController.position.haveDimensions){
                                 transitionFactor = _pageController.page - position ;
                                 transitionFactor = (1- (transitionFactor.abs()*0.6)).clamp(0.0, 1.0);
                                 return Image.asset(
                                   welcomes[position].image,
                                   fit: BoxFit.contain,
                                   height: (MediaQuery.of(context).size.height* 0.5) * transitionFactor,
                                 );
                               }else{
                                 return Image.asset(
                                   welcomes[position].image,
                                   fit: BoxFit.contain,
                                   height: MediaQuery.of(context).size.height*0.5,
                                 );
                               }

                             },
                             animation: _pageController,
                           ),
                           SizedBox(
                             height: 48,
                           ),


                           SizedBox(
                             height: 16,
                           ),
                           _animateTitle(context, widget, position),
                           SizedBox(
                             height: 16,
                           ),
                           _animateBody(context, widget, position),
                         ],
                       ),
                     );
                   }
               ),
               Align(
                   alignment: Alignment.bottomCenter,
                   child: _pageIndicators(context, _currentPosition),
               ),
             ],
           ),
        ),
      );

  }
  // Page Indicators Method
  Widget _pageIndicators(BuildContext context, int position) {
    double offset = MediaQuery.of(context).size.height * 0.3;
    return Transform.translate(
      offset: Offset(0,  - offset),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _newPageIndicators(),
      ),
    );
  }
  //method three is recommended
  List<Widget> _newPageIndicators() {
    List<Widget> widgets = [];
    for(int i = 0 ; i < welcomes.length; i ++){
      widgets.add(
        _pageIndicator(
            (_currentPosition ==i ? Theme.of(context).primaryColorLight : Color(0xFFEFDC99)),
            (i == welcomes.length-1? 0:12)),
      );

    }
    return widgets;
  }

    //method Two not recommended
  List<Widget> _medialPageIndicators(){
    List<Widget> widgets = [];
    for(int i = 0 ; i < welcomes.length; i ++){
      Color color;
      if (_currentPosition == i ){
        color = Theme.of(context).primaryColorLight;
      }else{
        color = Color(0xFFEFDC99);
      }
      double margin;
      if(i == welcomes.length -1){
        margin = 0;
      }else{
        margin = 12;
      }

      widgets.add( _pageIndicator(color, margin));

    }
    return widgets;
  }

// method one not recommended
  List<Widget> _oldPageIndicators(){
    return[
      _pageIndicator((_currentPosition ==0 ? Theme.of(context).primaryColorLight : Color(0xFFEFDC99)), 12),
      _pageIndicator((_currentPosition ==1 ? Theme.of(context).primaryColorLight : Color(0xFFEFDC99)), 12),
      _pageIndicator((_currentPosition ==2 ? Theme.of(context).primaryColorLight : Color(0xFFEFDC99)), 12),
      _pageIndicator((_currentPosition ==3 ? Theme.of(context).primaryColorLight : Color(0xFFEFDC99)), 0),
    ];
  }

  Widget _pageIndicator(Color color, double margin){
    return Container(
      width: 15 ,
      height: 5 ,
      margin: EdgeInsets.only(right: margin),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
    );
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
              height: MediaQuery.of(context).size.height * 0.1,
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
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){return ClintRegisterScreen();}));
  }

  Widget _animateTitle(BuildContext context , Widget widget, int position){
    return AnimatedBuilder(
      builder: (BuildContext context, child){
        double transitionFactor = 1;
        if (_pageController.position.haveDimensions){
          transitionFactor = _pageController.page - position ;
          transitionFactor = (1- (transitionFactor.abs())).clamp(0.0, 1.0);
          return _textTitleAnimate(position, transitionFactor);
        }else {
          return _textTitleAnimate(position,transitionFactor);
        }
      },
      animation: _pageController,
    );
  }
  Widget _animateBody(BuildContext context , Widget widget, int position){
    return AnimatedBuilder(
      builder: (BuildContext context, child){
        double transitionFactor = 1;
        if (_pageController.position.haveDimensions){
          transitionFactor = _pageController.page - position ;
          transitionFactor = (1- (transitionFactor.abs())).clamp(0.0, 1.0);
          return _textBodyAnimate(position, transitionFactor);
        }else {
          return _textBodyAnimate(position,transitionFactor);
        }
      },
      animation: _pageController,
    );
  }
  Widget _textTitleAnimate(int position, double opacity){
    return AnimatedOpacity(
      opacity: opacity,
      duration: Duration(milliseconds: 300),
      child: Text(
        welcomes[position].title,
        textAlign: TextAlign.center,
        style:Theme.of(context).textTheme.title.copyWith(fontSize: 16),
      ),
    );
  }



  Widget _textBodyAnimate(int position, double opacity){
    return AnimatedOpacity(
      opacity: opacity,
      duration: Duration(milliseconds: 300),
      child: Text(
        welcomes[position].body,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.subhead.copyWith(fontSize: 14),
      ),
    );
  }
}
