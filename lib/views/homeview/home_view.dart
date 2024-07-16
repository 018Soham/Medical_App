
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical/conts/consts.dart';
import 'package:medical/settingScreen/setting_screen.dart';
import 'package:medical/services/auth_service.dart';
import '../AppoinmentDetails/AppoinmentDetails.dart';
import '../DoctorsTab/doctor_signin_view.dart';
import '../Labtests/lab_test_item.dart';
import '../categoryview/categoryviews.dart';
import '../popularDoctorViews/doctor_details_screen.dart';
import 'doctor_search_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  late String _userName;

  final List<Widget> _pages = [
    HomeContent(),
    CategoriesScreen(),
    Center(child: Text('Doctors Screen')),
    Center(child: Text('Settings Screen')),
  ];

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  void _fetchUserName() async {
    String userId = AuthService().getCurrentUserId();
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    setState(() {
      _userName = userDoc['username'];
    });
  }

  void _onItemTapped(int index) {
    if (index == 4) {
      String userId = AuthService().getCurrentUserId();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SettingsScreen(uid: userId)),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DoctorSignInView()),
      );
    } else if (index == 3) {
      String userId = AuthService().getCurrentUserId();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AppointmentScreen(userId: userId)),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.purpleColor,
        title: Text(AppStrings.welcomeBack),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: AppColors.purpleColor,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.blue), // Change icon color
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category, color: Colors.green), // Change icon color
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_hospital, color: Colors.orange), // Change icon color
          label: 'Doctors',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book, color: Colors.red), // Change icon color
          label: 'Appointment',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings, color: Colors.purple), // Change icon color
          label: 'Settings',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        SizedBox(height: 10),
    const Text(
    'Doctor Category',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    textAlign: TextAlign.center,
    ),
    SizedBox(height: 10),
    Container(
    height: 150,
    child: ListView(
    scrollDirection: Axis.horizontal,
    children: [
    buildCategoryItem('Medicine', Icons.medical_services, Colors.blue),
    buildCategoryItem('Surgery', Icons.local_hospital, Colors.green),
    buildCategoryItem('Orthopedic', Icons.accessibility, Colors.orange),
    buildCategoryItem('Dental', Icons.book, Colors.red),
    buildCategoryItem('Dermatology', Icons.face, Colors.purple),
    buildCategoryItem('Mental Health', Icons.psychology, Colors.teal),
    ],
    ),
    ),
    SizedBox(height: 20),
    const Text(
    'Popular Doctors',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    textAlign: TextAlign.center,
    ),
    SizedBox(height: 10),
    StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('doctors').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(
    child: CircularProgressIndicator(),
    );
    } else if (snapshot.hasError) {
    return Center(
    child: Text('Error: ${snapshot.error}'),
    );
    } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
    return Center(
    child: Text('No data available'),
    );
    } else {
    return Container(
    height: 150,
    child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: snapshot.data!.docs.length,
    itemBuilder: (BuildContext context, int index) {
    var doctor = snapshot.data!.docs[index];
    return buildPopularDoctorItem(context, doctor);
    },
    ),
    );
    }
    },
    ),
          SizedBox(height: 20),
          const Text(
            'Lab Tests',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Container(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                LabTestItem(
                  testName: 'Blood Test',
                  icon: Icons.local_hospital,
                  purpose: 'To analyze blood components',
                  procedure: 'Collect blood sample and send it to the lab',
                  preparationInstructions: 'Fasting required for 8 hours prior to the test',
                  turnaroundTime: '1-2 days',
                  risksAndSideEffects: 'Minimal risks, slight discomfort during blood draw',
                  documentId: 'yourDocumentId1', // Add your documentId here
                ),
                LabTestItem(
                  testName: 'Urine Test',
                  icon: Icons.local_hospital,
                  purpose: 'To analyze urine composition and detect abnormalities',
                  procedure: 'Collect urine sample and send it to the lab',
                  preparationInstructions: 'Collect the first-morning urine sample',
                  turnaroundTime: '1-2 days',
                  risksAndSideEffects: 'Minimal risks, no discomfort during sample collection',
                  documentId: 'yourDocumentId2', // Add your documentId here
                ),
                LabTestItem(
                  testName: 'X-Ray',
                  icon: Icons.local_hospital,
                  purpose: 'To create images of internal body structures',
                  procedure: 'Expose the body part to X-rays and capture images',
                  preparationInstructions: 'No special preparation required',
                  turnaroundTime: 'Same day',
                  risksAndSideEffects: 'Minimal risks, exposure to radiation',
                  documentId: 'yourDocumentId3', // Add your documentId here
                ),
              ],
            ),
          ),
        ],
        ),
    );
  }

  Widget buildCategoryItem(String categoryName, IconData icon, Color color) {
    return Container(
      width: 120,
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50,
            color: Colors.white, // Change icon color
          ),
          SizedBox(height: 8),
          Text(
            categoryName,
            style: TextStyle(color: Colors.white), // Change text color
          ),
        ],
      ),
    );
  }

  Widget buildPopularDoctorItem(BuildContext context, QueryDocumentSnapshot doctor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorDetailsScreen(
              doctorName: doctor['docName'],
              category: doctor['docCategory'],
              description: doctor['docServices'],
              fees: doctor['docFees'],
              docId: doctor.id,

            ),
          ),
        );
      },
      child: Container(
        width: 120,
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blueGrey, // Change background color
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: 50,
              color: Colors.white, // Change icon color
            ),
            const SizedBox(height: 8),
            Text(
              doctor['docName'],
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // Change text color
            ),
            SizedBox(height: 4),
            Text(
              doctor['docCategory'],
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white), // Change text color
            ),
          ],
        ),
      ),
    );
  }
}

