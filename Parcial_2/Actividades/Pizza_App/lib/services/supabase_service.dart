import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    return await supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Future<List<Map<String, dynamic>>> getPizzas() async {
    final response = await supabase
        .from('pizzas')
        .select();

    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> getIngredientes(int pizzaId) async {
  final response = await supabase
      .from('ingredientes')
      .select('*')
      .eq('pizza_id', pizzaId);

  return List<Map<String, dynamic>>.from(response);
}
}