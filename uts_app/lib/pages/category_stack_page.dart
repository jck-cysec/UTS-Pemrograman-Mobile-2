// lib/pages/category_stack_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/order_cubit.dart';
import '../models/menu_model.dart';
import '../widgets/menu_card.dart';

class CategoryStackPage extends StatefulWidget {
  const CategoryStackPage({Key? key}) : super(key: key);

  @override
  State<CategoryStackPage> createState() => _CategoryStackPageState();
}

class _CategoryStackPageState extends State<CategoryStackPage> with SingleTickerProviderStateMixin {
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
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Row(
          children: [
            Icon(Icons.restaurant, size: 28),
            SizedBox(width: 10),
            Text(
              'Warung Makan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
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
                padding: const EdgeInsets.only(right: 8),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.shopping_cart, size: 26),
                        onPressed: () {
                          Navigator.pushNamed(context, '/summary');
                        },
                      ),
                    ),
                    if (totalItems > 0)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          child: Text(
                            '$totalItems',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
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
          // Header kategori dengan Stack dan animasi
          Container(
            height: 140,
            margin: const EdgeInsets.all(16),
            child: Stack(
              children: [
                // Background gradient dengan shadow
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF8E53), Color(0xFFFE6B8B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                ),
                
                // Decorative circles
                Positioned(
                  right: -20,
                  top: -20,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  left: -30,
                  bottom: -30,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                
                // Category tabs
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCategoryButton('Makanan', Icons.restaurant_menu),
                        _buildCategoryButton('Minuman', Icons.local_cafe),
                        _buildCategoryButton('Snack', Icons.cake),
                      ],
                    ),
                  ),
                ),
                
                // Animated indicator
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  bottom: 12,
                  left: _getIndicatorPosition(),
                  child: Container(
                    width: 90,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Info kategori terpilih dengan animasi
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Padding(
              key: ValueKey(selectedCategory),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(selectedCategory).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            _getCategoryIcon(selectedCategory),
                            color: _getCategoryColor(selectedCategory),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedCategory,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D3436),
                              ),
                            ),
                            Text(
                              '${filteredMenus.length} menu tersedia',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            _getCategoryColor(selectedCategory).withOpacity(0.8),
                            _getCategoryColor(selectedCategory),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${filteredMenus.length}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
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
                          size: 80,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Tidak ada menu tersedia',
                          style: TextStyle(
                            fontSize: 16,
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
                            begin: const Offset(0.3, 0),
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
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, -5),
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
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Rp ${_formatPrice(subtotal)}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D3436),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/summary');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Row(
                            children: [
                              Text(
                                'Lihat Pesanan',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, size: 20),
                            ],
                          ),
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

  Widget _buildCategoryButton(String category, IconData icon) {
    final isSelected = selectedCategory == category;
    
    return GestureDetector(
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
        width: 95,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected 
              ? Colors.white.withOpacity(0.3) 
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected 
                ? Colors.white.withOpacity(0.5) 
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: isSelected ? 36 : 32,
            ),
            const SizedBox(height: 6),
            Text(
              category,
              style: TextStyle(
                color: Colors.white,
                fontSize: isSelected ? 15 : 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getIndicatorPosition() {
    final screenWidth = MediaQuery.of(context).size.width;
    switch (selectedCategory) {
      case 'Makanan':
        return (screenWidth / 6) - 45;
      case 'Minuman':
        return (screenWidth / 2) - 45;
      case 'Snack':
        return screenWidth - (screenWidth / 6) - 45;
      default:
        return (screenWidth / 6) - 45;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'makanan':
        return const Color(0xFFFF6B6B);
      case 'minuman':
        return const Color(0xFF4ECDC4);
      case 'snack':
        return const Color(0xFFBE63F9);
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