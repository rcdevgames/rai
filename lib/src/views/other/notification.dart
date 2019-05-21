import 'package:RAI/src/blocs/notifications/notifications_bloc.dart';
import 'package:RAI/src/models/notification.dart';
import 'package:RAI/src/wigdet/appbar.dart';
import 'package:RAI/src/wigdet/error_page.dart';
import 'package:RAI/src/wigdet/loading.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final _key = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  NotificationsBloc notificationsBloc;

  @override
  void initState() {
    notificationsBloc = new NotificationsBloc();
    notificationsBloc.fetchNotifications(context);
    super.initState();
  }

  @override
  void dispose() {
    notificationsBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: OneupBar("Notification"),
      body: GestureDetector(
        onTap: () => notificationsBloc.copyToken(_key),
        child: StreamBuilder(
          stream: notificationsBloc.getListNotifications,
          builder: (BuildContext context, AsyncSnapshot<List<Notifications>> snapshot) {
            if(snapshot.hasData && snapshot.data.length > 0) {
              return LiquidPullToRefresh(
                color: Theme.of(context).primaryColor.withOpacity(0.7),
                key: _refreshIndicatorKey,
                onRefresh: () => notificationsBloc.fetchNotifications(context),
                child: ListView.separated(
                  itemCount: snapshot.data.length, 
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemBuilder: (BuildContext context, int i) {
                    return Container(
                      padding: const EdgeInsets.fromLTRB(25, 5, 25, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(formatDate(snapshot.data[i].dateTimestamp, [dd,' ',MM,' ',yyyy,', ',HH,':',nn]), style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).primaryColor.withOpacity(0.8)
                          )),
                          SizedBox(height: 15),
                          FittedBox(
                            child: Text(snapshot.data[i].message, style: TextStyle(
                            fontSize: 17,
                            color: Theme.of(context).primaryColor.withOpacity(0.8),
                            height: 1.2
                          )),
                          )
                        ],
                      ),
                    );
                  }, 
                ),
              );
            }else if(snapshot.hasData && snapshot.data.length < 1) {
              return LiquidPullToRefresh(
                color: Theme.of(context).primaryColor.withOpacity(0.7),
                key: _refreshIndicatorKey,
                onRefresh: () => notificationsBloc.fetchNotifications(context),
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Center(
                        child: Text("You don't have notification today", style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor)),
                      ),
                    )
                  ],
                ),
              );
            }else if(snapshot.hasError) {
              return ErrorPage(
                message: snapshot.error.toString(), 
                onPressed: () {
                  notificationsBloc.updateListNotification(null);
                  notificationsBloc.fetchNotifications(context);
                },
                buttonText: "Try Again",
              );
            } return LoadingBlock(Theme.of(context).primaryColor);
          },
        ),
      ),
    );
  }
}