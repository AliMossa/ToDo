class Model{
  int id;
  String mission;
  bool complete;
 int userId;
 Model(this.id,this.mission,this.complete,this.userId);

 bool isEmptyModel()=>mission.isEmpty ?false:true;
}