import 'package:flutter/material.dart';
import '../components/serve_tiеtle.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _connectedServer;
  bool _isConnected = false;
  double _currentDownloadSpeed = 0;
  double _currentUploadSpeed = 0;
  double _totalDownloaded = 0;
  double _totalUploaded = 0;

  void _connectToServer(String server) {
    setState(() {
      _connectedServer = server;
      _isConnected = true;
      _currentDownloadSpeed = 12.5;
      _currentUploadSpeed = 5.3;
      _totalDownloaded += _currentDownloadSpeed * 10;
      _totalUploaded += _currentUploadSpeed * 10;
    });
  }

  void _disconnect() {
    setState(() {
      _connectedServer = null;
      _isConnected = false;
      _currentDownloadSpeed = 0;
      _currentUploadSpeed = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isWideScreen = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: isWideScreen ? null : AppBar(title: Text('VPN')),
      drawer: isWideScreen ? null : Drawer(child: _sideMenu(isWideScreen)),
      body: Row(
        children: [
          if (isWideScreen) _sideMenu(isWideScreen),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(16),
                    children: [
                      ServerTile(
                          city: 'Амстердам',
                          country: 'Нидерланды',
                          ping: 42,
                          onConnect: () => _connectToServer('Амстердам')),
                      ServerTile(
                          city: 'Франкфурт',
                          country: 'Германия',
                          ping: 85,
                          onConnect: () => _connectToServer('Франкфурт')),
                      ServerTile(
                          city: 'Нью-Йорк',
                          country: 'США',
                          ping: 120,
                          onConnect: () => _connectToServer('Нью-Йорк')),
                    ],
                  ),
                ),
                if (_isConnected && !isWideScreen) _connectionInfo(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sideMenu(bool isWideScreen) {
    return SizedBox(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Меню',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Профиль'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Настройки'),
            onTap: () {},
          ),
          Spacer(),
          if (_isConnected && isWideScreen) _connectionInfo(),
        ],
      ),
    );
  }

  Widget _connectionInfo() {
    return Container(
      width: MediaQuery.of(context).size.width > 800 ? 250 : null,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black26, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Подключено к $_connectedServer',
              style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Icon(Icons.arrow_downward, color: Colors.green),
                SizedBox(width: 5),
                Text('$_currentDownloadSpeed Mbps'),
              ]),
              Row(children: [
                Icon(Icons.arrow_upward, color: Colors.red),
                SizedBox(width: 5),
                Text('$_currentUploadSpeed Mbps'),
              ]),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Icon(Icons.arrow_downward, color: Colors.red),
                SizedBox(width: 5),
                Text('$_totalDownloaded MB'),
              ]),
              Row(children: [
                Icon(Icons.arrow_upward, color: Colors.green),
                SizedBox(width: 5),
                Text('$_totalUploaded MB'),
              ]),
            ],
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _disconnect,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: Text('Отключиться'),
          ),
        ],
      ),
    );
  }
}
