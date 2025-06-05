import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:thai_take_away_back_end/data/model/favorite_model.dart';
import 'package:thai_take_away_back_end/data/model/item_model.dart';
import 'package:thai_take_away_back_end/data/model/my_item_list_model.dart';
import 'package:thai_take_away_back_end/service/api_service.dart';


class ItemRepository {
  final ApiService apiService;

  ItemRepository(this.apiService);

  /// **ดึงรายการชื่อไอเทมที่ไม่ซ้ำกัน**
  Future<List<String>> getUniqueItemNames() async {
    try {
      final response = await apiService.get("/items/unique-names");
      List<String> itemNames = List<String>.from(response.data);
      return itemNames;
    } catch (e) {
      throw Exception("Failed to fetch unique item names");
    }
  }
  Future<List<ItemModel>> searchItems({String? name, required double latitude, required double longitude}) async {
    try {
      Map<String, dynamic> queryParams = {
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
      };

      if (name != null && name.isNotEmpty) {
        queryParams["name"] = name;
      }

      final response = await apiService.get("/items/search", query: queryParams);
      List<ItemModel> items = (response.data["items"] as List).map((item) => ItemModel.fromJson(item)).toList();
      return items;
    } catch (e) {
      throw Exception("Failed to search items");
    }
  }

  /// **สร้างไอเทมใหม่**
  Future<String> createItem({
    required String name,
    required String category,
    required String description,
    required double latitude,
    required double longitude,
    required int posterUserId,
    File? image,
  }) async {
    try {
      // ตรวจสอบ MIME type ของไฟล์
      String? mimeType = image != null ? lookupMimeType(image.path) : null;
      print("📌 Uploading File: ${image?.path}");
      print("📌 Detected MIME Type: $mimeType");

      FormData formData = FormData.fromMap({
        "name": name,
        "category": category,
        "description": description,
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
        "poster_user_id": posterUserId.toString(),
        if (image != null)
          "image": await MultipartFile.fromFile(
            image.path,
            contentType: mimeType != null ? MediaType.parse(mimeType) : MediaType("image", "jpeg"),
          ),
      });

      final response = await apiService.post("/items", data: formData);
      return response.data["message"]; // "Item created successfully"
    } on DioException catch (e) {
      print("🚨 SERVER RESPONSE: ${e.response?.data}");
      throw Exception("Server Error: ${e.response?.data["message"] ?? "Unknown error"}");
    }
  }

  Future<List<ItemListModel>> getItemsByUserId(int userId) async {
    try {
      final response = await apiService.get("/items/user/$userId");
      List<ItemListModel> items = (response.data as List).map((json) => ItemListModel.fromJson(json)).toList();
      return items;
    } catch (e) {
      throw Exception("Failed to fetch items");
    }
  }

  Future<String> deleteItemById(int itemId) async {
    try {
      final response = await apiService.delete("/items/$itemId");
      return response.data["message"];
    } catch (e) {
      throw Exception("Failed to delete item");
    }
  }

  Future<List<ItemModel>> getItemsByCategory({
    required String category,
    required String latitude,
    required String longitude,
  }) async {
    try {
      Map<String, dynamic> queryParams = {
        "category": category,
        "latitude": latitude,
        "longitude": longitude,
      };
      final response = await apiService.get(
        "/items/search/category",  query:queryParams
      );

      return (response.data["items"] as List)
          .map((json) => ItemModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch items by category");
    }
  }

  Future<String> addFavorite({
    required int userId,
    required int itemId,
  }) async {
    try {
      final response = await apiService.post(
        "/items/favorites",
        data: {
          "user_id": userId,
          "item_id": itemId,
        },
      );
      return response.data["message"];
    } catch (e) {
      throw Exception("Failed to add item to favorites");
    }
  }

  Future<List<FavoriteModel>> getFavoritesByUserId(int userId) async {
    try {
      final response = await apiService.get("/items/favorites/$userId");
      return (response.data as List).map((json) => FavoriteModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Failed to fetch favorites");
    }
  }

  Future<String> deleteFavorite({
    required int userId,
    required int itemId,
  }) async {
    try {
      final response = await apiService.delete(
        "/items/favorites/delete",
        data: {
          "user_id": userId,
          "item_id": itemId,
        },
      );
      return response.data["message"];
    } catch (e) {
      throw Exception("Failed to remove item from favorites");
    }
  }

}




