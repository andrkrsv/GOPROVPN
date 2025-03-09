import 'package:flutter/material.dart';

class ServerTile extends StatelessWidget {
  final String city;
  final String country;
  final int ping;
  final VoidCallback onConnect;

  const ServerTile({
    super.key,
    required this.city,
    required this.country,
    required this.ping,
    required this.onConnect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black26, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Локация сервера
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                city,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                country,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ],
          ),

          // Ping и кнопка "Соединить"
          Row(
            children: [
              Text(
                "$ping ms",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ping < 50
                      ? const Color.fromARGB(255, 172, 231, 174)
                      : (ping < 100
                          ? const Color.fromARGB(255, 225, 201, 165)
                          : const Color.fromARGB(255, 235, 134, 126)),
                ),
              ),
              SizedBox(width: 12),
              ElevatedButton(
                onPressed: onConnect,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Соединить"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
