// lib/pages/order_home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/order_cubit.dart';
import '../models/menu_model.dart';
import '../widgets/menu_card.dart';

class OrderHomePage extends StatefulWidget {
  const OrderHomePage({Key? key}) : super(key: key);

  @override
  State<OrderHomePage> createState() => _OrderHomePageState();
}

class _OrderHomePageState extends State<OrderHomePage> with SingleTickerProviderStateMixin {
  String selectedCategory = 'Makanan';
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Data menu dummy
  final List<MenuModel> allMenus = [
    // Makanan
    MenuModel(
      id: 'M1',
      name: 'Nasi Goreng Spesial',
      price: 20000,
      category: 'Makanan',
      discount: 0.2,
    ),
    MenuModel(
      id: 'M2',
      name: 'Mie Ayam Bakso',
      price: 15000,
      category: 'Makanan',
      discount: 0.0,
    ),
    MenuModel(
      id: 'M3',
      name: 'Ayam Geprek Sambal Matah',
      price: 18000,
      category: 'Makanan',
      discount: 0.15,
    ),
    MenuModel(
      id: 'M4',
      name: 'Soto Ayam Lamongan',
      price: 16000,
      category: 'Makanan',
      discount: 0.0,
    ),
    MenuModel(
      id: 'M5',
      name: 'Nasi Uduk',
      price: 13000,
      category: 'Makanan',
      discount: 0.1,
    ),
    
    // Minuman
    MenuModel(
      id: 'D1',
      name: 'Es Teh Manis',
      price: 5000,
      category: 'Minuman',
      discount: 0.0,
    ),
    MenuModel(
      id: 'D2',
      name: 'Es Jeruk Peras',
      price: 7000,
      category: 'Minuman',
      discount: 0.1,
    ),
    MenuModel(
      id: 'D3',
      name: 'Kopi Susu Gula Aren',
      price: 12000,
      category: 'Minuman',
      discount: 0.0,
    ),
    MenuModel(
      id: 'D4',
      name: 'Jus Alpukat',
      price: 15000,
      category: 'Minuman',
      discount: 0.2,
    ),
    MenuModel(
      id: 'D5',
      name: 'Thai Tea',
      price: 10000,
      category: 'Minuman',
      discount: 0.15,
    ),
    
    // Snack
    MenuModel(
      id: 'S1',
      name: 'Pisang Goreng Keju',
      price: 8000,
      category: 'Snack',
      discount: 0.0,
    ),
    MenuModel(
      id: 'S2',
      name: 'Tahu Isi',
      price: 10000,
      category: 'Snack',
      discount: 0.25,
    ),
    MenuModel(
      id: 'S3',
      name: 'Cireng Bumbu Rujak',
      price: 6000,
      category: 'Snack',
      discount: 0.0,
    ),
    MenuModel(
      id: 'S4',
      name: 'Batagor',
      price: 12000,
      category: 'Snack',
      discount: 0.1,
    ),
  ];

  List<MenuModel> get filteredMenus {
    return allMenus.where((menu) => menu.category == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF2C3E50),
        title: const Row(
          children: [
            Icon(Icons.restaurant, size: 24, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Warung Makan',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              final cubit = context.read<OrderCubit>();
              final totalItems = cubit.getTotalItems();
              
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart_outlined, size: 26, color: Colors.white),
                      onPressed: () {
                        Navigator.pushNamed(context, '/summary');
                      },
                    ),
                    if (totalItems > 0)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE74C3C),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          child: Text(
                            '$totalItems',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header kategori
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildCategoryTab('Makanan', Icons.restaurant_menu),
                _buildCategoryTab('Minuman', Icons.local_cafe),
                _buildCategoryTab('Snack', Icons.cake),
              ],
            ),
          ),
          
          // Info kategori terpilih
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Padding(
              key: ValueKey(selectedCategory),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(selectedCategory).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getCategoryIcon(selectedCategory),
                        color: _getCategoryColor(selectedCategory),
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedCategory,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF34495E),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${filteredMenus.length} menu tersedia',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(selectedCategory).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${filteredMenus.length}',
                        style: TextStyle(
                          fontSize: 14,
                          color: _getCategoryColor(selectedCategory),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 12),
          
          // List menu berdasarkan kategori
          Expanded(
            child: filteredMenus.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 70,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Tidak ada menu tersedia',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: filteredMenus.length,
                    itemBuilder: (context, index) {
                      return FadeTransition(
                        opacity: _animationController,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.2, 0),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: _animationController,
                            curve: Interval(
                              index * 0.1,
                              1.0,
                              curve: Curves.easeOut,
                            ),
                          )),
                          child: MenuCard(menu: filteredMenus[index]),
                        ),
                      );
                    },
                  ),
          ),
          
          // Bottom bar dengan total
          BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              final cubit = context.read<OrderCubit>();
              final subtotal = cubit.getSubtotal();
              
              if (subtotal == 0) return const SizedBox.shrink();
              
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Subtotal',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Rp ${_formatPrice(subtotal)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF34495E),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/summary');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3498DB),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: const Row(
                          children: [
                            Text(
                              'Lihat Pesanan',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, size: 18),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(String category, IconData icon) {
    final isSelected = selectedCategory == category;
    
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedCategory = category;
            _animationController.reset();
            _animationController.forward();
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected 
                ? _getCategoryColor(category).withOpacity(0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected 
                  ? _getCategoryColor(category)
                  : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? _getCategoryColor(category) : Colors.grey.shade600,
                size: isSelected ? 26 : 24,
              ),
              const SizedBox(height: 6),
              Text(
                category,
                style: TextStyle(
                  color: isSelected ? _getCategoryColor(category) : Colors.grey.shade600,
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'makanan':
        return const Color(0xFFE67E22);
      case 'minuman':
        return const Color(0xFF3498DB);
      case 'snack':
        return const Color(0xFF9B59B6);
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'makanan':
        return Icons.restaurant_menu;
      case 'minuman':
        return Icons.local_cafe;
      case 'snack':
        return Icons.cake;
      default:
        return Icons.fastfood;
    }
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }
}