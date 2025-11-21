// lib/blocs/order_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/menu_model.dart';

// State untuk menyimpan data pesanan
class OrderState {
  final Map<String, OrderItem> items;
  final double transactionDiscount; // Diskon total transaksi (0-1)

  OrderState({
    this.items = const {},
    this.transactionDiscount = 0.0,
  });

  OrderState copyWith({
    Map<String, OrderItem>? items,
    double? transactionDiscount,
  }) {
    return OrderState(
      items: items ?? this.items,
      transactionDiscount: transactionDiscount ?? this.transactionDiscount,
    );
  }
}

// Class untuk menyimpan item pesanan dengan quantity
class OrderItem {
  final MenuModel menu;
  final int quantity;

  OrderItem({
    required this.menu,
    required this.quantity,
  });

  OrderItem copyWith({
    MenuModel? menu,
    int? quantity,
  }) {
    return OrderItem(
      menu: menu ?? this.menu,
      quantity: quantity ?? this.quantity,
    );
  }

  // Total harga untuk item ini (sudah termasuk diskon per item)
  int getTotalPrice() {
    return menu.getDiscountedPrice() * quantity;
  }
}

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderState());

  // Menambahkan menu ke pesanan
  void addToOrder(MenuModel menu) {
    final currentItems = Map<String, OrderItem>.from(state.items);
    
    if (currentItems.containsKey(menu.id)) {
      // Jika sudah ada, tambah quantity
      final existingItem = currentItems[menu.id]!;
      currentItems[menu.id] = existingItem.copyWith(
        quantity: existingItem.quantity + 1,
      );
    } else {
      // Jika belum ada, tambahkan baru
      currentItems[menu.id] = OrderItem(menu: menu, quantity: 1);
    }

    emit(state.copyWith(
      items: currentItems,
      transactionDiscount: _calculateTransactionDiscount(currentItems),
    ));
  }

  // Menghapus menu dari pesanan
  void removeFromOrder(MenuModel menu) {
    final currentItems = Map<String, OrderItem>.from(state.items);
    
    if (currentItems.containsKey(menu.id)) {
      final existingItem = currentItems[menu.id]!;
      
      if (existingItem.quantity > 1) {
        // Kurangi quantity
        currentItems[menu.id] = existingItem.copyWith(
          quantity: existingItem.quantity - 1,
        );
      } else {
        // Hapus item jika quantity = 1
        currentItems.remove(menu.id);
      }

      emit(state.copyWith(
        items: currentItems,
        transactionDiscount: _calculateTransactionDiscount(currentItems),
      ));
    }
  }

  // Update quantity secara langsung
  void updateQuantity(MenuModel menu, int qty) {
    if (qty <= 0) {
      removeItemCompletely(menu);
      return;
    }

    final currentItems = Map<String, OrderItem>.from(state.items);
    
    if (currentItems.containsKey(menu.id)) {
      currentItems[menu.id] = currentItems[menu.id]!.copyWith(quantity: qty);
    } else {
      currentItems[menu.id] = OrderItem(menu: menu, quantity: qty);
    }

    emit(state.copyWith(
      items: currentItems,
      transactionDiscount: _calculateTransactionDiscount(currentItems),
    ));
  }

  // Hapus item sepenuhnya dari pesanan
  void removeItemCompletely(MenuModel menu) {
    final currentItems = Map<String, OrderItem>.from(state.items);
    currentItems.remove(menu.id);
    
    emit(state.copyWith(
      items: currentItems,
      transactionDiscount: _calculateTransactionDiscount(currentItems),
    ));
  }

  // Mendapatkan total harga sebelum diskon transaksi
  int getSubtotal() {
    return state.items.values.fold(
      0,
      (sum, item) => sum + item.getTotalPrice(),
    );
  }

  // Mendapatkan jumlah diskon transaksi dalam rupiah
  int getTransactionDiscountAmount() {
    return (getSubtotal() * state.transactionDiscount).toInt();
  }

  // Mendapatkan total harga setelah semua diskon
  int getTotalPrice() {
    final subtotal = getSubtotal();
    final transactionDiscountAmount = (subtotal * state.transactionDiscount).toInt();
    return subtotal - transactionDiscountAmount;
  }

  // Menghitung diskon transaksi otomatis berdasarkan subtotal
  double _calculateTransactionDiscount(Map<String, OrderItem> items) {
    final subtotal = items.values.fold(
      0,
      (sum, item) => sum + item.getTotalPrice(),
    );

    // Bonus: Diskon 10% jika total > Rp100.000
    if (subtotal > 100000) {
      return 0.1; // 10% discount
    }
    
    return 0.0;
  }

  // Menghapus semua pesanan
  void clearOrder() {
    emit(OrderState());
  }

  // Get quantity untuk menu tertentu
  int getQuantity(String menuId) {
    return state.items[menuId]?.quantity ?? 0;
  }

  // Get total items count
  int getTotalItems() {
    return state.items.values.fold(
      0,
      (sum, item) => sum + item.quantity,
    );
  }
}