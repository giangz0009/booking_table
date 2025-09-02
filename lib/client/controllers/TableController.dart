import 'package:booking_table/client/data/models/Table.dart';
import 'package:booking_table/client/data/models/TableStatus.dart';
import 'package:booking_table/client/data/repositories/TableResponsitory.dart';
import 'package:get/get.dart';

class TableController extends GetxController {
  final _repo = TableRepository();

  final currentFloor = 1.obs;
  final tables = <RestaurantTable>[].obs;

  // trạng thái filter hiện tại (null = tất cả)
  final filterStatus = Rxn<TableStatus>();

  // danh sách sau khi lọc
  RxList<RestaurantTable> filteredTables = <RestaurantTable>[].obs;

  @override
  void onInit() {
    super.onInit();
    _listenFloor();
    _listenFilter();
  }

  void _listenFloor() {
    ever<int>(currentFloor, (floor) {
      _repo.streamByFloor(floor).listen((list) {
        tables.assignAll(list);
        _applyFilter();
      });
    });
    // trigger first
    currentFloor.refresh();
  }

  void _listenFilter() {
    ever<TableStatus?>(filterStatus, (_) {
      _applyFilter();
    });
  }

  void _applyFilter() {
    if (filterStatus.value == null) {
      filteredTables.assignAll(tables);
    } else {
      filteredTables.assignAll(
        tables.where((t) => t.status == filterStatus.value).toList(),
      );
    }
  }

  void setFloor(int floor) => currentFloor.value = floor;

  void setFilter(TableStatus? status) {
    filterStatus.value = status;
  }

  Future<void> setStatus(String id, TableStatus status) =>
      _repo.updateStatus(id, status);

  Future<void> merge(String idA, String idB) => _repo.mergeTables(idA, idB);

  Future<void> split(String id) => _repo.splitTable(id);

  Future<void> move(String id, int floor) => _repo.moveFloor(id, floor);
}
