class Atenciones {
  Atenciones({
    this.title = '',
    this.imagePath = '',
    this.total = 0,
  });

  String title;
  int total;
  String imagePath;

  static List<Atenciones> categoryList = <Atenciones>[
    Atenciones(
      imagePath: 'assets/design_course/user-gobierno_central.png',
      title: 'Atenciones a nivel nacional',
      total: 17393388,
    ),
    Atenciones(
      imagePath: 'assets/design_course/user-gobierno_central.png',
      title: 'Atenciones 2022',
      total: 2577847,
    ),
  ];
}
