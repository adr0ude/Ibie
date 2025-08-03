import 'activity.dart';

class Atividade {
  final String categoria;
  final String titulo;
  final String professor;
  final String dataHora;
  final String local;
  final String imagem;
  final String preco;

  Atividade({
    required this.categoria,
    required this.titulo,
    required this.professor,
    required this.dataHora,
    required this.local,
    required this.imagem,
    required this.preco,
  });

  factory Atividade.fromActivity(Activity activity, String professorName) {
    return Atividade(
      categoria: activity.category,
      titulo: activity.title,
      professor: professorName,
      dataHora: '${activity.date} às ${activity.time}',
      local: activity.location,
      imagem: activity.documentUrl ?? 'assets/default.jpg',
      preco: activity.fee != null && activity.fee! > 0
          ? 'R\$ ${activity.fee!.toStringAsFixed(2)}'
          : 'Grátis',
    );
  }
}
