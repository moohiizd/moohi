import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hkjb/LoginResponseModel.dart';
import 'package:hkjb/selector.dart';
import 'package:hkjb/signup.dart';
import 'package:http/http.dart';



void main(){
  runApp(Login());
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key : key);

  @override
  State<Login> createState() => _LoginState();
}


late String username , password ;

var _usernameContoller = TextEditingController();
var _passwordContoller = TextEditingController();

final _messengerKey = GlobalKey<ScaffoldMessengerState>();

class _LoginState extends State<Login> {

  static const title_style = TextStyle(
    color: Colors.blueAccent,
    fontFamily: "Irs",
    fontSize: 24,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.5,

  );

  static const input_title = TextStyle(
    color: Colors.blueAccent,
    fontFamily: "Irs",
    fontSize: 16,
    fontWeight: FontWeight.w800,

  );

  static const  hint_text = TextStyle(
      color: Colors.black45,
      fontFamily: "Irs",
      fontSize: 16,
  );



  @override
  void initState() {
    username = "";
    password = "";

    super.initState();


  }

  final _messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      scaffoldMessengerKey: _messengerKey,

    home:Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "ورود",
              style:
              TextStyle(fontFamily: "Irs", fontSize: 20, color: Colors.black),
            ),

            centerTitle: true,
            leading: InkWell(
              onTap: (){

                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Selector() ));
              },

              child: Icon(
                Icons.arrow_back,
                color: Colors.black45,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: LoginUI(),


        );
      }
    ));
  }


}


class LoginUI extends StatelessWidget {
  const LoginUI({super.key});


  static const title_style = TextStyle(
    color: Colors.blueAccent,
    fontFamily: "Irs",
    fontSize: 24,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.5,

  );

  static const input_title = TextStyle(
    color: Colors.blueAccent,
    fontFamily: "Irs",
    fontSize: 16,
    fontWeight: FontWeight.w800,

  );

  static const  hint_text = TextStyle(
    color: Colors.black45,
    fontFamily: "Irs",
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[

          SizedBox(height: 30,),

          Text("فروشگاه آنلاین من ",
            style:title_style,
          ),

          SizedBox(
            height: 30,
          ),

          Container(
            height: 300,
            margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child:  Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              elevation: 4,
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),

                    //نام کاربری و متن دریافتی
                    Padding(

                      padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text("نام کاربری", style: input_title,),

                      ),

                    ),

                    Padding(

                      padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: TextField(

                        controller: _usernameContoller,

                        textAlign: TextAlign.center,
                        style: input_title,
                        decoration: InputDecoration(
                          hintText: "شماره موبایل",
                          hintStyle: hint_text,
                          suffixIcon: Icon(Icons.phone_android),

                        ),

                        onChanged: (value){

                          username = value;
                        },

                      ),
                    ),

                    SizedBox(height: 35,),

                    //کلمه عبور و متن دریافتی

                    Padding(

                      padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text("کلمه عبور", style: input_title,),
                      ),
                    ),

                    Padding(

                      padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: TextField(

                        controller: _passwordContoller,

                        textAlign: TextAlign.center,
                        style: input_title,
                        decoration: InputDecoration(
                          hintText: "کلمه عبور",
                          hintStyle: hint_text,
                          suffixIcon: Icon(Icons.lock),
                        ),

                        onChanged: (value){

                          password = value;
                        },

                      ),
                    ),

                    SizedBox(height: 35,),

                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 50,),

          TextButton(
            onPressed:(){

              if(_usernameContoller.text == ""){

                //error
                ShowMySnackBar(context, "لطفا نام کاربری خود را وارد فرمایید");
              }else if(_passwordContoller.text == ""){

                //error
                ShowMySnackBar(context, "لطفا کلمه عبور خود را وارد فرمایید");
              }else{

                //send error
                sendLoginRequest(context: context , username:  _usernameContoller.text , password: _passwordContoller.text);
              }


            },
            child: Text('ورود'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              fixedSize: Size(340, 60),
              backgroundColor: Colors.blueAccent,
              elevation: 12,
              textStyle: TextStyle(fontSize: 22, fontFamily: "Irs" ),
            ),

          ),
          SizedBox(height: 30,),

          InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Signup() ));
              },
              child: Text("حساب کاربری ندارم", style: input_title,))

        ],
      ),
    );
  }


void sendLoginRequest({required BuildContext context , required String username ,required String password}) async{

  var body = Map<String , dynamic>();

  body["username"] = username;
  body["password"] = password;

  Response response = await post(Uri.parse('https://cloud99.yourlinuxhost.com/app/loginforfinal.php'), body: body);


  if( response.statusCode == 200){

    //Result

    var loginJson = json.decode(utf8.decode(response.bodyBytes));
    var model = LoginResponseModel(LoginJson["error"] , loginJson["message"] );

    if( model.error == false ){

      ShowMySnackBar(context, model.message);

    }else{

      ShowMySnackBar(context, model.message);
      //navigate to login page

    }


  }else{

    ShowMySnackBar(context, "خطایی در ارتباط با سرور رخ داده است");

  }


}






  void ShowMySnackBar(BuildContext context , String message){

    _messengerKey.currentState!.showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content: Text(
              message, style: TextStyle(
            fontFamily: "Irs",
            fontSize: 17,
            color: Colors.white,
            fontWeight: FontWeight.bold,),
              textAlign: TextAlign.center),
          elevation: 5,
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'تایید ',
            onPressed: (){},
            textColor: Colors.yellowAccent,
          ),


        )


    );

  }




}
