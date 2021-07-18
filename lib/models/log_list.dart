
class LogList{
  var id;
  var date;
  var won;
  var dollar;
  var depWon;
  var depDol;
  var withWon;
  var withDol;

  LogList(this.id,this.date, this.won, this.dollar, this.depWon, this.depDol, this.withWon, this.withDol);

  Map<String, dynamic> toMap() {
    return{
      'id' : (id==0)?null:id,
      'date' : date,
      'won' : won,
      'dollar' : dollar,
      'depWon' : depWon,
      'depDol' : depDol,
      'withWon' : withWon,
      'withDol' : withDol,
    };
  }
}