import 'dart:html';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  // 입력한 텍스트필드의 값을 저장하는 컨트롤러
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold( //스캐폴드 : 상중하단부 나눌 수 있음

      //화면 상단부(앱바)
      appBar: AppBar(
        title: Text(
            '로그인',
            style: TextStyle(color: Colors.white, fontSize: 20.0)
        ),
        elevation: 0.0,
        backgroundColor: Color(0xff19A7CE),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.menu), onPressed: (){}),
          actions: <Widget> [
            IconButton(icon: Icon(Icons.search), onPressed: (){})
          ],
      ),

      //화면 중단부
      // email, password 입력하는 부분을 제외한 화면을 탭하면, 키보드 사라지게 GestureDetector 사용
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top:50)),
              Center(
                //TODO : Swith 아이콘 넣기
                child: Icon(Icons.cookie),
              ),
              Form(
                child: Theme(
                  data: ThemeData(
                    primaryColor: Colors.white,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(color: Color(0xff19A7CE), fontSize: 15.0)
                    )
                  ),
                  child: Container(
                    padding: EdgeInsets.all(60.0),
                    child : Builder(builder: (context){
                      TextEditingController mailcontroller = TextEditingController(); //메일 주소 받음
                      TextEditingController passwdcontroller = TextEditingController(); //비밀번호 받음
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          TextField( //메일 입력받음
                            controller: mailcontroller,
                            autofocus: true,
                            decoration: InputDecoration(labelText: '숙명 이메일을 입력해주세요.'),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TextField( //비밀번호 입력받음
                            controller: passwdcontroller,
                            decoration: InputDecoration(labelText: '비밀번호를 입력해주세요.'),
                            keyboardType: TextInputType.text,
                            obscureText: true, //비밀번호 안보이도록 해줌
                          ),
                          SizedBox(height: 40.0),
                          ButtonTheme(
                              child: ElevatedButton(
                                onPressed: (){ //TODO : 회원가입을 통해 저장된 메일과 비번 db 필요
                                  if(mailcontroller.text == '@sookmyung.ac.kr'&& passwdcontroller.text == '1234'){
                                    Navigator.push(
                                      context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                NextPage()));
                                  }
                                  else if (mailcontroller.text == '@sookmyung.ac.kr' && passwdcontroller.text != '1234'){
                                    showSnackBar(context, Text('비밀번호를 다시 입력해주세요.'));
                                  }
                                  else{showSnackBar(context, Text('입력한 정보를 다시 확인해주세요.'));}
                                },
                                child: Text(
                                  '로그인하기',
                                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                                ),
                                style: ElevatedButton.styleFrom(backgroundColor: Color(0xff19A7CE)),
                              ),
                          ),
                          SizedBox(height: 40.0),
                          Row(
                            mainAxisAlignment : MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: (){//TODO : 버튼 클릭시 처리할 로직 추가
                                    },
                                  child: Text(
                                    '비밀번호를 잊으셨나요?',
                                    style: TextStyle(color: Color(0xff19A7CE), decoration: TextDecoration.underline),
                                  ),),
                              TextButton(
                                  onPressed: (){//TODO : 버튼 클릭시 처리할 로직 추가
                                  },
                                  child: Text('회원가입하기',
                                    style: TextStyle(color: Color(0xff19A7CE), decoration: TextDecoration.underline),
                                  )),
                            ],
                          ),

                      ]
                      );
                    },
                  ),
                ),
              )
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.  ScaffoldMessenger.of(context).showSnackBar(snackBar);
void showSnackBar(BuildContext context, Text text) {
  final snackBar = SnackBar(
    content: text,
    backgroundColor: Color.fromARGB(255, 112, 48, 48),
  );
}
