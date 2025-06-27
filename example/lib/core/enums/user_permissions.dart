enum UserPermissions {
  noRights(0x00000000),
  connect(0x00000001),
  changePassword(0x00000002),
  trade(0x00000004),
  receiveReports(0x00000008);

  final int value;
  const UserPermissions(this.value);
}

extension PermissionChecker on int? {
  bool hasPermission(UserPermissions permission) {
    return ((this ?? 0) & permission.value) != 0;
  }

  List<UserPermissions> getPermissions() {
    return UserPermissions.values.where((permission) {
      return hasPermission(permission);
    }).toList();
  }
}
