import 'package:flutter/material.dart';
import 'package:ibie/models/atividades_cards.dart';

class CustomCards extends StatelessWidget {
  final Atividade atividade;

  const CustomCards({required this.atividade, super.key});

  void _onCardTap(BuildContext context) {
    print('ok');
  }

  void _onProfessorTap(BuildContext context) {
    print('ok');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onCardTap(context),
      borderRadius: BorderRadius.circular(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: const BorderSide(
          color: Color(0xFFF3CEED),
          width: 4,
        ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              atividade.imagemUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 213,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    atividade.titulo,
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      SizedBox(width: 4,),
                      const Icon(
                        Icons.person,
                        size: 16,
                        color: Color(0xFF9A31C9),
                      ),
                      SizedBox(width: 6),
                      GestureDetector(
                        onTap: () => _onProfessorTap(context),
                        child: Text(atividade.professor),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 4,),
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Color(0xFF71A151),
                      ),
                      SizedBox(width: 4),
                      Text(atividade.dataHora),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 4,),
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Color(0xFF9A31C9),
                      ),
                      SizedBox(width: 4),
                      Text(atividade.local),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      atividade.preco,
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF71A151),
                      ),
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
