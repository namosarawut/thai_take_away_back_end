import 'package:flutter_bloc/flutter_bloc.dart';
/// 1. กำหนด enum สำหรับเลือกประเภทของไอคอนที่ active
enum SideBarSelectedItem { location, customer, staff }

/// 2. สร้าง Event สำหรับเปลี่ยนการเลือกไอคอน
abstract class SideBarEvent {}

class SelectSideBarItem extends SideBarEvent {
  final SideBarSelectedItem selectedItem;
  SelectSideBarItem({required this.selectedItem});
}

/// 3. สร้าง State เพื่อเก็บข้อมูลการเลือกไอคอน
class SideBarState {
  final SideBarSelectedItem selectedItem;
  SideBarState({required this.selectedItem});
}

/// 4. สร้าง Bloc สำหรับจัดการ logic ของ Sidebar
class SideBarBloc extends Bloc<SideBarEvent, SideBarState> {
  SideBarBloc()
      : super(SideBarState(selectedItem: SideBarSelectedItem.location)) {
    on<SelectSideBarItem>((event, emit) {
      emit(SideBarState(selectedItem: event.selectedItem));
    });
  }
}