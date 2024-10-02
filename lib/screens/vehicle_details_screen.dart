import 'package:flutter/material.dart';

import 'package:kpie_practical/widgets/app_bar.dart';

class VehicleDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar:
            const CustomAppBar(imagePath: 'assets/images/guliva_header.png'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.blue,
              tabs: [
                Tab(text: 'Details'),
                Tab(text: 'Trips'),
                Tab(text: 'Insurance'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // First tab - Vehicle Details
                  VehicleDetailsTab(),
                  // Second tab - Trips (add your content here)
                  const Center(child: Text('Trips Section')),
                  // Third tab - Insurance (add your content here)
                  const Center(child: Text('Insurance Section')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VehicleDetailsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ListView(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Toyota',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(Icons.menu)
            ],
          ),
          const SizedBox(height: 10),
          buildDetailRow('Name of vehicle', 'Toyota'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildDetailRow('Model', 'Camry'),
              buildDetailRow('Color', 'Yellow'),
              buildDetailRow('Year', '2008'),
            ],
          ),
          buildDetailRow('Primary Driver', 'JamesIdowu'),
          const SizedBox(height: 10),

          // Photo Section
          const Text(
            'Photo attached',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildVehicleImage('assets/images/vehicle.png'),
              buildVehicleImage('assets/images/vehicle.png'),
              buildVehicleImage('assets/images/vehicle.png'),
              buildVehicleImage('assets/images/vehicle.png'),
            ],
          ),

          const SizedBox(height: 20),

          // Other Vehicle Details
          buildDetailRow('Total Distance Covered (km)', '0.01'),
          buildDetailRow('Amount Billed', '0.04'),
        ],
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildVehicleImage(String imageUrl) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Image.asset(imageUrl, fit: BoxFit.cover),
    );
  }
}
