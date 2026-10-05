import 'package:flutter/material.dart';
import '../models/empleado_model.dart';

class AsistenciaProvider extends ChangeNotifier {
  List<EmpleadoModel> _empleados = [];
  bool _isLoading = false;

  List<EmpleadoModel> get empleados => _empleados;
  bool get isLoading => _isLoading;

  AsistenciaProvider() {
    _loadSampleEmpleados();
  }

  void _loadSampleEmpleados() {
    _empleados = [
      EmpleadoModel(
        id: 'emp-001',
        nombreCompleto: 'Marta Isabel Rodriguez',
        codigoAsistencia: 'ZK-1024',
        identidad: '0801-1992-05421',
        puesto: 'Supervisora de Ventas',
        departamento: 'Ventas San Pedro Sula',
        fechaIngreso: DateTime(2021, 3, 15),
        salarioBase: 28500.0,
      ),
      EmpleadoModel(
        id: 'emp-002',
        nombreCompleto: 'Carlos Eduardo Mejia',
        codigoAsistencia: 'ZK-1088',
        identidad: '0501-1988-12093',
        puesto: 'Encargado de Bodega Central',
        departamento: 'Logística & Almacén',
        fechaIngreso: DateTime(2019, 8, 1),
        salarioBase: 22000.0,
      ),
      EmpleadoModel(
        id: 'emp-003',
        nombreCompleto: 'Kevin Alexander Ramos',
        codigoAsistencia: 'ZK-1140',
        identidad: '0801-1996-88712',
        puesto: 'Motorista de Distribución',
        departamento: 'Logística & Almacén',
        fechaIngreso: DateTime(2022, 1, 10),
        salarioBase: 16500.0,
      ),
    ];
  }
}
