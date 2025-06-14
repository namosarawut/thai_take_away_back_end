// data/model/pagination_model.dart

class PaginationModel {
  final int page;
  final int totalPages;
  final int totalItems;

  PaginationModel({
    required this.page,
    required this.totalPages,
    required this.totalItems,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      page: json['page'] as int,
      totalPages: json['totalPages'] as int,
      totalItems: json['totalItems'] as int,
    );
  }
}
