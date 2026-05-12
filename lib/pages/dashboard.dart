import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black54),
          onPressed: () {},
        ),
        title: const Text(
          'WAREHAUS',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black54),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hello, Supervisor',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3436),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Scanner Status: Online',
                            style: TextStyle(color: Colors.black54, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'ZONE',
                        style: TextStyle(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'A-12',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // Stats Cards
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'PENDING TASKS',
                      value: '15',
                      subtitle: 'Tasks Waiting',
                      icon: Icons.assignment_outlined,
                      footer: '➔ 7  •  ➔ 8',
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildStatCard(
                      title: 'THROUGHPUT',
                      value: '1,240',
                      subtitle: 'Units Today',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Operations Grid
              const Text(
                'OPERATIONS',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 15),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.5,
                children: [
                  _buildOperationCard(
                    'Inbound Receipt',
                    Icons.south_west,
                    const Color(0xFF0F172A),
                    Colors.white,
                  ),
                  _buildOperationCard(
                    'Outbound Picking',
                    Icons.north_east,
                    Colors.white,
                    Colors.black87,
                  ),
                  _buildOperationCard(
                    'Stock Opname',
                    Icons.inventory_2_outlined,
                    Colors.white,
                    Colors.black87,
                  ),
                  _buildOperationCard(
                    'Create PO',
                    Icons.description_outlined,
                    const Color(0xFFFD9745),
                    Colors.black87,
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Recent Logs
              const Text(
                'RECENT LOGS',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              _buildLogItem(
                icon: Icons.login_rounded,
                title: 'Stock In - Zona A',
                subtitle: 'Pallet ID: PLT-8922',
                time: '10:42 AM',
              ),
              _buildLogItem(
                icon: Icons.logout_rounded,
                title: 'Picking - Rak B',
                subtitle: 'Order: ORD-4410',
                time: '09:15 AM',
              ),
              _buildLogItem(
                icon: Icons.swap_horiz_rounded,
                title: 'Bin Relocation',
                subtitle: 'Loc: C2 → D1',
                time: '08:30 AM',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black38,
        currentIndex: 0,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        unselectedLabelStyle: const TextStyle(fontSize: 11),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'DASHBOARD'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined), label: 'PRODUCT'),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping_outlined), label: 'FLOWS'),
          BottomNavigationBarItem(icon: Icon(Icons.layers_outlined), label: 'ZONES'),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    IconData? icon,
    String? footer,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black45),
              ),
              if (icon != null) Icon(icon, size: 16, color: Colors.black45),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orange),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Colors.black45),
          ),
          if (footer != null) ...[
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 5),
            Text(
              footer,
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildOperationCard(String title, IconData icon, Color bgColor, Color textColor) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: textColor, size: 30),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLogItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF2196F3), size: 22),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.black45, fontSize: 13),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(color: Colors.black45, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
