enum SocketActionsTypes {
  subscribe,
  changePass,
  unSubscribe,
  openPos,
  closePos,
  modifyPos,
  openOrder,
  modifyOrder,
  deleteOrder
}

extension SocketActionsTypesExt on SocketActionsTypes {
  static SocketActionsTypes? parse(String action) {
    switch (action) {
      case 'SUBSCRIBE':
        return SocketActionsTypes.subscribe;
      case 'CHANGE_PASS':
        return SocketActionsTypes.changePass;
      case 'UNSUBSCRIBE':
        return SocketActionsTypes.unSubscribe;
      case 'OPEN_POS':
        return SocketActionsTypes.openPos;
      case 'MODIFY_POS':
        return SocketActionsTypes.modifyPos;
      case 'OPEN_ORDER':
        return SocketActionsTypes.openOrder;
      case 'MODIFY_ORDER':
        return SocketActionsTypes.modifyOrder;
      case 'DELETE_ORDER':
        return SocketActionsTypes.deleteOrder;
      default:
        return null;
    }
  }
}