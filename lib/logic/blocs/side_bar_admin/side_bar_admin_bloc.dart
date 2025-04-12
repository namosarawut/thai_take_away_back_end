import 'package:flutter_bloc/flutter_bloc.dart';
/// 1. กำหนด enum สำหรับเลือกประเภทของไอคอนที่ active
enum SideBarAdminSelectedItem { location, customer, staff }

/// 2. สร้าง Event สำหรับเปลี่ยนการเลือกไอคอน
abstract class SideBarAdminEvent {}

class SelectSideBarAdminItem extends SideBarAdminEvent {
  final SideBarAdminSelectedItem selectedItem;
  SelectSideBarAdminItem({required this.selectedItem});
}

/// 3. สร้าง State เพื่อเก็บข้อมูลการเลือกไอคอน
class SideBarAdminState {
  final SideBarAdminSelectedItem selectedItem;
  SideBarAdminState({required this.selectedItem});
}

/// 4. สร้าง Bloc สำหรับจัดการ logic ของ SideBarAdmin
class SideBarAdminBloc extends Bloc<SideBarAdminEvent, SideBarAdminState> {
  SideBarAdminBloc()
      : super(SideBarAdminState(selectedItem: SideBarAdminSelectedItem.location)) {
    on<SelectSideBarAdminItem>((event, emit) {
      emit(SideBarAdminState(selectedItem: event.selectedItem));
    });
  }
}