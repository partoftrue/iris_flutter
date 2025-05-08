import '../models/user.dart';
import '../services/api_service.dart';

class UserRepository {
  // Get all users
  Future<List<User>> getUsers() async {
    final response = await ApiService.get('/users');
    return (response as List).map((json) => User.fromJson(json)).toList();
  }

  // Get user by ID
  Future<User> getUserById(String id) async {
    final response = await ApiService.get('/users/$id');
    return User.fromJson(response);
  }

  // Create new user
  Future<User> createUser(Map<String, dynamic> userData) async {
    final response = await ApiService.post('/users', userData);
    return User.fromJson(response);
  }

  // Update user
  Future<User> updateUser(String id, Map<String, dynamic> userData) async {
    final response = await ApiService.patch('/users/$id', userData);
    return User.fromJson(response);
  }

  // Delete user
  Future<void> deleteUser(String id) async {
    await ApiService.delete('/users/$id');
  }

  // Get all employees
  Future<List<User>> getEmployees() async {
    final response = await ApiService.get('/users/role/employees');
    return (response as List).map((json) => User.fromJson(json)).toList();
  }

  // Get all employers
  Future<List<User>> getEmployers() async {
    final response = await ApiService.get('/users/role/employers');
    return (response as List).map((json) => User.fromJson(json)).toList();
  }
} 