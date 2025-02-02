import 'package:flutter/material.dart';

void main() {
  runApp(AdminPanelApp());
}

class AdminPanelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.pink, // Pink primary color
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.orange), // Orange accent color
      ),
      home: AdminLoginPage(),
    );
  }
}

class AdminLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Login')),
      body: Center(
        child: ElevatedButton(
          child: Text('Login as Admin'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminDashboard()),
            );
          },
        ),
      ),
    );
  }
}

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard')),
      drawer: AdminSidebar(),
      body: Column(
        children: [
          Center(child: Text('Welcome to Admin Panel', style: TextStyle(fontSize: 18))),
          SizedBox(height: 20), // Gap between welcome text and buttons
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink, // Pink button color
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProductPage()),
              );
            },
            child: Text(
              'Add Items',
              style: TextStyle(color: Colors.white), // White text color inside the button
            ),
          ),
          SizedBox(height: 20), // Added gap between buttons
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange, // Orange button color
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductListPage()),
              );
            },
            child: Text(
              'View Items',
              style: TextStyle(color: Colors.white), // White text color inside the button
            ),
          ),
        ],
      ),
    );
  }
}

class AdminSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.pink),
            child: Text('Admin Menu', style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AdminDashboard())),
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Orders'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OrdersPage())),
          ),
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text('Add Items'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductPage())),
          ),
        ],
      ),
    );
  }
}

class OrdersPage extends StatelessWidget {
  final List<String> orders = ['Order #1001', 'Order #1002', 'Order #1003'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Orders')),
      drawer: AdminSidebar(),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text(orders[index]),
            subtitle: Text('Status: Pending'),
          );
        },
      ),
    );
  }
}

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _controller = TextEditingController();

  void _submit() {
    if (_controller.text.isNotEmpty) {
      // Logic for adding product
      print('Added product: ${_controller.text}');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _controller, decoration: InputDecoration(labelText: 'Product Name')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Add Product'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink), // Pink button color
            ),
          ],
        ),
      ),
    );
  }
}

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<String> products = ['Product 1', 'Product 2', 'Product 3']; // Sample products

  void _updateProduct(int index) {
    // Logic for updating product
    print('Updating product: ${products[index]}');
  }

  void _deleteProduct(int index) {
    setState(() {
      products.removeAt(index); // Remove product from list
    });
    print('Deleted product: ${products[index]}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product List')),
      drawer: AdminSidebar(),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text(products[index]),
            subtitle: Text('Product details here'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _updateProduct(index), // Call update logic
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteProduct(index), // Call delete logic
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

