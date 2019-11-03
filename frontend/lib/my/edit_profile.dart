import 'package:flutter/material.dart';
import 'package:week_3/bloc/bloc.dart';
import 'package:week_3/utils/utils.dart';
import 'package:week_3/utils/dio.dart';
import 'package:week_3/bloc/user_bloc.dart';
import 'package:week_3/bloc/user_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();

  UserBloc _userBloc;
  int loggedUserId = 0;

  @override
  void initState() {
    super.initState();

    _userBloc = BlocProvider.of<UserBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800].withOpacity(0.5),
        appBar: _buildAppBar(context),
        body: Container(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenAwareSize(10.0, context),
                  vertical: screenAwareSize(5.0, context)),
              child: TextField(
                controller: nameController,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "새로운 닉네임",
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                    suffixIcon: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 16,
                    ),
                    enabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white, width: 1.0)),
                    border: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white, width: 1.0))
                    ),
              ),
            )));
  }

  Widget _buildAppBar(context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(
        "프로필 편집",
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
      actions: <Widget>[
        Material(
          color: Colors.transparent,
          child: InkResponse(
            onTap: () async => {
              // 완료.
              _userBloc
                  .add(UserChangeProfile(profilename: nameController.text)),
              Navigator.of(context).pop()
            },
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text("완료", style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}
