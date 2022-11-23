class Category {
  Category({
    this.title = '',
    this.imagePath = '',
    this.lessonCount = 0,
    this.money = 0,
    this.rating = 0.0,
  });

  String title;
  int lessonCount;
  int money;
  double rating;
  String imagePath;

  static List<Category> categoryList = <Category>[
    Category(
      imagePath: 'assets/design_course/user-gobierno_central.png',
      title: 'Atenciones a nivel nacional',
      lessonCount: 24,
      money: 17393388,
      rating: 4.3,
    ),
    Category(
      imagePath: 'assets/design_course/user-gobierno_central.png',
      title: 'Atenciones 2022',
      lessonCount: 22,
      money: 2577847,
      rating: 4,
    ),
    /*Category(
      imagePath: 'assets/design_course/interFace1.png',
      title: 'Atenciones a nivel nacional',
      lessonCount: 24,
      money: 25,
      rating: 4.3,
    ),
    Category(
      imagePath: 'assets/design_course/interFace2.png',
      title: 'Atenciones',
      lessonCount: 22,
      money: 18,
      rating: 4.6,
    ),*/
  ];

  static List<Category> popularCourseList = <Category>[
    Category(
      imagePath: 'assets/design_course/puno.jpeg',
      title: 'DIRECCION REGIONAL DE AGRICULTURA',
      lessonCount: 12,
      money: 25,
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/design_course/segundo.jpg',
      title: 'FISE',
      lessonCount: 28,
      money: 208,
      rating: 4.9,
    ),
    Category(
      imagePath: 'assets/design_course/tercero.jpeg',
      title: 'SUB PREFECTURA',
      lessonCount: 12,
      money: 25,
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/design_course/cuarto.jpg',
      title: 'CENTRO DE SALUD (ESPECIALIDAD)',
      lessonCount: 28,
      money: 208,
      rating: 4.9,
    ),
  ];
}
