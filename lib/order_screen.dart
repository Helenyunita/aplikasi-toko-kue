import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  OrderScreen({required this.cartItems});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  String paymentMethod = 'Cash';
  String deliveryMethod = 'Take Away';
  bool isAgreed = false;

  // Define theme colors
  final Color primaryColor = Color(0xFFFFB6C1); // Light pink
  final Color secondaryColor = Color(0xFFFFF0F5); // Lavender blush
  final Color textColor = Color(0xFF4A4A4A); // Dark grey for text

  @override
  Widget build(BuildContext context) {
    int totalPrice = 0;
    for (var item in widget.cartItems) {
      int price = int.parse(item['price'].toString());
      int quantity = item['quantity'];
      totalPrice += price * quantity;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Form Pemesanan',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [primaryColor.withOpacity(0.1), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informasi Pemesan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        SizedBox(height: 20),

                        // Delivery Method Dropdown
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: primaryColor),
                          ),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              border: InputBorder.none,
                            ),
                            value: deliveryMethod,
                            items: ['Take Away', 'Makan di Tempat', 'Kurir']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                deliveryMethod = newValue!;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 15),

                        // Input fields with modern styling
                        TextFormField(
                          controller: nameController,
                          decoration: _inputDecoration('Nama'),
                        ),
                        SizedBox(height: 15),

                        TextFormField(
                          controller: addressController,
                          decoration: _inputDecoration('Alamat'),
                          maxLines: 2,
                        ),
                        SizedBox(height: 15),

                        TextFormField(
                          controller: phoneController,
                          decoration: _inputDecoration('Nomor Telepon'),
                          keyboardType: TextInputType.phone,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Date and Time Card
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Waktu Pengambilan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, color: primaryColor),
                            SizedBox(width: 10),
                            TextButton(
                              onPressed: () => _selectDate(context),
                              child: Text(
                                DateFormat('dd/MM/yyyy').format(selectedDate),
                                style: TextStyle(color: textColor),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.access_time, color: primaryColor),
                            SizedBox(width: 10),
                            TextButton(
                              onPressed: () => _selectTime(context),
                              child: Text(
                                selectedTime.format(context),
                                style: TextStyle(color: textColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Payment Method Card
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Metode Pembayaran',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        SizedBox(height: 10),
                        _buildPaymentMethod('Cash'),
                        _buildPaymentMethod('Transfer'),
                        _buildPaymentMethod('OVO'),
                        _buildPaymentMethod('GOPAY'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Notes Card
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Catatan Tambahan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: notesController,
                          decoration: _inputDecoration('Catatan Pesanan'),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Agreement Checkbox
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CheckboxListTile(
                    title: Text(
                      'Saya setuju dengan syarat dan ketentuan pemesanan.',
                      style: TextStyle(fontSize: 14, color: textColor),
                    ),
                    value: isAgreed,
                    onChanged: (value) {
                      setState(() {
                        isAgreed = value!;
                      });
                    },
                    activeColor: primaryColor,
                  ),
                ),
                SizedBox(height: 20),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 5,
                    ),
                    onPressed: () {
                      if (isAgreed) {
                        final orderDetails = {
                          'name': nameController.text,
                          'address': addressController.text,
                          'phone': phoneController.text,
                          'date': selectedDate,
                          'time': selectedTime,
                          'deliveryMethod': deliveryMethod,
                          'paymentMethod': paymentMethod,
                          'notes': notesController.text,
                          'cartItems': widget.cartItems,
                          'subtotal': totalPrice,
                          'ppn': totalPrice * 0.05,
                          'totalPayment': totalPrice + (totalPrice * 0.05),
                        };

                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            title: Text('Pesanan Terkirim'),
                            content:
                                Text('Pesanan Anda telah berhasil dikirim!'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'OK',
                                  style: TextStyle(color: primaryColor),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Harap setujui syarat dan ketentuan.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Kirim Pesanan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(String method) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: paymentMethod == method ? primaryColor.withOpacity(0.1) : null,
      ),
      child: RadioListTile<String>(
        title: Text(method),
        value: method,
        groupValue: paymentMethod,
        onChanged: (value) {
          setState(() {
            paymentMethod = value!;
          });
        },
        activeColor: primaryColor,
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: textColor),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: primaryColor.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: primaryColor),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }
}
