import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: LoginPage()));  // Starting point of the app, initially showing the login page
}

// Login Page
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers for username and password input fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Function to handle login
  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Debugging: Print entered username and password
    print('Entered Username: $username');
    print('Entered Password: $password');

    // Example validation (you can change the conditions)
    if (username == 'admin' && password == '1234') {
      // If login is successful, navigate to the Notes App page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NotesApp()),
      );
    } else {
      // Show error message if login fails
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid Username or Password'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Username input field
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // Password input field
            TextField(
              controller: _passwordController,
              obscureText: true, // Hides the text for password
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // Login button
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

// Notes App Page (After Successful Login)
class NotesApp extends StatefulWidget {
  @override
  _NotesAppState createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {
  // List to store notes
  List<String> notes = [];

  // Text controller to handle input for new notes
  final TextEditingController _noteController = TextEditingController();

  // Function to add a new note
  void _addNote() {
    if (_noteController.text.isNotEmpty) {
      setState(() {
        notes.add(_noteController.text);
      });
      _noteController.clear();
    }
  }

  // Function to delete a note
  void _deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  // Function to edit a note
  void _editNote(int index) {
    _noteController.text = notes[index];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Note"),
          content: TextField(
            controller: _noteController,
            decoration: InputDecoration(hintText: "Enter your note"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  notes[index] = _noteController.text;
                  _noteController.clear();
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Text field to input new notes
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                hintText: "Enter a new note",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addNote,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Display list of notes
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(notes[index]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _editNote(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteNote(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
