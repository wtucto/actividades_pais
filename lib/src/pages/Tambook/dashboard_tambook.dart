import 'package:actividades_pais/src/pages/Tambook/atenciones_list_view.dart';
import 'package:actividades_pais/src/pages/Tambook/detalle_tambooK.dart';
import 'package:flutter/material.dart';

class DashboardTambook extends StatefulWidget {
  const DashboardTambook({super.key});

  @override
  State<DashboardTambook> createState() => _DashboardTambookState();
}

class _DashboardTambookState extends State<DashboardTambook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("TAMBOOK"),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              iconSize: 30,
              onPressed: () {},
              icon: const Icon(
                Icons.book,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Color(0xFFFAFAFA),
            pinned: true,
            snap: true,
            floating: true,
            title: getHeader(),
          ),
          SliverToBoxAdapter(child: getBody())
        ],
      ),
    );
  }

  getHeader() {
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Bienvenidos!",
                    style: TextStyle(
                        color: Color(0xFF3E4249),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Programa Nacional Pais",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetalleTambook(),
                    ),
                  );
                },
                child: const CustomImage(
                  'https://avatars.githubusercontent.com/u/86506519?v=4',
                  width: 35,
                  height: 35,
                  trBackground: true,
                  borderColor: Color(0xFF3498db),
                  radius: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  getBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: const [
                Expanded(
                  child: CustomTextBox(
                    hint: "Buscar por Tambo",
                    prefix: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // Atenciones
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              AtencionesListView(),
            ],
          ),
          getPopularCourseUI()
          // Intervenciones
        ],
      ),
    );
  }

  Widget getPopularCourseUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Últimas Intervenciones',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: Colors.black,
            ),
          ),
          const Divider(color: Color.fromRGBO(61, 61, 61, 1)),
          Card(
            margin: const EdgeInsets.all(5),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                const ListTile(
                  title: Text(
                    'SUB PREFECTURA',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      letterSpacing: 0.27,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Text(
                    'VI Feria Agromercado 2022, con la finalidad de comercializar los productos agropecuarios y derivados propios de la zona a precios razonables y cumpliendo los protocolos de bioseguridad directamente a los consumidores finales, evento realizado por la Agencia Agraria Melgar, dirigido a las asociaciones de productores y población del distrito de Ayaviri.',
                    textAlign: TextAlign.justify,
                  ),
                ),
                Image.asset('assets/design_course/tercero.jpeg'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Search Tambook
class CustomTextBox extends StatefulWidget {
  const CustomTextBox(
      {Key? key,
      this.hint = "",
      this.prefix,
      this.suffix,
      this.controller,
      this.readOnly = false})
      : super(key: key);
  final String hint;
  final Widget? prefix;
  final Widget? suffix;
  final bool readOnly;
  final TextEditingController? controller;

  @override
  State<CustomTextBox> createState() => _CustomTextBoxState();
}

class _CustomTextBoxState extends State<CustomTextBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 3),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color.fromARGB(255, 170, 161, 161)),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black87.withOpacity(0.05),
            spreadRadius: .5,
            blurRadius: .5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        readOnly: widget.readOnly,
        controller: widget.controller,
        onChanged: (value) {},
        decoration: InputDecoration(
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffix,
            border: InputBorder.none,
            hintText: widget.hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 15)),
      ),
    );
  }
}

class CustomImage extends StatelessWidget {
  const CustomImage(this.name,
      {this.width = 100,
      this.height = 100,
      this.bgColor,
      this.borderWidth = 0,
      this.borderColor,
      this.trBackground = false,
      this.isNetwork = true,
      this.radius = 50});
  final String name;
  final double width;
  final double height;
  final double borderWidth;
  final Color? borderColor;
  final Color? bgColor;
  final bool trBackground;
  final bool isNetwork;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black87.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
        image: DecorationImage(image: NetworkImage(name), fit: BoxFit.cover),
      ),
    );
  }
}
