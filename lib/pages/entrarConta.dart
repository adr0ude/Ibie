import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginConta extends StatefulWidget {
  const LoginConta({super.key});

  @override
  State<LoginConta> createState() => _LoginContaState();
}

class _LoginContaState extends State<LoginConta> {
  bool marcado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F5F9),
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        elevation: 4.0,
        shadowColor: Color.fromARGB(150, 0, 0, 0),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child:Column( 
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(top: 78, bottom: 80),
            child: Center(
              child: Container(
                height: 187,
                width: 382,
                color: Color(0xFFF4F5F9),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Positioned(
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/nomeIbie.svg',
                        width: 240,
                        fit: BoxFit.contain,
                      ),
                    ),

                    Positioned(
                      left: 175,
                      child: SvgPicture.asset(
                        'assets/treeIpe.svg',
                        width: 188,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsetsGeometry.only(bottom: 18),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Color(0xFF9A31C9),
                side: BorderSide(color: Color(0xFF9A31C9), width: 1),
                fixedSize: Size(354, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(8),
                ),
                alignment: Alignment.centerLeft,
              ),
              onPressed: () {},
              child: Text(
                'E-mail *',
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF767474),
                ),
              ),
            ),
          ),

          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Color(0xFF9A31C9),
              side: BorderSide(color: Color(0xFF9A31C9), width: 1),
              minimumSize: Size(354, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(8),
              ),
              alignment: Alignment.centerLeft,
            ),
            onPressed: () {},
            child: const Text(
              'Senha *',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: Color(0xFF767474),
              ),
            ),
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 140,
              height: 18,
              margin: EdgeInsets.only(top: 6, left: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: marcado,
                    onChanged: (bool? value) {
                      setState(() {
                        marcado = value ?? false;
                      });
                    },
                    side: BorderSide(color: Color(0xFF71A151)),
                    activeColor: Color(0xFF71A151),
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  SizedBox(width: 3),
                  Text(
                    'Mostrar senha',
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF767474),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsetsGeometry.only(top: 16, right: 18, bottom: 27),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      'Esqueceu a senha?',
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF9A31C9),
              foregroundColor: Color(0xFF9A31C9),
              minimumSize: const Size(354, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {},
            child: const Text(
              'Entrar',
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsetsGeometry.only(top: 25, bottom: 18),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Color(0xFF767474),
                    thickness: 1,
                    endIndent: 11,
                  ),
                ),
                Text(
                  'Realize Login pela sua conta Google',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF767474),
                    wordSpacing: -0.3,
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Color(0xFF767474),
                    thickness: 1,
                    indent: 11,
                  ),
                ),
              ],
            ),
          ),

          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Color(0xFF9A31C9),
              side: BorderSide(color: Color(0xFF9A31C9), width: 1.5),
              fixedSize: Size(173, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(10),
              ),
            ),
            onPressed: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/googleIcon.png',
                  width: 33,
                  height: 33,
                  fit: BoxFit.none,
                ),
                SizedBox(width: 16),
                Text(
                  'Google',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF9A31C9),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsetsGeometry.only(top:18),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Color(0xFF767474),
                    thickness: 1,
                  ),
                ),
                Text(
                  'Ainda não possui uma conta?',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Color.fromARGB(255, 0, 0, 0),
                    wordSpacing: -0.3,
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(4),
                      child: Text(
                        'Criar Conta',
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF71A151),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Color(0xFF767474),
                    thickness: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}
