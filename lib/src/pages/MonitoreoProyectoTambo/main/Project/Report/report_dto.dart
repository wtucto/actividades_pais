import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';

class ReportDto {
  final String customer;
  final String address;
  final String name;
  final List<TramaMonitoreoModel> items;
  ReportDto({
    required this.customer,
    required this.address,
    required this.items,
    required this.name,
  });
  double totalItems() {
    return items.fold(
      0,
      (previousValue, element) => previousValue + 1,
    );
  }
}
