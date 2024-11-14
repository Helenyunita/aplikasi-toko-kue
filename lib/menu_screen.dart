import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'keranjang.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<Map<String, dynamic>> cakeMenu = [
    {
      'name': 'Cookies',
      'image': 'assets/cookies.png',
      'description':
          'Kue kering khas lebaran dengan rasa butter yang lezat. Dibuat dengan bahan-bahan berkualitas dan resep tradisional.',
      'price': '10000',
      'rating': 4.5,
      'category': 'Kue Kering'
    },
    {
      'name': 'Red Velvet',
      'image': 'assets/red-velvet.png',
      'description':
          'Cake red velvet dengan cheese cream yang lembut. Paduan sempurna antara cake merah yang moist dan cream cheese yang creamy.',
      'price': '25000',
      'rating': 4.7,
      'category': 'Cake'
    },
    {
      'name': 'Chocolate Cake',
      'image': 'assets/Chococake.png',
      'description':
          'Cake cokelat lezat dengan lapisan cokelat tebal. Menggunakan dark chocolate premium untuk rasa yang intens.',
      'price': '30000',
      'rating': 4.8,
      'category': 'Cake'
    },
    {
      'name': 'Cheese Cake',
      'image': 'assets/cheesecake.png',
      'description':
          'Cake keju lembut dengan lapisan krim keju. Tekstur yang creamy dan rasa yang tidak terlalu manis.',
      'price': '35000',
      'rating': 4.9,
      'category': 'Cake'
    },
    {
      'name': 'Nastar',
      'image': 'assets/Nastar.png',
      'description':
          'Kue kering tradisional dengan isian selai nanas. Dibuat dengan selai nanas asli dan butter premium.',
      'price': '55000',
      'rating': 4.6,
      'category': 'Kue Kering'
    },
    {
      'name': 'Tiramisu',
      'image': 'assets/tiramisu.png',
      'description':
          'Cake tiramisu lembut dengan taburan bubuk kakao. Perpaduan sempurna kopi dan mascarpone cheese.',
      'price': '40000',
      'rating': 4.7,
      'category': 'Cake'
    },
    {
      'name': 'Pudding',
      'image': 'assets/pudding.png',
      'description':
          'Pudding segar dengan rasa vanilla dan topping buah. Tekstur yang lembut dan creamy.',
      'price': '15000',
      'rating': 4.5,
      'category': 'Dessert'
    }
  ];

  List<Map<String, dynamic>> cartItems = [];
  String selectedCategory = 'Semua';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF5F7),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 150,
              floating: false,
              pinned: true,
              elevation: 0,
              backgroundColor: Color(0xFFFFF5F7),
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Sweet Delights',
                  style: TextStyle(
                    color: Color(0xFF4A4A4A),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                centerTitle: true,
              ),
              actions: [
                Stack(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: Color(0xFF4A4A4A),
                        size: 28,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                KeranjangScreen(cartItems: cartItems),
                          ),
                        );
                      },
                    ),
                    if (cartItems.isNotEmpty)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.pink[300],
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${cartItems.length}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCategoryChip('Semua'),
                      _buildCategoryChip('Cake'),
                      _buildCategoryChip('Kue Kering'),
                      _buildCategoryChip('Dessert'),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = cakeMenu[index];
                    if (selectedCategory == 'Semua' ||
                        product['category'] == selectedCategory) {
                      return _buildProductCard(context, product);
                    }
                    return SizedBox.shrink();
                  },
                  childCount: cakeMenu.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(
          category,
          style: TextStyle(
            color:
                selectedCategory == category ? Colors.white : Colors.pink[300],
          ),
        ),
        selected: selectedCategory == category,
        onSelected: (selected) {
          setState(() {
            selectedCategory = category;
          });
        },
        backgroundColor: Colors.white,
        selectedColor: Colors.pink[300],
        shape: StadiumBorder(
          side: BorderSide(
            color: Colors.pink[100]!,
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () => _showProductDetails(context, product),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  image: DecorationImage(
                    image: AssetImage(product['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text(
                          product['rating'].toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Text(
                      NumberFormat.currency(
                        locale: 'id_ID',
                        symbol: 'Rp ',
                        decimalDigits: 0,
                      ).format(int.parse(product['price'])),
                      style: TextStyle(
                        color: Colors.pink[300],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProductDetails(BuildContext context, Map<String, dynamic> product) {
    int quantity = 1;
    int price = int.parse(product['price']);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          // Calculate subtotal and PPN
          double subtotal = price * quantity.toDouble();
          double ppn = subtotal * 0.05;
          double totalWithPpn = subtotal + ppn;

          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(product['image']),
                      fit: BoxFit.cover,
                    ),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                product['name'],
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    product['rating'].toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          product['description'],
                          style: TextStyle(
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 24),
                        Text(
                          'Jumlah',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  if (quantity > 1) setState(() => quantity--);
                                },
                                color: Colors.pink[300],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  '$quantity',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () => setState(() => quantity++),
                                color: Colors.pink[300],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),
                        // Price details section
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.grey[200]!,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Subtotal',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    NumberFormat.currency(
                                      locale: 'id_ID',
                                      symbol: 'Rp ',
                                      decimalDigits: 0,
                                    ).format(subtotal),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'PPN (5%)',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    NumberFormat.currency(
                                      locale: 'id_ID',
                                      symbol: 'Rp ',
                                      decimalDigits: 0,
                                    ).format(ppn),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    NumberFormat.currency(
                                      locale: 'id_ID',
                                      symbol: 'Rp ',
                                      decimalDigits: 0,
                                    ).format(totalWithPpn),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pink[300],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),
                        // Add to cart button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              final cartItem = {
                                'name': product['name'],
                                'image': product['image'],
                                'price': price,
                                'quantity': quantity,
                                'ppn': ppn,
                                'total': totalWithPpn,
                              };
                              setState(() {
                                cartItems.add(cartItem);
                              });
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Berhasil ditambahkan ke keranjang'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink[300],
                              padding: EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              'Tambah ke Keranjang',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
