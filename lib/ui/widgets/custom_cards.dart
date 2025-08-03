import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibie/models/atividades_cards.dart';

class CustomCards extends StatelessWidget {
  final Atividade atividade;

  const CustomCards({required this.atividade, super.key});

  void _onCardTap(BuildContext context) {}

  void _onProfessorTap(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onCardTap(context),
      borderRadius: BorderRadius.circular(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Color(0xFFF3CEED), width: 4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            atividade.imagem != null && atividade.imagem.isNotEmpty
                ? Image.network(
                    atividade.imagem,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 213,
                  )
                : Container(
                    width: double.infinity,
                    height: 213,
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/placeholder.svg',
                      width: double.infinity,
                      height: 213,
                      fit: BoxFit.fill,
                    ),
                  ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                      SizedBox(width: 4),
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
                      SizedBox(width: 4),
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
                      SizedBox(width: 4),
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
