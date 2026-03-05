//Group Members:
//220044173 Mohlomi_T
//221044640 Ledibane_O
//220025661 Lye_TJ
//222022131 Stemer_TE
//221032720  Zwane NF
//222033930 Mafunisa T
//221015339 Malau TP

import 'dart:async';
import 'dart:typed_data';
import'package:flutter/material.dart';
import'package:file_selector/file_selector.dart';

List<Vehicle> vehicles = [];

class Vehicle
{
  String regNumber = "";
  String make = "";
  String model = "";
  int vehicleYear = 0;
  double price = 0.0;
  String status = "";
 final Uint8List? imageBytes;

  Vehicle({
    required this.regNumber,
    required this.make,
    required this.model,
    required this.vehicleYear,
    required this.price,
    required this.status,
    required this.imageBytes
  });
}



void main()
{
  runApp(const App());
}
class App extends StatelessWidget
{
  const App({super.key});

  @override
  Widget build(BuildContext context)
   {
    return MaterialApp(debugShowCheckedModeBanner: false,
    theme: ThemeData(scaffoldBackgroundColor: Colors.white,
    primarySwatch: Colors.blue,
    bottomNavigationBarTheme: 
    BottomNavigationBarThemeData(backgroundColor: Colors.pink,)
      ),
      home: HomePage(),
     );
    }
}
class HomePage extends StatefulWidget
{
  const HomePage({super.key});

  @override
  HomePageState createState()=> HomePageState();
}
class HomePageState extends State<HomePage>
{
      List<Vehicle> vehicles = [];

      TextEditingController regNumberController = TextEditingController();
      TextEditingController makeController = TextEditingController();
      TextEditingController modelController = TextEditingController();
      TextEditingController vehicleYearController = TextEditingController();
      TextEditingController priceController = TextEditingController();
      TextEditingController statusController = TextEditingController();

       Uint8List? selectedImageBytes;
       
         Vehicle? get newVehicle => null;
         
           Vehicle? get updatedVehicle => null;
       
       Future<void> pickImage() async {
      const XTypeGroup typeGroup = XTypeGroup(
      label: 'images',
      extensions: ['jpg', 'jpeg', 'png'],
          );

            final XFile? file = await openFile(acceptedTypeGroups: [typeGroup]);
            if (file != null) {
           final Uint8List bytes = await file.readAsBytes();
            setState(() {
            selectedImageBytes = bytes;
           });
        
            }
          }
     
         void addVehicle()
         {

          showDialog(
          context: context,
          builder: (context)
          {
            return AlertDialog(
              backgroundColor: Colors.blue,
              title: Text('Add Vehicle Information',
              style: TextStyle(color: Colors.black,
              fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    
                     GestureDetector(
                    onTap: () async {
                      const XTypeGroup typeGroup = XTypeGroup(
                        label: 'images',
                        extensions: ['jpg', 'jpeg', 'png'],
                      );
                      final XFile? file =
                          await openFile(acceptedTypeGroups: [typeGroup]);
                      if (file != null) {
                        final Uint8List bytes = await file.readAsBytes();
                        setState(() {
                          selectedImageBytes = bytes;
                        });
                      }
                    },
                          child: CircleAvatar(
                           radius: 50,
                           backgroundImage: selectedImageBytes != null
                          ? MemoryImage(selectedImageBytes!)
                          : null,
                          child: selectedImageBytes == null
                          ? Icon(Icons.add_a_photo, color: Colors.black)
                          : null,
                         ),
                        ),
                         const SizedBox(height: 10),

                      TextFormField(
                      controller: regNumberController,
                      decoration: InputDecoration(labelText: 'Registration Number',
                      hintStyle: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.bold)
                      ),
                    ),
                    TextFormField(
                      controller: makeController,
                      decoration: InputDecoration(labelText: 'Vehicle Make',
                      hintStyle: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.bold)
                      ),
                    ),
                    TextFormField(
                      controller: modelController,
                      decoration: InputDecoration(labelText: 'Vehicle Model',
                      hintStyle: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.bold)
                      ),
                    ),
                    TextFormField(
                      maxLength: 4,
                      obscureText: false,
                      controller: vehicleYearController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Vehicle Year',
                      hintStyle: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.bold)
                      ),
                    ),
                    TextFormField(
                      maxLength: 12,
                      controller: priceController,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Price',
                      hintStyle: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.bold)
                      ),
                    ),
                    TextFormField(
                      controller: statusController,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: 'Status',
                      hintStyle: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.bold)
                      ),
                    ),

                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: ()
                  {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel', style: TextStyle(color: Colors.amber,
                  fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: ()
                  {
                    selectedImageBytes = null;
                     if(regNumberController.text.isNotEmpty && makeController.text.isNotEmpty
                     &&  modelController.text.isNotEmpty &&
                     vehicleYearController.text.isNotEmpty && priceController.text.isNotEmpty
                     && statusController.text.isNotEmpty)
                     {
                      setState(() async {
                        vehicles.add(Vehicle(regNumber: regNumberController.text,
                        make: makeController.text, model: modelController.text,
                        vehicleYear: int.parse(vehicleYearController.text),
                        price: double.parse(priceController.text),
                        status: statusController.text,
                        imageBytes: selectedImageBytes, 
                        ));
                      });
                      regNumberController.clear();
                      makeController.clear();
                      modelController.clear();
                      vehicleYearController.clear();
                      priceController.clear();
                      selectedImageBytes = null;
                     }
                  },
                  child: Text('Add Vehicle',
                  style: TextStyle(color: Colors.green,
                  fontWeight: FontWeight.bold),
                  ),
                )
              ],
            );
          }
        );
      }
      void updateVehicleInformation(int index)
      {
          Vehicle car = vehicles[index];
          String regNumber = car.regNumber;
          String make = car.make;
          String model = car.model;
          int vehicleYear = car.vehicleYear.toInt();
          double price = car.price.toDouble();
          String status = car.status;

          Uint8List? updatedImage = car.imageBytes;

          showDialog(
            context: context,
            builder: (context)
            {
              return AlertDialog(
                backgroundColor: Colors.deepOrangeAccent,
                title: const Text('Update Vehicle Information',
                style: TextStyle(color: Colors.black,
                fontWeight: FontWeight.bold),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    children: [

                      GestureDetector(
                    onTap: () async {
                      const XTypeGroup typeGroup = XTypeGroup(
                        label: 'images',
                        extensions: ['jpg', 'jpeg', 'png'],
                      );
                      final XFile? file =
                          await openFile(acceptedTypeGroups: [typeGroup]);
                      if (file != null) {
                        final Uint8List bytes = await file.readAsBytes();
                        setState(() {
                          selectedImageBytes = bytes;
                        });
                       }
                      },
                          child: CircleAvatar(
                           radius: 40,
                           backgroundImage: selectedImageBytes != null
                          ? MemoryImage(selectedImageBytes!)
                          : null,
                          child: selectedImageBytes == null
                          ? Icon(Icons.add_a_photo, color: Colors.black)
                          : null,
                         ),
                        ),
                         const SizedBox(height: 10),
                         Center(
                          child: Text('Change Picture', 
                          style: TextStyle(color: Colors.black),),
                         ),
                         TextFormField(
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        controller: TextEditingController(text: regNumber),
                        onChanged: (value)=> regNumber = value,
                        decoration: InputDecoration(labelText: 'Registration Number',
                        hintStyle: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold)
                        ),
                      ),
                        TextFormField(
                          obscureText: false,
                          keyboardType: TextInputType.text,
                        controller: TextEditingController(text: make),
                        onChanged: (value)=> make = value,
                        decoration: InputDecoration(labelText: 'Vehicle Make',
                        hintStyle: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold)
                        ),
                      ),
                       TextFormField(
                        controller: TextEditingController(text: model),
                        onChanged: (value)=> model = value,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: InputDecoration(labelText: 'Vehicle Model',
                        hintStyle: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold)
                        ),
                      ),
                        TextFormField(
                          maxLength: 4,
                         controller: TextEditingController(text: vehicleYear.toString(),
                        ),
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'Vehicle Year',
                        hintStyle: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold)
                        ),
                        onChanged: (value)=> vehicleYear,
                      ),
                      TextFormField(
                        controller: TextEditingController(text: price.toString()),
                        obscureText: false,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(labelText: 'Price',
                        hintStyle: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold)
                        ),
                      ),
                      TextFormField(
                        controller: TextEditingController(text: status),
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        onChanged: (value)=> status = value,
                        decoration: InputDecoration(labelText: 'Status',
                        hintStyle: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold)
                        ),
                      )
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: ()
                    {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel', style: 
                    TextStyle(color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: ()
                    {
                      setState(() async {
                        vehicles[index] = Vehicle(regNumber: regNumber,
                        make: make, model: model, vehicleYear: vehicleYear,
                        price: price, status: status, imageBytes: updatedImage);
                      });
                    },
                    child: Text('Save', style: TextStyle(color: Colors.indigo,
                    fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              );
            }
          );
       }
       Color generateStatusColor(String status) {
           String value = status.toLowerCase().trim();

           if (value == 'active' || value == 'available' || value == 'fixed') {
           return Colors.green.shade200;
            } 
            else if (value == 'inactive' || value == 'under maintenance' || value == 'damaged')
            {
                return Colors.red.shade200;
            } 
            else if (value == 'serviced' || value == 'in progress') 
            {
                 return Colors.blue.shade200;
            } 
            else if (value == 'rented') 
            {
              return Colors.orange.shade200;
            }
            else if (value == 'sold')
           {
               return Colors.purple.shade200;
            } 
           else
            {
             return Colors.black; // default color
            }
        }
       void deleteVehicle(int index)
       {
          Vehicle motor = vehicles[index];
          String regNumber = motor.regNumber;
          String make = motor.make;
          String model = motor.model;
          int vehicleYear = motor.vehicleYear;
          double price = motor.price;
          String status = motor.status;
          Uint8List? imageBytes = motor.imageBytes;

          showDialog(
            context: context,
            builder: (context)
            {
              return AlertDialog(
                backgroundColor: Colors.amber,
                title: Text('Delete Vehicle Information',
                style: TextStyle(color: Colors.black,
                fontWeight: FontWeight.bold),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                       CircleAvatar(
                radius: 45,
                backgroundImage:
                    motor.imageBytes != null ? MemoryImage(motor.imageBytes!) : null,
                child: motor.imageBytes == null
                    ? Icon(Icons.directions_car, size: 40, color: Colors.redAccent)
                    : null,
              ),
              const SizedBox(height: 12),

                      TextFormField(
                        controller: TextEditingController(text: regNumber),
                        onChanged: (value)=> regNumber = value,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: 'Registration Number',
                        hintStyle: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold)
                        ),
                      ),
                      TextFormField(
                        controller: TextEditingController(text: make),
                        onChanged: (value)=> make = value,
                        decoration: InputDecoration(labelText: 'Make',
                        hintStyle: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold)
                        ),
                        obscureText: false,
                        keyboardType: TextInputType.text,
                      ),
                      TextFormField(
                        controller: TextEditingController(text: model),
                        onChanged: (value)=> model = value,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: 'Model',
                        hintStyle: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold)
                        ),
                      ),
                      TextFormField(
                        maxLength: 4,
                        controller: TextEditingController(text: vehicleYear.toString()
                        ),
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        onChanged: (value)=> vehicleYear,
                        decoration: InputDecoration(labelText: 'Vehicle Year',
                        hintStyle: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold)
                        ),
                      ),
                      TextFormField(
                        controller: TextEditingController(text: price.toString()
                        ),
                        obscureText: false,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        onChanged: (value)=> price,
                        decoration: InputDecoration(labelText: 'Price',
                        hintStyle: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold)
                        ),
                      ),
                      TextFormField(
                        controller: TextEditingController(text: status),
                        onChanged: (value)=> status = value,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: 'Status',
                        hintStyle: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold)
                        ),
                      )
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: ()
                    {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel', style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: ()
                    {
                      setState(() async {
                        vehicles.removeAt(index);
                        vehicles[index] = Vehicle(regNumber: regNumber,
                        make: make, model: model, vehicleYear: vehicleYear,
                        price: price, status: status, imageBytes: imageBytes);
                      });
                    },
                    child: Text('Delete',
                    style: TextStyle(color: Colors.red,
                    fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              );
            }
          );
       }
       @override
       Widget build(BuildContext context)
       {
        return Scaffold(appBar: AppBar(backgroundColor: Colors.white,
          title: Text('Vehicle Management App', style: TextStyle(
          color: Colors.black,
           ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: Colors.black,
               fontWeight: FontWeight.bold,),
               onPressed: ()
               {
                  
               },
            )
          ],
         ),
         body: vehicles.isEmpty ? Center(
          child: Text('No Vehicle Added Yet',
          style: TextStyle(color: Colors.black, 
          fontWeight: FontWeight.bold),
          ),
         ) : ListView.builder(
          itemCount: vehicles.length,
          itemBuilder: (context, index)
          {
            final car = vehicles[index];
            return Card(
              color: Colors.lightBlueAccent,
              elevation: 20,
              child: ListTile(
                leading: CircleAvatar(
                 radius: 30,
                 backgroundImage: selectedImageBytes != null
                ? MemoryImage(selectedImageBytes!)
                : null,
                child: selectedImageBytes == null
                ? Text(car.make.isNotEmpty ? car.make[0] : "?",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
                : null,

                ),
                title: Text('RegNumber: ${car.regNumber} ',
                style: TextStyle(color: Colors.black, 
                fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Make: ${car.make} ${car.model}\n Year: ${car.vehicleYear}\n Price: ${car.price}'
                    ),
                    Container(
                      width: 70,
                      height: 20,
                      decoration: BoxDecoration(color: generateStatusColor(car.status),
                      borderRadius: BorderRadius.circular(16), border: 
                      Border.all(color: generateStatusColor(car.status))
                      ),
                      child: Text(car.status, style: 
                      TextStyle(color: Colors.black
                      ),
                      ),
                    )
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(icon: Icon(Icons.edit, color: Colors.black,
                    fontWeight: FontWeight.bold,),
                    onPressed: ()
                    {
                      setState(() {
                        updateVehicleInformation(index);
                      });
                    },
                    ),
                    IconButton(icon: Icon(Icons.delete, color: Colors.black,
                    fontWeight: FontWeight.bold,),
                    onPressed: ()
                    {
                      setState(() {
                        deleteVehicle(index);
                      });
                    },
                    ),
                  ],
                ),
                onLongPress: ()
                {
                  deleteVehicle(index);
                  vehicles.removeAt(index);
                },
                onTap: ()
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>
                      VehicleDetailScreen(
                        vehicle: car,
                        onEdit: (onEdited)
                        {
                          updateVehicleInformation(index);
                        },
                        onDelete: ()
                        {
                          setState(() {
                           vehicles.removeAt(index);
                           deleteVehicle(index);
                          });
                        },
                      )
                    )
                  );
                }
            ),
            );
          },
         ),
         floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.limeAccent,
          onPressed: ()
          {
            setState(() {
              addVehicle();
            });
          },
          child: Icon(Icons.add, color: Colors.black),
         ),
         bottomNavigationBar: BottomNavigationBar(
         type: BottomNavigationBarType.fixed,
         backgroundColor: Colors.greenAccent,
          items: 
         [
          BottomNavigationBarItem(icon: Icon(Icons.home,),
          label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),
          label: 'Purchased Cars'),
          BottomNavigationBarItem(icon: Icon(Icons.car_rental),
          label: 'Rented Cars'),
          BottomNavigationBarItem(icon: Icon(Icons.car_repair),
          label: 'Repaired Cars')
         ]),
        );
       }
    }
  class VehicleDetailScreen extends StatelessWidget {
  final Vehicle vehicle;
  final Function(Vehicle) onEdit; // Callback when edited
  final Function() onDelete;       // Callback when deleted

  const VehicleDetailScreen({
    super.key,
    required this.vehicle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vehicle Details"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              onEdit(vehicle); // Trigger edit callback
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Confirm deletion
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Delete Vehicle"),
                  content: const Text("Are you sure you want to delete this vehicle?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        onDelete(); // Trigger delete callback
                        Navigator.pop(context); // Close dialog
                        Navigator.pop(context); // Go back after deletion
                      },
                      child: const Text("Delete"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Vehicle Image display
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[300],
              backgroundImage: vehicle.imageBytes != null
                  ? MemoryImage(vehicle.imageBytes!)
                  : null,
              child: vehicle.imageBytes == null
                  ? const Icon(Icons.directions_car, size: 60)
                  : null,
            ),
            const SizedBox(height: 20),

            // Vehicle Info
            detailRow("Registration Number:", vehicle.regNumber),
            const Divider(),
            detailRow("Make & Model:", "${vehicle.make} ${vehicle.model}"),
            const Divider(),
            detailRow("Year:", vehicle.vehicleYear.toString()),
            const Divider(),
            detailRow("Price:", "\$${vehicle.price.toStringAsFixed(2)}"),
            const Divider(),
            detailRow("Status:", vehicle.status),
          ],
        ),
      ),
    );
  }


  Widget detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}