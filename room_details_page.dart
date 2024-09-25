import 'dart:convert';
import 'dart:typed_data';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:excel/excel.dart';
import 'package:path/path.dart' as p;
import 'package:intl/intl.dart';

class RoomDetailsPage extends StatefulWidget {
  final String roomName;

  RoomDetailsPage({required this.roomName});

  @override
  _RoomDetailsPageState createState() => _RoomDetailsPageState();
}

class _RoomDetailsPageState extends State<RoomDetailsPage> {
  late Future<List<Map<String, dynamic>>> _studentsFuture;
  Map<int, String> attendanceStatus = {};
  Map<int, String> attendanceReasons = {};
  final TextEditingController _reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _studentsFuture = _getStudentsForRoom(widget.roomName);
  }

  Future<List<Map<String, dynamic>>> _getStudentsForRoom(
      String roomName) async {
    try {
      List<Map<String, dynamic>> allStudents = [
        {
          'id': 1,
          'name': 'John Doe',
          'roll_no': '101',
          'department': 'Computer Science',
          'batch': '2022-2025',
          'father_name': 'David Doe',
          'mother_name': 'Emma Doe',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/101_john_doe.jpeg',
          'room': 'F1',
        },
        {
          'id': 2,
          'name': 'Jane Smith',
          'roll_no': '102',
          'department': 'Mathematics',
          'batch': '2022-2025',
          'father_name': 'Michael Smith',
          'mother_name': 'Sarah Smith',
          'parents_phone': '2345678901',
          'student_phone': '1098765432',
          'photo_path': 'assets/students/102_jane_smith.jpeg',
          'room': 'F1',
        },

        {
          'id': 3,
          'name': 'Alex Williams',
          'roll_no': '103',
          'department': 'Electrical Engineering',
          'batch': '2022-2025',
          'father_name': 'Michael Williams',
          'mother_name': 'Sarah Williams',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/103_alex_williams.jpg',
          'room': 'F1'
        },

        // Room F2
        {
          'id': 4,
          'name': 'Chris Brown',
          'roll_no': '104',
          'department': 'Mechanical Engineering',
          'batch': '2022-2025',
          'father_name': 'James Brown',
          'mother_name': 'Sophia Brown',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/104_chris_brown.jpeg',
          'room': 'F2'
        },
        {
          'id': 5,
          'name': 'Emily Davis',
          'roll_no': '105',
          'department': 'Civil Engineering',
          'batch': '2022-2025',
          'father_name': 'Robert Davis',
          'mother_name': 'Olivia Davis',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/105_emily_davis.png',
          'room': 'F2'
        },
        {
          'id': 6,
          'name': 'Michael Brown',
          'roll_no': '106',
          'department': 'Architecture',
          'batch': '2022-2025',
          'father_name': 'Daniel Brown',
          'mother_name': 'Laura Brown',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/101_john_doe.jpeg',
          'room': 'F2'
        },

        // Room F3
        {
          'id': 7,
          'name': 'Sophia Johnson',
          'roll_no': '107',
          'department': 'Biotechnology',
          'batch': '2022-2025',
          'father_name': 'George Johnson',
          'mother_name': 'Linda Johnson',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/102_jane_smith.jpeg',
          'room': 'F3'
        },
        {
          'id': 8,
          'name': 'William Lee',
          'roll_no': '108',
          'department': 'Environmental Science',
          'batch': '2022-2025',
          'father_name': 'Henry Lee',
          'mother_name': 'Catherine Lee',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/103_alex_williams.jpg',
          'room': 'F3'
        },
        {
          'id': 9,
          'name': 'Olivia Wilson',
          'roll_no': '109',
          'department': 'Physics',
          'batch': '2022-2025',
          'father_name': 'Arthur Wilson',
          'mother_name': 'Patricia Wilson',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/104_chris_brown.jpeg',
          'room': 'F3'
        },

        // Room F4
        {
          'id': 10,
          'name': 'James Taylor',
          'roll_no': '110',
          'department': 'Chemistry',
          'batch': '2022-2025',
          'father_name': 'Steven Taylor',
          'mother_name': 'Barbara Taylor',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/105_emily_davis.png',
          'room': 'F4'
        },
        {
          'id': 11,
          'name': 'Isabella Martinez',
          'roll_no': '111',
          'department': 'Mathematics',
          'batch': '2022-2025',
          'father_name': 'Luis Martinez',
          'mother_name': 'Maria Martinez',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/101_john_doe.jpeg',
          'room': 'F4'
        },
        {
          'id': 12,
          'name': 'Ethan Brown',
          'roll_no': '112',
          'department': 'Statistics',
          'batch': '2022-2025',
          'father_name': 'Jack Brown',
          'mother_name': 'Emily Brown',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/102_jane_smith.jpeg',
          'room': 'F4'
        },

        // Room F5
        {
          'id': 13,
          'name': 'Ava Anderson',
          'roll_no': '113',
          'department': 'Psychology',
          'batch': '2022-2025',
          'father_name': 'John Anderson',
          'mother_name': 'Jessica Anderson',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/103_alex_williams.jpg',
          'room': 'F5'
        },
        {
          'id': 14,
          'name': 'Mason Thomas',
          'roll_no': '114',
          'department': 'Sociology',
          'batch': '2022-2025',
          'father_name': 'Mark Thomas',
          'mother_name': 'Laura Thomas',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/104_chris_brown.jpeg',
          'room': 'F5'
        },
        {
          'id': 15,
          'name': 'Charlotte Harris',
          'roll_no': '115',
          'department': 'Philosophy',
          'batch': '2022-2025',
          'father_name': 'David Harris',
          'mother_name': 'Anna Harris',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/105_emily_davis.png',
          'room': 'F5'
        },

        // Room F6
        {
          'id': 16,
          'name': 'Liam Robinson',
          'roll_no': '116',
          'department': 'Economics',
          'batch': '2022-2025',
          'father_name': 'Richard Robinson',
          'mother_name': 'Nancy Robinson',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/101_john_doe.jpeg',
          'room': 'F6'
        },
        {
          'id': 17,
          'name': 'Mia Walker',
          'roll_no': '117',
          'department': 'Business Administration',
          'batch': '2022-2025',
          'father_name': 'Thomas Walker',
          'mother_name': 'Jennifer Walker',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/102_jane_smith.jpeg',
          'room': 'F6'
        },
        {
          'id': 18,
          'name': 'Benjamin Clark',
          'roll_no': '118',
          'department': 'International Relations',
          'batch': '2022-2025',
          'father_name': 'Charles Clark',
          'mother_name': 'Sarah Clark',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/103_alex_williams.jpg',
          'room': 'F6'
        },

        // Room F7
        {
          'id': 19,
          'name': 'Amelia Lewis',
          'roll_no': '119',
          'department': 'History',
          'batch': '2022-2025',
          'father_name': 'Robert Lewis',
          'mother_name': 'Lisa Lewis',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/104_chris_brown.jpeg',
          'room': 'F7'
        },
        {
          'id': 20,
          'name': 'Jacob Scott',
          'roll_no': '120',
          'department': 'Geography',
          'batch': '2022-2025',
          'father_name': 'Daniel Scott',
          'mother_name': 'Emily Scott',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/105_emily_davis.png',
          'room': 'F7'
        },
        {
          'id': 21,
          'name': 'Harper Hall',
          'roll_no': '121',
          'department': 'Linguistics',
          'batch': '2022-2025',
          'father_name': 'Steven Hall',
          'mother_name': 'Megan Hall',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/101_john_doe.jpeg',
          'room': 'F7'
        },

        // Room F8
        {
          'id': 22,
          'name': 'Ella Allen',
          'roll_no': '122',
          'department': 'Theatre',
          'batch': '2022-2025',
          'father_name': 'Paul Allen',
          'mother_name': 'Nancy Allen',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/102_jane_smith.jpeg',
          'room': 'F8'
        },
        {
          'id': 23,
          'name': 'Lucas King',
          'roll_no': '123',
          'department': 'Fine Arts',
          'batch': '2022-2025',
          'father_name': 'Andrew King',
          'mother_name': 'Olivia King',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/103_alex_williams.jpg',
          'room': 'F8'
        },
        {
          'id': 24,
          'name': 'Grace Wright',
          'roll_no': '124',
          'department': 'Music',
          'batch': '2022-2025',
          'father_name': 'Mark Wright',
          'mother_name': 'Susan Wright',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/104_chris_brown.jpeg',
          'room': 'F8'
        },

        // Room F9
        {
          'id': 25,
          'name': 'Noah Young',
          'roll_no': '125',
          'department': 'Engineering Physics',
          'batch': '2022-2025',
          'father_name': 'James Young',
          'mother_name': 'Linda Young',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/105_emily_davis.png',
          'room': 'F9'
        },
        {
          'id': 26,
          'name': 'Zoe Harris',
          'roll_no': '126',
          'department': 'Mathematical Engineering',
          'batch': '2022-2025',
          'father_name': 'Robert Harris',
          'mother_name': 'Jessica Harris',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/101_john_doe.jpeg',
          'room': 'F9'
        },
        {
          'id': 27,
          'name': 'Aiden Nelson',
          'roll_no': '127',
          'department': 'Biomedical Engineering',
          'batch': '2022-2025',
          'father_name': 'John Nelson',
          'mother_name': 'Sarah Nelson',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/102_jane_smith.jpeg',
          'room': 'F9'
        },

        // Room F10
        {
          'id': 28,
          'name': 'Lily Adams',
          'roll_no': '128',
          'department': 'Genetics',
          'batch': '2022-2025',
          'father_name': 'Matthew Adams',
          'mother_name': 'Emma Adams',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/103_alex_williams.jpg',
          'room': 'F10'
        },
        {
          'id': 29,
          'name': 'Elijah Carter',
          'roll_no': '129',
          'department': 'Bioinformatics',
          'batch': '2022-2025',
          'father_name': 'David Carter',
          'mother_name': 'Anna Carter',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/104_chris_brown.jpeg',
          'room': 'F10'
        },
        {
          'id': 30,
          'name': 'Mila Roberts',
          'roll_no': '130',
          'department': 'Agricultural Science',
          'batch': '2022-2025',
          'father_name': 'Thomas Roberts',
          'mother_name': 'Laura Roberts',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/105_emily_davis.png',
          'room': 'F10'
        },

        // Room F11
        {
          'id': 31,
          'name': 'James Turner',
          'roll_no': '131',
          'department': 'Astrophysics',
          'batch': '2022-2025',
          'father_name': 'Jack Turner',
          'mother_name': 'Linda Turner',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/101_john_doe.jpeg',
          'room': 'F11'
        },
        {
          'id': 32,
          'name': 'Aria Collins',
          'roll_no': '132',
          'department': 'Meteorology',
          'batch': '2022-2025',
          'father_name': 'Brian Collins',
          'mother_name': 'Amanda Collins',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/102_jane_smith.jpeg',
          'room': 'F11'
        },
        {
          'id': 33,
          'name': 'Daniel Murphy',
          'roll_no': '133',
          'department': 'Oceanography',
          'batch': '2022-2025',
          'father_name': 'Kevin Murphy',
          'mother_name': 'Helen Murphy',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/103_alex_williams.jpg',
          'room': 'F11'
        },

        // Room F12
        {
          'id': 34,
          'name': 'Mason Wright',
          'roll_no': '134',
          'department': 'Geology',
          'batch': '2022-2025',
          'father_name': 'Charles Wright',
          'mother_name': 'Patricia Wright',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/104_chris_brown.jpeg',
          'room': 'F12'
        },
        {
          'id': 35,
          'name': 'Ella Clark',
          'roll_no': '135',
          'department': 'Environmental Engineering',
          'batch': '2022-2025',
          'father_name': 'Daniel Clark',
          'mother_name': 'Anna Clark',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/105_emily_davis.png',
          'room': 'F12'
        },
        {
          'id': 36,
          'name': 'Alexander Walker',
          'roll_no': '136',
          'department': 'Hydrology',
          'batch': '2022-2025',
          'father_name': 'Christopher Walker',
          'mother_name': 'Emily Walker',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/101_john_doe.jpeg',
          'room': 'F12'
        },

        // Room F13
        {
          'id': 37,
          'name': 'Sophie Robinson',
          'roll_no': '137',
          'department': 'Pharmacy',
          'batch': '2022-2025',
          'father_name': 'Jacob Robinson',
          'mother_name': 'Laura Robinson',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/102_jane_smith.jpeg',
          'room': 'F13'
        },
        {
          'id': 38,
          'name': 'Henry Davis',
          'roll_no': '138',
          'department': 'Public Health',
          'batch': '2022-2025',
          'father_name': 'William Davis',
          'mother_name': 'Michelle Davis',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/103_alex_williams.jpg',
          'room': 'F13'
        },
        {
          'id': 39,
          'name': 'Natalie Wilson',
          'roll_no': '139',
          'department': 'Biomedical Science',
          'batch': '2022-2025',
          'father_name': 'David Wilson',
          'mother_name': 'Sara Wilson',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/104_chris_brown.jpeg',
          'room': 'F13'
        },

        // Room F14
        {
          'id': 40,
          'name': 'Jack Martinez',
          'roll_no': '140',
          'department': 'Veterinary Science',
          'batch': '2022-2025',
          'father_name': 'Daniel Martinez',
          'mother_name': 'Jennifer Martinez',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/105_emily_davis.png',
          'room': 'F14'
        },
        {
          'id': 41,
          'name': 'Megan Lewis',
          'roll_no': '141',
          'department': 'Animal Science',
          'batch': '2022-2025',
          'father_name': 'Matthew Lewis',
          'mother_name': 'Amanda Lewis',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/101_john_doe.jpeg',
          'room': 'F14'
        },
        {
          'id': 42,
          'name': 'Eli Carter',
          'roll_no': '142',
          'department': 'Agronomy',
          'batch': '2022-2025',
          'father_name': 'James Carter',
          'mother_name': 'Sarah Carter',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/102_jane_smith.jpeg',
          'room': 'F14'
        },

        // Room F15
        {
          'id': 43,
          'name': 'Charlotte Hall',
          'roll_no': '143',
          'department': 'Marine Biology',
          'batch': '2022-2025',
          'father_name': 'Robert Hall',
          'mother_name': 'Nancy Hall',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/103_alex_williams.jpg',
          'room': 'F15'
        },
        {
          'id': 44,
          'name': 'Oliver Scott',
          'roll_no': '144',
          'department': 'Biotechnology',
          'batch': '2022-2025',
          'father_name': 'Michael Scott',
          'mother_name': 'Sophia Scott',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/104_chris_brown.jpeg',
          'room': 'F15'
        },
        {
          'id': 45,
          'name': 'Emily Adams',
          'roll_no': '145',
          'department': 'Genomics',
          'batch': '2022-2025',
          'father_name': 'William Adams',
          'mother_name': 'Emma Adams',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/105_emily_davis.png',
          'room': 'F15'
        },

        // Room F16
        {
          'id': 46,
          'name': 'Avery Carter',
          'roll_no': '146',
          'department': 'Bioengineering',
          'batch': '2022-2025',
          'father_name': 'Henry Carter',
          'mother_name': 'Olivia Carter',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/101_john_doe.jpeg',
          'room': 'F16'
        },
        {
          'id': 47,
          'name': 'Hannah Lewis',
          'roll_no': '147',
          'department': 'Medical Engineering',
          'batch': '2022-2025',
          'father_name': 'Christopher Lewis',
          'mother_name': 'Emma Lewis',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/102_jane_smith.jpeg',
          'room': 'F16'
        },
        {
          'id': 48,
          'name': 'Benjamin Mitchell',
          'roll_no': '148',
          'department': 'Genetics Engineering',
          'batch': '2022-2025',
          'father_name': 'David Mitchell',
          'mother_name': 'Laura Mitchell',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/103_alex_williams.jpg',
          'room': 'F16'
        },

        // Room F17
        {
          'id': 49,
          'name': 'Oliver Thompson',
          'roll_no': '149',
          'department': 'Marine Science',
          'batch': '2022-2025',
          'father_name': 'Daniel Thompson',
          'mother_name': 'Karen Thompson',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/104_chris_brown.jpeg',
          'room': 'F17'
        },
        {
          'id': 50,
          'name': 'Isabella Martinez',
          'roll_no': '150',
          'department': 'Environmental Science',
          'batch': '2022-2025',
          'father_name': 'Robert Martinez',
          'mother_name': 'Sophia Martinez',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/105_emily_davis.png',
          'room': 'F17'
        },
        {
          'id': 51,
          'name': 'Ethan White',
          'roll_no': '151',
          'department': 'Wildlife Biology',
          'batch': '2022-2025',
          'father_name': 'Michael White',
          'mother_name': 'Jessica White',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/101_john_doe.jpeg',
          'room': 'F17'
        },

        // Room F18
        {
          'id': 52,
          'name': 'Chloe Martin',
          'roll_no': '152',
          'department': 'Veterinary Medicine',
          'batch': '2022-2025',
          'father_name': 'Steven Martin',
          'mother_name': 'Angela Martin',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/102_jane_smith.jpeg',
          'room': 'F18'
        },
        {
          'id': 53,
          'name': 'Liam Rodriguez',
          'roll_no': '153',
          'department': 'Animal Husbandry',
          'batch': '2022-2025',
          'father_name': 'Carlos Rodriguez',
          'mother_name': 'Maria Rodriguez',
          'parents_phone': '1234567890',
          'student_phone': '0987654321',
          'photo_path': 'assets/students/103_alex_williams.jpg',
          'room': 'F18'
        },
        {
          'id': 54,
          'name': 'Sophia Davis',
          'roll_no': '154',
          'department': 'Agricultural Studies',
          'batch': '2022-2025',
          'father_name': 'Samuel Davis',
          'mother_name': 'Emily Davis',
          'parents_phone': '4567890123',
          'student_phone': '3210987654',
          'photo_path': 'assets/students/154_sophia_davis.jpeg',
          'room': 'F18',
        },
        // Room A1
        {
          'id': 55,
          'name': 'Emily Johnson',
          'roll_no': '301',
          'department': 'Computer Science',
          'batch': '2022-2025',
          'father_name': 'Robert Johnson',
          'mother_name': 'Linda Johnson',
          'parents_phone': '1234567891',
          'student_phone': '0987654322',
          'photo_path': 'assets/students/201_emily_johnson.jpg',
          'room': 'A1'
        },
        {
          'id': 56,
          'name': 'Olivia Williams',
          'roll_no': '302',
          'department': 'Information Technology',
          'batch': '2022-2025',
          'father_name': 'David Williams',
          'mother_name': 'Emma Williams',
          'parents_phone': '1234567892',
          'student_phone': '0987654323',
          'photo_path': 'assets/students/202_olivia_williams.jpg',
          'room': 'A1'
        },
        {
          'id': 57,
          'name': 'Sophia Brown',
          'roll_no': '303',
          'department': 'Mechanical Engineering',
          'batch': '2022-2025',
          'father_name': 'James Brown',
          'mother_name': 'Sophia Brown',
          'parents_phone': '1234567893',
          'student_phone': '0987654324',
          'photo_path': 'assets/students/203_sophia_brown.jpeg',
          'room': 'A1'
        },

        // Room A2
        {
          'id': 58,
          'name': 'Emily Johnson',
          'roll_no': '304',
          'department': 'Civil Engineering',
          'batch': '2022-2025',
          'father_name': 'Michael Johnson',
          'mother_name': 'Jessica Johnson',
          'parents_phone': '1234567894',
          'student_phone': '0987654325',
          'photo_path': 'assets/students/201_emily_johnson.jpg',
          'room': 'A2'
        },
        {
          'id': 59,
          'name': 'Olivia Williams',
          'roll_no': '305',
          'department': 'Electrical Engineering',
          'batch': '2022-2025',
          'father_name': 'John Williams',
          'mother_name': 'Sarah Williams',
          'parents_phone': '1234567895',
          'student_phone': '0987654326',
          'photo_path': 'assets/students/202_olivia_williams.jpg',
          'room': 'A2'
        },
        {
          'id': 60,
          'name': 'Sophia Brown',
          'roll_no': '306',
          'department': 'Chemical Engineering',
          'batch': '2022-2025',
          'father_name': 'William Brown',
          'mother_name': 'Emma Brown',
          'parents_phone': '1234567896',
          'student_phone': '0987654327',
          'photo_path': 'assets/students/203_sophia_brown.jpeg',
          'room': 'A2'
        },

        // Room A3
        {
          'id': 61,
          'name': 'Emily Johnson',
          'roll_no': '307',
          'department': 'Computer Science',
          'batch': '2022-2025',
          'father_name': 'Robert Johnson',
          'mother_name': 'Linda Johnson',
          'parents_phone': '1234567897',
          'student_phone': '0987654328',
          'photo_path': 'assets/students/201_emily_johnson.jpg',
          'room': 'A3'
        },
        {
          'id': 62,
          'name': 'Olivia Williams',
          'roll_no': '308',
          'department': 'Information Technology',
          'batch': '2022-2025',
          'father_name': 'David Williams',
          'mother_name': 'Emma Williams',
          'parents_phone': '1234567898',
          'student_phone': '0987654329',
          'photo_path': 'assets/students/202_olivia_williams.jpg',
          'room': 'A3'
        },
        {
          'id': 63,
          'name': 'Sophia Brown',
          'roll_no': '309',
          'department': 'Mechanical Engineering',
          'batch': '2022-2025',
          'father_name': 'James Brown',
          'mother_name': 'Sophia Brown',
          'parents_phone': '1234567899',
          'student_phone': '0987654330',
          'photo_path': 'assets/students/203_sophia_brown.jpeg',
          'room': 'A3'
        },

        // Room A4
        {
          'id': 64,
          'name': 'Emily Johnson',
          'roll_no': '310',
          'department': 'Civil Engineering',
          'batch': '2022-2025',
          'father_name': 'Michael Johnson',
          'mother_name': 'Jessica Johnson',
          'parents_phone': '1234567801',
          'student_phone': '0987654331',
          'photo_path': 'assets/students/201_emily_johnson.jpg',
          'room': 'A4'
        },
        {
          'id': 65,
          'name': 'Olivia Williams',
          'roll_no': '311',
          'department': 'Electrical Engineering',
          'batch': '2022-2025',
          'father_name': 'John Williams',
          'mother_name': 'Sarah Williams',
          'parents_phone': '1234567802',
          'student_phone': '0987654332',
          'photo_path': 'assets/students/202_olivia_williams.jpg',
          'room': 'A4'
        },
        {
          'id': 66,
          'name': 'Sophia Brown',
          'roll_no': '312',
          'department': 'Chemical Engineering',
          'batch': '2022-2025',
          'father_name': 'William Brown',
          'mother_name': 'Emma Brown',
          'parents_phone': '1234567803',
          'student_phone': '0987654333',
          'photo_path': 'assets/students/203_sophia_brown.jpeg',
          'room': 'A4'
        },

        // Room A5
        {
          'id': 67,
          'name': 'Emily Johnson',
          'roll_no': '313',
          'department': 'Computer Science',
          'batch': '2022-2025',
          'father_name': 'Robert Johnson',
          'mother_name': 'Linda Johnson',
          'parents_phone': '1234567804',
          'student_phone': '0987654334',
          'photo_path': 'assets/students/201_emily_johnson.jpg',
          'room': 'A5'
        },
        {
          'id': 68,
          'name': 'Olivia Williams',
          'roll_no': '314',
          'department': 'Information Technology',
          'batch': '2022-2025',
          'father_name': 'David Williams',
          'mother_name': 'Emma Williams',
          'parents_phone': '1234567805',
          'student_phone': '0987654335',
          'photo_path': 'assets/students/202_olivia_williams.jpg',
          'room': 'A5'
        },
        {
          'id': 69,
          'name': 'Sophia Brown',
          'roll_no': '315',
          'department': 'Mechanical Engineering',
          'batch': '2022-2025',
          'father_name': 'James Brown',
          'mother_name': 'Sophia Brown',
          'parents_phone': '1234567806',
          'student_phone': '0987654336',
          'photo_path': 'assets/students/203_sophia_brown.jpeg',
          'room': 'A5'
        },

        // Room A6
        {
          'id': 70,
          'name': 'Emily Johnson',
          'roll_no': '316',
          'department': 'Civil Engineering',
          'batch': '2022-2025',
          'father_name': 'Michael Johnson',
          'mother_name': 'Jessica Johnson',
          'parents_phone': '1234567807',
          'student_phone': '0987654337',
          'photo_path': 'assets/students/201_emily_johnson.jpg',
          'room': 'A6'
        },
        {
          'id': 71,
          'name': 'Olivia Williams',
          'roll_no': '317',
          'department': 'Electrical Engineering',
          'batch': '2022-2025',
          'father_name': 'John Williams',
          'mother_name': 'Sarah Williams',
          'parents_phone': '1234567808',
          'student_phone': '0987654338',
          'photo_path': 'assets/students/202_olivia_williams.jpg',
          'room': 'A6'
        },
        {
          'id': 72,
          'name': 'Sophia Brown',
          'roll_no': '318',
          'department': 'Chemical Engineering',
          'batch': '2022-2025',
          'father_name': 'William Brown',
          'mother_name': 'Emma Brown',
          'parents_phone': '1234567809',
          'student_phone': '0987654339',
          'photo_path': 'assets/students/203_sophia_brown.jpeg',
          'room': 'A6'
        },

        // Room A7
        {
          'id': 73,
          'name': 'Emily Johnson',
          'roll_no': '319',
          'department': 'Computer Science',
          'batch': '2022-2025',
          'father_name': 'Robert Johnson',
          'mother_name': 'Linda Johnson',
          'parents_phone': '1234567810',
          'student_phone': '0987654340',
          'photo_path': 'assets/students/201_emily_johnson.jpg',
          'room': 'A7'
        },
        {
          'id': 74,
          'name': 'Olivia Williams',
          'roll_no': '320',
          'department': 'Information Technology',
          'batch': '2022-2025',
          'father_name': 'David Williams',
          'mother_name': 'Emma Williams',
          'parents_phone': '1234567811',
          'student_phone': '0987654341',
          'photo_path': 'assets/students/202_olivia_williams.jpg',
          'room': 'A7'
        },
        {
          'id': 75,
          'name': 'Sophia Brown',
          'roll_no': '321',
          'department': 'Mechanical Engineering',
          'batch': '2022-2025',
          'father_name': 'James Brown',
          'mother_name': 'Sophia Brown',
          'parents_phone': '1234567812',
          'student_phone': '0987654342',
          'photo_path': 'assets/students/203_sophia_brown.jpeg',
          'room': 'A7'
        },

        // Room A8
        {
          'id': 76,
          'name': 'Emily Johnson',
          'roll_no': '322',
          'department': 'Civil Engineering',
          'batch': '2022-2025',
          'father_name': 'Michael Johnson',
          'mother_name': 'Jessica Johnson',
          'parents_phone': '1234567813',
          'student_phone': '0987654343',
          'photo_path': 'assets/students/201_emily_johnson.jpg',
          'room': 'A8'
        },
        {
          'id': 77,
          'name': 'Olivia Williams',
          'roll_no': '323',
          'department': 'Electrical Engineering',
          'batch': '2022-2025',
          'father_name': 'John Williams',
          'mother_name': 'Sarah Williams',
          'parents_phone': '1234567814',
          'student_phone': '0987654344',
          'photo_path': 'assets/students/202_olivia_williams.jpg',
          'room': 'A8'
        },
        {
          'id': 78,
          'name': 'Sophia Brown',
          'roll_no': '324',
          'department': 'Chemical Engineering',
          'batch': '2022-2025',
          'father_name': 'William Brown',
          'mother_name': 'Emma Brown',
          'parents_phone': '1234567815',
          'student_phone': '0987654345',
          'photo_path': 'assets/students/203_sophia_brown.jpeg',
          'room': 'A8'
        },

        // Room A9
        {
          'id': 79,
          'name': 'Emily Johnson',
          'roll_no': '325',
          'department': 'Computer Science',
          'batch': '2022-2025',
          'father_name': 'Robert Johnson',
          'mother_name': 'Linda Johnson',
          'parents_phone': '1234567816',
          'student_phone': '0987654346',
          'photo_path': 'assets/students/201_emily_johnson.jpg',
          'room': 'A9'
        },
        {
          'id': 80,
          'name': 'Olivia Williams',
          'roll_no': '326',
          'department': 'Information Technology',
          'batch': '2022-2025',
          'father_name': 'David Williams',
          'mother_name': 'Emma Williams',
          'parents_phone': '1234567817',
          'student_phone': '0987654347',
          'photo_path': 'assets/students/202_olivia_williams.jpg',
          'room': 'A9'
        },
        {
          'id': 81,
          'name': 'Sophia Brown',
          'roll_no': '327',
          'department': 'Mechanical Engineering',
          'batch': '2022-2025',
          'father_name': 'James Brown',
          'mother_name': 'Sophia Brown',
          'parents_phone': '1234567818',
          'student_phone': '0987654348',
          'photo_path': 'assets/students/203_sophia_brown.jpeg',
          'room': 'A9'
        },

        // Room A10
        {
          'id': 82,
          'name': 'Emily Johnson',
          'roll_no': '328',
          'department': 'Civil Engineering',
          'batch': '2022-2025',
          'father_name': 'Michael Johnson',
          'mother_name': 'Jessica Johnson',
          'parents_phone': '1234567819',
          'student_phone': '0987654349',
          'photo_path': 'assets/students/201_emily_johnson.jpg',
          'room': 'A10'
        },
        {
          'id': 83,
          'name': 'Olivia Williams',
          'roll_no': '329',
          'department': 'Electrical Engineering',
          'batch': '2022-2025',
          'father_name': 'John Williams',
          'mother_name': 'Sarah Williams',
          'parents_phone': '1234567820',
          'student_phone': '0987654350',
          'photo_path': 'assets/students/202_olivia_williams.jpg',
          'room': 'A10'
        },
        {
          'id': 84,
          'name': 'Sophia Brown',
          'roll_no': '330',
          'department': 'Chemical Engineering',
          'batch': '2022-2025',
          'father_name': 'William Brown',
          'mother_name': 'Emma Brown',
          'parents_phone': '1234567821',
          'student_phone': '0987654351',
          'photo_path': 'assets/students/203_sophia_brown.jpeg',
          'room': 'A10',
        },
      ];

      return allStudents
          .where((student) => student['room'] == roomName)
          .toList();
    } catch (e) {
      throw Exception('Failed to load students: $e');
    }
  }

  Future<void> _requestPermissionsAndExport() async {
    if (io.Platform.isAndroid || io.Platform.isIOS) {
      final status = await Permission.storage.request();

      if (status.isGranted) {
        await _exportAttendance();
      } else if (status.isDenied) {
        _showPermissionDeniedDialog(context);
      } else if (status.isPermanentlyDenied) {
        _showPermissionPermanentlyDeniedDialog(context);
      }
    } else {
      await _exportAttendance();
    }
  }

  void _showPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Storage Permission Needed'),
          content: Text(
              'This app needs storage permission to save files. Please grant permission to continue.'),
          actions: <Widget>[
            TextButton(
              child: Text('Grant Permission'),
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showPermissionPermanentlyDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permission Denied'),
          content: Text(
              'You have permanently denied storage permission. Please enable it in the app settings to save files.'),
          actions: <Widget>[
            TextButton(
              child: Text('Open Settings'),
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _exportAttendance() async {
    try {
      final previouslySavedData = await _retrievePreviouslySavedData();
      final roomName = widget.roomName;
      final students = await _getStudentsForRoom(roomName);
      final currentRoomData = {roomName: students};
      final allRoomsData = {...previouslySavedData, ...currentRoomData};

      await exportAllRoomsAttendanceToExcel(
        allRoomsData,
        attendanceStatus,
        attendanceReasons,
      );

      await _saveCurrentData(allRoomsData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Attendance exported successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to export attendance: $e')),
      );
    }
  }

  Future<Map<String, List<Map<String, dynamic>>>>
      _retrievePreviouslySavedData() async {
    try {
      if (io.Platform.isAndroid || io.Platform.isIOS) {
        final directory = await getApplicationDocumentsDirectory();
        final file = io.File('${directory.path}/saved_attendance.json');

        if (await file.exists()) {
          final jsonData = await file.readAsString();
          final Map<String, dynamic> decodedData = jsonDecode(jsonData);

          return decodedData.map((key, value) => MapEntry(
                key,
                List<Map<String, dynamic>>.from(
                    value.map((item) => Map<String, dynamic>.from(item))),
              ));
        } else {
          return {};
        }
      } else {
        return {};
      }
    } catch (e) {
      print('Error retrieving previously saved data: $e');
      return {};
    }
  }

  Future<void> _saveCurrentData(
      Map<String, List<Map<String, dynamic>>> allRoomsData) async {
    try {
      if (io.Platform.isAndroid || io.Platform.isIOS) {
        final directory = await getApplicationDocumentsDirectory();
        final file = io.File('${directory.path}/saved_attendance.json');

        final jsonData = jsonEncode(allRoomsData.map((key, value) => MapEntry(
              key,
              value.map((item) => item).toList(),
            )));

        await file.writeAsString(jsonData);
      }
    } catch (e) {
      print('Error saving current data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room ${widget.roomName}'),
        backgroundColor: Colors.teal.shade800,
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () => _requestPermissionsAndExport(),
            tooltip: 'Export Attendance',
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _studentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No students found'));
          } else {
            final students = snapshot.data!;
            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 5.0,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    title: Text(student['name']),
                    subtitle: Text('Roll No: ${student['roll_no']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(attendanceStatus[student['id']] ?? 'Present'),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showAttendanceDialog(
                                student['id'], student['name']);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      _showStudentDetails(
                          student); // Show student details and photo
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _showStudentDetails(Map<String, dynamic> student) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(student['name']),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Image.asset(
                  student['photo_path'],
                  height: 150,
                  width: 150,
                ),
                Text('Roll No: ${student['roll_no']}'),
                Text('Department: ${student['department']}'),
                Text('Batch: ${student['batch']}'),
                Text('Father: ${student['father_name']}'),
                Text('Mother: ${student['mother_name']}'),
                Text('Parents Phone: ${student['parents_phone']}'),
                Text('Student Phone: ${student['student_phone']}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAttendanceDialog(int studentId, String studentName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Attendance for $studentName'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: attendanceStatus[studentId] ?? 'Present',
                onChanged: (String? newValue) {
                  setState(() {
                    attendanceStatus[studentId] = newValue!;
                  });
                },
                items:
                    <String>['Present', 'Absent', 'Late'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              if (attendanceStatus[studentId] == 'Absent') ...[
                TextField(
                  controller: _reasonController,
                  decoration: InputDecoration(labelText: 'Reason'),
                ),
                ElevatedButton(
                  child: Text('Save Reason'),
                  onPressed: () {
                    setState(() {
                      attendanceReasons[studentId] = _reasonController.text;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

Future<void> exportAllRoomsAttendanceToExcel(
  Map<String, List<Map<String, dynamic>>> allRoomsData,
  Map<int, String> attendanceStatus,
  Map<int, String> attendanceReasons,
) async {
  try {
    // Create a new Excel workbook
    final excel = Excel.createExcel();
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    final timestamp = formatter.format(now);

    // Loop through each room's data
    for (var entry in allRoomsData.entries) {
      final room = entry.key;
      final students = entry.value;

      // Get or create a sheet with the room name
      final sheet = excel[room];

      // Add header row only if the sheet is empty
      if (sheet.rows.isEmpty) {
        sheet.appendRow(
            ['Name', 'Roll No', 'Department', 'Attendance Status', 'Reason']);
      }

      // Add student data rows
      for (var student in students) {
        final studentId = student['id'];
        final attendance = attendanceStatus[studentId] ?? 'Present';
        final reason = attendanceReasons[studentId] ?? '';

        sheet.appendRow([
          student['name'],
          student['roll_no'],
          student['department'],
          attendance,
          reason,
        ]);
      }
    }

    // Determine the directory to save the file
    String path;
    if (io.Platform.isAndroid) {
      final directory = await getExternalStorageDirectory();
      path = '${directory?.path}/Attendance_$timestamp.xlsx';
    } else if (io.Platform.isIOS ||
        io.Platform.isMacOS ||
        io.Platform.isLinux ||
        io.Platform.isWindows) {
      final directory = await getApplicationDocumentsDirectory();
      path = '${directory.path}/Attendance_$timestamp.xlsx';
    } else {
      throw UnsupportedError('Unsupported platform');
    }

    // Save the file
    final excelFile = io.File(path);
    final fileBytes = excel.encode();
    if (fileBytes != null) {
      await excelFile.writeAsBytes(fileBytes);
      print('Excel file saved at: $path');
    } else {
      print('Failed to encode Excel file.');
    }
  } catch (e) {
    print('Error exporting to Excel: $e');
  }
}
