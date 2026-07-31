import 'package:flutter/material.dart';

void main() {
  runApp(const FrozellCafeApp());
}

class FrozellCafeApp extends StatelessWidget {
  const FrozellCafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frozell Cafe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFE63946),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

// ---------------- LOGIN SCREEN ----------------
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFFFFE5EC),
                  child: Icon(Icons.icecream_outlined, size: 50, color: Color(0xFFE63946)),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'FROZELL CAFE',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 1.5),
              ),
              const Text(
                'Chill • Sip • Bite',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Color(0xFFE63946), fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  prefixText: '+91 ',
                  prefixIcon: const Icon(Icons.phone_android, color: Colors.black),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  if (_phoneController.text.length == 10) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const SweetMenuScreen()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Continue with OTP', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- SWEET MENU SCREEN ----------------
class SweetMenuScreen extends StatelessWidget {
  const SweetMenuScreen({super.key});

  final List<Map<String, dynamic>> menuItems = const [
    {"name": "Vanilla Pastry", "category": "Pastries", "price": 59},
    {"name": "Chocolate Pastry", "category": "Pastries", "price": 69},
    {"name": "Red Velvet Pastry", "category": "Pastries", "price": 109},
    {"name": "Chocolate Cupcake", "category": "Cupcakes", "price": 69},
    {"name": "Oreo Cupcake", "category": "Cupcakes", "price": 89},
    {"name": "Red Velvet Cupcake", "category": "Cupcakes", "price": 99},
    {"name": "Choco Chip Cookies", "category": "Cookies", "price": 35},
    {"name": "KitKat Cup", "category": "Dessert Cups", "price": 119},
    {"name": "Frozen Banana", "category": "Frozen Special", "price": 99},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Frozell Sweet Menu', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminScreen()));
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(color: const Color(0xFFFFE5EC), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.cake, color: Color(0xFFE63946)),
              ),
              title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              subtitle: Text(item['category'], style: TextStyle(color: Colors.grey[600])),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('₹${item['price']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE63946),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('ADD', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---------------- CART & CHECKOUT SCREEN ----------------
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int subtotal = 198;
    int deliveryFee = 30;
    int grandTotal = subtotal + deliveryFee;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: const Text('Your Cart & Checkout', style: TextStyle(color: Colors.white))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Delivery Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter complete home address for delivery...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixIcon: const Icon(Icons.my_location, color: Color(0xFFE63946)),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Item Total'), Text('₹$subtotal')]),
                  const SizedBox(height: 8),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Delivery Charge'), Text('₹$deliveryFee')]),
                  const Divider(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    const Text('Grand Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('₹$grandTotal', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFE63946))),
                  ]),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('🎉 Order Placed!'),
                      content: Text('Your order worth ₹$grandTotal is being prepared at Frozell Cafe.'),
                      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE63946),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Place Order Now', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ---------------- ADMIN PANEL SCREEN ----------------
class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: const Text('Admin Panel', style: TextStyle(color: Colors.white))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add New Item', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFE63946))),
            const SizedBox(height: 15),
            TextField(decoration: InputDecoration(labelText: 'Item Name', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
            const SizedBox(height: 15),
            TextField(decoration: InputDecoration(labelText: 'Price (₹)', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE63946), padding: const EdgeInsets.symmetric(vertical: 14)),
              child: const Center(child: Text('Add Item To Live Menu', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
            )
          ],
        ),
      ),
    );
  }
}
