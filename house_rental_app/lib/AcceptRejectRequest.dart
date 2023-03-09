import 'package:flutter/material.dart';


class AcceptRejectRequest extends StatefulWidget {
  final Map<String, dynamic> data;
  final int index;
  const AcceptRejectRequest({Key?key, required this.data, required this.index}) : super(key: key);

  @override
  State<AcceptRejectRequest> createState() => _AcceptRejectRequestState();
}

class _AcceptRejectRequestState extends State<AcceptRejectRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: 
    Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16.0),
          
          Container(
               child: 
               const Text(
                'Applicant Details',
                style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                fontFamily: "TiltNeon-Regular",
                height: 2)),   
            ),
            
          const SizedBox(height: 16.0),
          
          Text(
              'Property ID: ${widget.data['results'][widget.index]['propertyID']}',
              style: const TextStyle(
                fontSize: 18.0, 
                fontWeight: FontWeight.bold,
                fontFamily: "TiltNeon-Regular"),
            ),
            
            const SizedBox(height: 16.0),
            
            Text(
              'Application ID: ${widget.data['results'][widget.index]['applicationID']}',
              style: const TextStyle(
                fontSize: 18.0, 
                fontWeight: FontWeight.bold,
                fontFamily: "TiltNeon-Regular"),
            ),
            
            const SizedBox(height: 16.0),
            
            Text(
              'Tenant Username: ${widget.data['results'][widget.index]['tenantUsername']}',
              style: const TextStyle(
                fontSize: 18.0, 
                fontWeight: FontWeight.bold,
                fontFamily: "TiltNeon-Regular"),
            ),
            
            const SizedBox(height: 16.0),
          
              
              const CircleAvatar(
              backgroundImage: NetworkImage('images/ryuk.webp'),
              radius: 48.0,
            ),
      const SizedBox(height: 16.0),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.work),
          SizedBox(height: 8.0),
          Text("Employed"),
        ],
      ),

      const SizedBox(height: 16.0),

    SizedBox(
      height: 30,
            width: 400,
            child: ElevatedButton(
            onPressed: (){},
          
            style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),),
            ),
            ),
            child: const Text(
              'Accept',
              style: TextStyle(
                fontWeight: FontWeight.bold),
            ),
            ),
          ),
          
const SizedBox(height: 16.0),
          SizedBox(
      height: 30,
            width: 400,
            child: ElevatedButton(
            onPressed: (){},
          
            style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),),
            ),
            ),
            child: const Text(
              'Reject',
              style: TextStyle(
                fontWeight: FontWeight.bold),
            ),
            ),
          )

        ],
      ),
    ),
    );
  }
}