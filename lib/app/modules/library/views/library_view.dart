import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/library_controller.dart';
// Import for image picking

class LibraryView extends StatelessWidget {
  final LibraryController controller = Get.put(LibraryController());

  LibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Chat',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        //
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // logic
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildProfileSection(),
            const SizedBox(height: 20),
            Expanded(child: _buildChatList()),
          ],
        ),
      ),
    );
  }

  //container box user status
  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&q=70&fm=webp',
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
              Text(
                'Status: Online',
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ],
          ), //column
        ],
      ),
    );
  }

//placeholder
  Widget _buildChatList() {
    final chats = [
      {'name': 'User1', 'lastMessage': 'Halo!', 'time': '10:30 AM'},
      {'name': 'User2', 'lastMessage': 'Hai! Apa kabar?', 'time': '10:32 AM'},
      {'name': 'User3', 'lastMessage': 'Sama-sama baik!', 'time': '10:35 AM'},
      {'name': 'User3', 'lastMessage': 'Sama-sama baik!', 'time': '10:35 AM'},
    ];

    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(chats[index]['name']!),
          background: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete,
                color: Color.fromARGB(255, 255, 255, 255)),
          ),
          confirmDismiss: (direction) async {
            return await _showConfirmationDialog(context, chats[index]['name']);
          },
          onDismissed: (direction) {
            // Logic to delete the chat can be added here
            Get.snackbar('Chat Deleted',
                '${chats[index]['name']} chat has been deleted.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.blue,
                colorText: Colors.white);
          },
          child: _buildChatItem(
            chats[index]['name']!,
            chats[index]['lastMessage']!,
            chats[index]['time']!,
          ),
        );
      },
    );
  }

  Future<bool?> _showConfirmationDialog(
      BuildContext context, String? chatName) {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Konfirmasi Hapus'),
            content: Text(
                'Apakah Anda yakin ingin menghapus chat dengan $chatName?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false), // No
                child: const Text('Tidak'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true), // Yes
                child: const Text('Ya'),
              ),
            ],
          );
        });
  }

  Widget _buildChatItem(String name, String lastMessage, String time) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        leading: const CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
            'https://www.example.com/chat_profile_image.jpg',
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(lastMessage),
        trailing: Text(time),
        onTap: () {
          Get.to(ChatDetailView(name: name)); // Navigate to chat detail
        },
      ),
    );
  }
}

// Chat detail page
class ChatDetailView extends StatelessWidget {
  final String name;

  const ChatDetailView({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with $name'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(child: _buildMessageList()),
            _buildMessageInput(messageController),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    final messages = [
      {'sender': 'User1', 'text': 'Halo!'},
      {'sender': 'User2', 'text': 'Hai! Apa kabar?'},
      {'sender': 'User1', 'text': 'Baik, kamu?'},
      {'sender': 'User2', 'text': 'Sama-sama baik!'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return _buildMessageBubble(
          messages[index]['sender']!,
          messages[index]['text']!,
        );
      },
    );
  }

  Widget _buildMessageBubble(String sender, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Align(
        alignment:
            sender == 'User1' ? Alignment.centerRight : Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (sender != 'User1')
              const CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                  'https://www.example.com/chat_profile_image.jpg',
                ),
              ),
            const SizedBox(width: 5),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: sender == 'User1' ? Colors.blue : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 255, 0, 0),
                    blurRadius: 4.0,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: sender == 'User1'
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    sender,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(text),
                ],
              ),
            ),
            const SizedBox(width: 5),
            if (sender == 'User1')
              const CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                  'https://www.example.com/chat_profile_image.jpg',
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput(TextEditingController messageController) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: 'Ketik pesan...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.red,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: () async {
              // Logic to handle the selected image
            },
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              // Logic to send message
              messageController.clear(); // Clear input after sending
            },
          ),
        ],
      ),
    );
  }
}
