class AuthService {
  Future<bool> login(String email,String password) async {
    await Future.delayed(const Duration(milliseconds:800));
    return true;
  }

  Future<void> logout() async {}
}
