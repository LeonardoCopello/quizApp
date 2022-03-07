// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'helper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> marcadorDePontos = [];

  void conferirResposta(bool respostaSelecionadaPeloUsuario) {
    bool respostaCerta = helper.obterRespostaCorreta();

    if (helper.confereFimDaExecucao()) {
      Alert(context: context, title: "Fim do Quiz", desc: "Você respondeu a todas as perguntas.").show();
      helper.resetarNumeroQuestaoAtual();
      marcadorDePontos = [];
    } else {

      if (respostaCerta != respostaSelecionadaPeloUsuario) {
        marcadorDePontos.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      } else {
        marcadorDePontos.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      }
      helper.proximaQuestao();
    }
    
  }

  Helper helper = Helper();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                helper.obterQuestao(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            padding: EdgeInsets.all(20),
            primary: Colors.white,
            textStyle: TextStyle(
              fontSize: 20,
            ),
          ),
          child: Text('True'),
          onPressed: () {
            setState(
              () {
                
                conferirResposta(true);
                
              },
            );
          },
        ),
        SizedBox(
          height: 20,
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey,
            padding: EdgeInsets.all(20),
            primary: Colors.white,
            textStyle: TextStyle(
              fontSize: 20,
            ),
          ),
          child: Text('False'),
          onPressed: () {
            setState(
              () {
                conferirResposta(false);
                 if (helper.confereFimDaExecucao()) {
                  Alert(context: context, title: "Fim do Quiz", desc: "Você chegou ao fim do Quiz. Parabéns!").show();
                  helper.resetarNumeroQuestaoAtual();
                  marcadorDePontos = [];
                 }
              },
            );
          },
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          children: marcadorDePontos,
        )
      ],
    );
  }
}
