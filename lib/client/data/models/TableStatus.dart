enum TableStatus {
  available,          // Bàn trống
  waiting,       // Chờ phục vụ
  occupied,       // Đang được phục vụ
}

TableStatus statusFromString(String s) {
  switch (s) {
    case 'available': return TableStatus.available;
    case 'waiting': return TableStatus.waiting;
    case 'occupied': return TableStatus.occupied;
    default: return TableStatus.available;
  }
}

String statusToString(TableStatus s) {
  switch (s) {
    case TableStatus.available: return 'available';
    case TableStatus.waiting: return 'waiting';
    case TableStatus.occupied: return 'occupied';
  }
}
