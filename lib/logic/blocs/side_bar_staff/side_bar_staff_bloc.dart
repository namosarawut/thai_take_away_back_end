import 'package:flutter_bloc/flutter_bloc.dart';
/// 1. กำหนด enum สำหรับเลือกประเภทของไอคอนที่ active
enum SideBarStaffSelectedItem { notification, order, menu }

/// 2. สร้าง Event สำหรับเปลี่ยนการเลือกไอคอน
abstract class SideBarStaffEvent {}

class SelectSideBarStaffItem extends SideBarStaffEvent {
  final SideBarStaffSelectedItem selectedItem;
  SelectSideBarStaffItem({required this.selectedItem});
}

/// 3. สร้าง State เพื่อเก็บข้อมูลการเลือกไอคอน
class SideBarStaffState {
  final SideBarStaffSelectedItem selectedItem;
  SideBarStaffState({required this.selectedItem});
}

/// 4. สร้าง Bloc สำหรับจัดการ logic ของ SideBarStaff
class SideBarStaffBloc extends Bloc<SideBarStaffEvent, SideBarStaffState> {
  SideBarStaffBloc()
      : super(SideBarStaffState(selectedItem: SideBarStaffSelectedItem.notification)) {
    on<SelectSideBarStaffItem>((event, emit) {
      emit(SideBarStaffState(selectedItem: event.selectedItem));
    });
  }
}