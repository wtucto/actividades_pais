import 'package:actividades_pais/src/views/model/product_model.dart';
import 'package:actividades_pais/src/views/screens/details.dart';
import 'package:actividades_pais/src/views/widgets/my_button.dart';
import 'package:actividades_pais/src/views/widgets/my_checkbox.dart';
import 'package:actividades_pais/src/views/widgets/my_radio_button.dart';
import 'package:actividades_pais/src/views/widgets/my_text_filed.dart';
import 'package:flutter/material.dart';

class MyForms extends StatefulWidget {
  const MyForms({super.key});

  @override
  State<MyForms> createState() => _MyFormsState();
}

class _MyFormsState extends State<MyForms> {
  _MyFormsState() {
    _dropdownSelectedValue = _productSizesList[0];
  }

  String? _dropdownSelectedValue;
  bool? _topProduct = false;
  ProducTypeEnum? _producTypeRadioButton;
  final _productController = TextEditingController();
  final _productDesController = TextEditingController();
  final _productSizesList = ["Reinicio", "Medium", "Large", "XLarge"];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Monitoreo"), centerTitle: true),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              const Text("Agregar Monitoreo"),
              const SizedBox(height: 30.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    MyTextField(
                      myController: _productController,
                      fieldName: "Id Monitorea",
                      myIcon: Icons.propane_outlined,
                      prefixIconColor: Colors.deepPurple.shade300,
                    ),
                    const SizedBox(height: 10.0),
                    MyTextField(
                      myController: _productDesController,
                      fieldName: "Estado de Monitoreo",
                      myIcon: Icons.text_fields_outlined,
                      prefixIconColor: Colors.deepPurple.shade300,
                    ),
                    // MyCheckBox(
                    //   checkBoxValue: _topProduct,
                    //   onChange: (val) {
                    //     setState(() {
                    //       _topProduct = val;
                    //     });
                    //   },
                    //   fieldName: 'Top Product',
                    // ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        MyRadioButton(
                          // title: ProducTypeEnum.Deliverable.name,
                          title: 'Alto',
                          value: ProducTypeEnum.Deliverable,
                          producTypeEnum: _producTypeRadioButton,
                          onChanged: (val) {
                            setState(() {
                              _producTypeRadioButton = val;
                            });
                          },
                        ),
                        const SizedBox(width: 5.0),
                        MyRadioButton(
                          // title: ProducTypeEnum.Donwloadable.name,
                          title: 'Medio',
                          value: ProducTypeEnum.Donwloadable,
                          producTypeEnum: _producTypeRadioButton,
                          onChanged: (val) {
                            setState(() {
                              _producTypeRadioButton = val;
                            });
                          },
                        ),
                        const SizedBox(width: 5.0),
                        MyRadioButton(
                          title: "Bajo",
                          value: ProducTypeEnum.Donwloadable,
                          producTypeEnum: _producTypeRadioButton,
                          onChanged: (val) {
                            setState(() {
                              _producTypeRadioButton = val;
                            });
                          },
                        ),
                      ],
                    ),
                    DropdownButtonFormField(
                      value: _dropdownSelectedValue,
                      items: _productSizesList
                          .map(
                            (e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _dropdownSelectedValue = val;
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.deepPurple,
                      ),
                      dropdownColor: Colors.deepPurple.shade50,
                      decoration: const InputDecoration(
                          labelText: "Estado de Avance",
                          prefixIcon: Icon(
                            Icons.accessibility_new_rounded,
                            color: Colors.deepPurple,
                          ),
                          // border: OutlineInputBorder(),
                          border: UnderlineInputBorder()),
                    ),
                    Row(
                      children: [
                        MyButton(
                          btnText: 'Guardar',
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(content: Text('Processing')),
                              // );
                              ProductDetails productDetails = ProductDetails();
                              productDetails.productName =
                                  _productController.text;
                              productDetails.productDetails =
                                  _productDesController.text;
                              productDetails.isTopProduct = _topProduct!;
                              productDetails.productType =
                                  _producTypeRadioButton!;
                              productDetails.productSIze =
                                  _dropdownSelectedValue!;

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Details(productDetails: productDetails);
                              }));
                            }
                          },
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        MyButton(
                          btnText: "Enviar",
                          onPress: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
