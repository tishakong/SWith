import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'firebase_provider.dart';

SignUpPageState pageState;

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() {
    pageState = SignUpPageState();
    return pageState;
  }
}

class SignUpPageState extends State<SignUpPage> {
  TextEditingController mailCon = TextEditingController();
  TextEditingController pwCon = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseProvider fp;

  @override
  void dispose() {
    mailCon.dispose();
    pwCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text("Sign-Up Page")),
        body: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Column(
                children: <Widget>[
                  //Header
                  Container(
                    height: 50,
                    decoration: BoxDecoration(color: Color(0xff19A7CE)),
                    child: Center(
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  // Input Area
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff19A7CE), width: 1),
                    ),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: mailCon,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            hintText: "Email",
                          ),
                        ),
                        TextField(
                          controller: pwCon,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: "Password",
                          ),
                          obscureText: true,
                        ),
                      ].map((c) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: c,
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),

            // Sign Up Button
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: RaisedButton(
                color: Colors.blueGrey,
                child: Text(
                  "SIGN UP",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  FocusScope.of(context)
                      .requestFocus(new FocusNode()); // 키보드 감춤
                  _signUp();
                },
              ),
            ),
          ],
        )
    );
  }
}

class RaisedButton {
}

/*
class SignupPage extends StatelessWidget {
  // 입력한 텍스트필드의 값을 저장하는 컨트롤러
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold( //스캐폴드 : 상중하단부 나눌 수 있음

      //화면 상단부(앱바)
      appBar: AppBar(
        title: Text('회원가입', style: TextStyle(color: Colors.white, fontSize: 20.0),),
        elevation: 0.0,
        backgroundColor: Color(0xff19A7CE),
        centerTitle: true,
        //leading:앱바의 왼쪽 위젯 설정. actions는 오른쪽 설정.
        leading: IconButton(icon: Icon(Icons.menu), onPressed: (){}),
        actions: <Widget> [
          IconButton(icon: Icon(Icons.search), onPressed: (){})
        ],
      ),

      body: GestureDetector(onTap: (){FocusScope.of(context).unfocus();},
        child: SingleChildScrollView(
          child: Column(
            children : [
              Padding(padding: EdgeInsets.only(top:50)),
              Center(//TODO : Swith 아이콘 넣기
                child: Icon(Icons.cookie),
              ),
              Form(
                child: Theme(
                  data: ThemeData(
                    primaryColor: Colors.white,
                    inputDecorationTheme: InputDecorationTheme(labelStyle: TextStyle(color: Color(0xff19A7CE), fontSize: 15.0))
                  ),
                  child: Container(
                    padding: EdgeInsets.all(60.0),
                    child : Builder(builder: (context) {
                      TextEditingController mailcontroller = TextEditingController(); //메일 주소 받음
                      TextEditingController codecontroller = TextEditingController();//비밀번호 받음
                      return Column(
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          TextField( //메일 입력받음
                            controller: mailcontroller, autofocus: true,
                            decoration: InputDecoration(labelText: '숙명 이메일을 입력해주세요.',),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 20.0),
                          ElevatedButton(onPressed: () {
                            sendVerificationCode(context, emailController.text);},
                            child: Text('인증 코드 받기'),
                          ),
                          TextField( //비밀번호 입력받음
                            controller: codecontroller,
                            decoration: InputDecoration(labelText: '코드를 입력해주세요.'),
                            keyboardType: TextInputType.text,
                            obscureText: true, //비밀번호 안보이도록 해줌
                          ),

                          SizedBox(height: 20.0), ElevatedButton(onPressed: () {
                            // TODO: 회원가입 버튼 클릭 시 처리할 로직 추가
                          }, child: Text('회원가입하기'),),
                        ]
                    );
                  }),
      ),
    ),
    ),
       ]
       ),
     )
    ),);}
  }
*/

  void sendVerificationCode(BuildContext context, String email) async {
    final Email emailToSend = Email(
      body: '인증 코드: 1234', // 인증 코드 내용은 여기에 입력
      subject: '회원가입 인증 코드',
      recipients: [email],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(emailToSend);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('인증 코드를 이메일로 전송했습니다.')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('이메일 전송에 실패했습니다.')),
      );
    }
  }
