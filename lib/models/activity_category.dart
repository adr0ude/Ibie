class ActivityCategory {
  final String name;
  final String icon;

  const ActivityCategory(this.name, this.icon);

  @override
  String toString() => name;
}

const List<ActivityCategory> defaultCategories = [
  ActivityCategory('Esportes', 'assets/esportesIcon.svg'),
  ActivityCategory('Música', 'assets/musicaIcon.svg'),
  ActivityCategory('Cultura', 'assets/culturaIcon.svg'),
  ActivityCategory('Artes', 'assets/artesIcon.svg'),
  ActivityCategory('Educação', 'assets/educacaoIcon.svg'),
  ActivityCategory('Recreação', 'assets/recreacaoIcon.svg'),
];
