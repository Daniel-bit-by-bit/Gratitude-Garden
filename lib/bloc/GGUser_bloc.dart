import 'dart:async';
import 'packages:gratitude_garden/GGUser.dart';

class GGUserBloc {
  GGUserDB db;
  List<GGUser> friends;

  final _friendsStreamController = StreamController<List<GGUser>>.broadcast();
  final _friendInsertController = StreamController<GGUser>();
  final _friendController = StreamController<GGUser>();
  final _friendController = StreamController<GGUser>();

  Stream<List<GGUser>> get friends => _friendsStreamController.stream;
  StreamSink<List<GGUser>> get friendsSink => _friendsStreamController.sink;
  StreamSink<GGUser> get friendUpdateSink => _friendInsertController.sink;
  StreamSink<GGUser> get friendUpdateSink => _friendUpdateController.sink;
  StreamSink<GGUser> get friendDeleteSink => _friendDeleteController.sink;
}

Future getFriends() async {
  List<GGUser> friends = await db.getFriends();
  friendsList = friends;
  friendsSink.add(friends);
}

List<GGUser> returnFriends (friends) {
  return friends;
}

void _deleteFriend(GGUser friend) {
  db.deleteFriend(friend).then((result){
    getFriends();
  });
}

void _updateFriends(GGUser friend) {
  db.updateFriends(friend).then((result){
    getFriends();
  })
}

void _addFriend(GGUser friend) {
  db.insertFriend(friend).then((result){
    getTodos();
  })
}

GGUserBloc() {
  db = GGUserDb();
  getFriends();
  //listen to changes (broadcasting)
  _friendsStreamController.stream.listen(returnFriends);
  _friendsInsertController.stream.listen(_addFriend);
  _friendsUpdateController.stream.listen(_updateFriends);
  _friendsDeleteController.stream.listen(_deleteFriend);
}

void dispose() {
  _friendsStreamController.close();
  _friendInsertController.close();
  _friendUpdateController.close();
  _friendDeleteController.close();
}