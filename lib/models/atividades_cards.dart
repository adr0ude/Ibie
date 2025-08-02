import 'activity.dart';

class Atividade {
  final String categoria;
  final String titulo;
  final String professor;
  final String dataHora;
  final String local;
  final String imagemUrl;
  final String preco;

  Atividade({
    required this.categoria,
    required this.titulo,
    required this.professor,
    required this.dataHora,
    required this.local,
    required this.imagemUrl,
    required this.preco,
  });

  factory Atividade.fromActivity(Activity activity, String professorName) {
    return Atividade(
      categoria: activity.category,
      titulo: activity.title,
      professor: professorName,
      dataHora: '${activity.date} às ${activity.time}',
      local: activity.location,
      imagemUrl: activity.documentUrl ?? 'assets/default.jpg',
      preco: activity.fee != null && activity.fee! > 0
          ? 'R\$ ${activity.fee!.toStringAsFixed(2)}'
          : 'Grátis',
    );
  }
}
