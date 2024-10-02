import 'package:flutter/material.dart';
import 'package:kpie_practical/screens/add_vehicle_screen.dart';
import 'package:kpie_practical/screens/vehicle_details_screen.dart';
import 'package:kpie_practical/utils/screen_size.dart';
import 'package:kpie_practical/widgets/app_bar.dart';

class VehicleListScreen extends StatelessWidget {
  const VehicleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2, // Two tabs: Vehicles and Passengers
      child: Scaffold(
        appBar: CustomAppBar(imagePath: "assets/images/guliva_header.png"),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                "Vehicle/Passenger",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8), // Add spacing before TabBar
              TabBar(
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.black,
                indicatorColor: Colors.blue,
                tabs: [
                  Tab(text: 'Vehicles'),
                  Tab(text: 'Passengers'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // First tab: Vehicles list
                    VehicleTab(),
                    // Second tab: Passengers (You can add content later)
                    Center(child: Text('Passengers Section')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VehicleTab extends StatelessWidget {
  const VehicleTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        SizedBox(
          height: ScreenHeight(context) * 0.02,
        ),
        const VehicleCard(
          imageUrl: 'assets/images/vehicle.png',
          vehicleName: 'Toyota',
          vehicleNumber: '4yuuij8',
        ),
        SizedBox(
          height: ScreenHeight(context) * 0.02,
        ),
        const VehicleCard(
          imageUrl: 'assets/images/vehicle.png',
          vehicleName: 'Honda',
          vehicleNumber: 'FIJSIFI',
        ),
        SizedBox(
          height: ScreenHeight(context) * 0.02,
        ),
        const VehicleCard(
          imageUrl: 'assets/images/vehicle.png',
          vehicleName: 'Benz',
          vehicleNumber: 'SDGR77',
        ),
        SizedBox(
          height: ScreenHeight(context) * 0.03,
        ),
        MaterialButton(
          height: 50,
          minWidth: ScreenWidth(context),
          color: const Color.fromARGB(255, 3, 33, 131),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (__) {
              return const AddVehicleScreen();
            }));
          },
          child: const Text(
            "Add Vehicle",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}

class VehicleCard extends StatelessWidget {
  final String imageUrl;
  final String vehicleName;
  final String vehicleNumber;

  const VehicleCard({
    super.key,
    required this.imageUrl,
    required this.vehicleName,
    required this.vehicleNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imageUrl), // Display vehicle image
          radius: 30,
        ),
        title: Text(
          vehicleName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(vehicleNumber),
        trailing: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (__) {
                return VehicleDetailsScreen();
              }));
            },
            child: const Icon(Icons.chevron_right)),
        onTap: () {
          // Add navigation or action when the card is tapped
        },
      ),
    );
  }
}
