// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import "package:swolematesflutterapp/models/user.dart";
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class MockFirebaseAuth extends Mock implements FirebaseAuth {}
// class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
//
// void main() {
//   group('UserModel', () {
//     late UserModel userModel;
//     late MockFirebaseAuth mockFirebaseAuth;
//     late MockFirebaseFirestore mockFirebaseFirestore;
//
//     setUp(() {
//       mockFirebaseAuth = MockFirebaseAuth();
//       mockFirebaseFirestore = MockFirebaseFirestore();
//       userModel = UserModel();
//     });
//
//     test('getFirstName returns the user\'s first name', () async {
//       final testEmail = 'test@test.com';
//       final testFirstName = 'John';
//
//       // Set up mock Firebase Auth user
//       when(mockFirebaseAuth.currentUser)
//           .thenReturn(User(email: testEmail));
//
//       // Set up mock Firestore document
//       final mockDocumentSnapshot = MockDocumentSnapshot();
//       when(mockDocumentSnapshot.data())
//           .thenReturn({'first': testFirstName});
//       final mockDocumentReference = MockDocumentReference();
//       when(mockDocumentReference.get())
//           .thenAnswer((_) async => mockDocumentSnapshot);
//       when(mockFirebaseFirestore.collection('users').doc(testEmail))
//           .thenReturn(mockDocumentReference);
//
//       // Set up the user model
//       userModel.auth = mockFirebaseAuth;
//       userModel.firestore = mockFirebaseFirestore;
//
//       // Call the getFirstName method and check the result
//       expect(await userModel.getFirstName(), equals(testFirstName));
//     });
//   });
// }
