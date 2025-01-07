import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextNote extends StatefulWidget {
  final String _content;
  bool _expanded = false;
  final DateTime _time;
  final String _user;
  final bool _isOwn;
  final void Function() _delete;
  final void Function() _showModal;
  final String _email;

  TextNote({
    required String content,
    required DateTime time,
    required String user,
    required bool isOwn,
    void Function()? delete,
    void Function()? showModal,
    required String email,
  })  : _content = content,
        _time = time,
        _user = user,
        _isOwn = isOwn,
        _delete = delete ?? (() {}),
        _showModal = showModal?? ((){}),
        _email = email;

  @override
  State<StatefulWidget> createState() => TextNoteState();
}

class TextNoteState extends State<TextNote> {
  @override
  Widget build(BuildContext context) {
    // Format the date to a more readable format
    String formattedTime = DateFormat('hh:mm a').format(widget._time);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget._isOwn) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: widget._showModal,
                    icon: Icon(CupertinoIcons.pen),
                  ),
                  IconButton(onPressed: widget._delete, icon: Icon(CupertinoIcons.clear))
                ],
              )
            ],
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formattedTime,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  widget._email,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                )
              ],
            ),
            SizedBox(height: 8),
            Text(
              widget._content,
              style: TextStyle(fontSize: 16),
              maxLines: widget._expanded ? null : 3,
              overflow: widget._expanded
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 8,
              width: double.infinity,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  widget._expanded = !widget._expanded;
                });
              },
              child: Text(
                widget._expanded ? 'Show Less' : 'Show More',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
