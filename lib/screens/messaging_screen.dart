import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessagingScreen extends StatelessWidget {
  const MessagingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: Column(
        children: [
          Expanded(
            child: MessageList(),
          ),
          MessageInput(user: user),
        ],
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('messages').orderBy('timestamp', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        var messages = snapshot.data!.docs;
        List<MessageWidget> messageWidgets = messages.map((doc) {
          var data = doc.data() as Map<String, dynamic>;
          return MessageWidget(
            sender: data['sender'],
            text: data['text'],
            timestamp: data['timestamp'],
          );
        }).toList();

        return ListView(
          reverse: true,
          children: messageWidgets,
        );
      },
    );
  }
}

class MessageWidget extends StatelessWidget {
  final String sender;
  final String text;
  final Timestamp timestamp;

  const MessageWidget({required this.sender, required this.text, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(sender),
      subtitle: Text(text),
      trailing: Text(timestamp.toDate().toLocal().toString()),
    );
  }
}

class MessageInput extends StatefulWidget {
  final User? user;

  const MessageInput({Key? key, this.user}) : super(key: key);

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('messages').add({
        'sender': widget.user?.displayName ?? 'Anonymous',
        'text': _controller.text,
        'timestamp': Timestamp.now(),
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Enter a message...'),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
