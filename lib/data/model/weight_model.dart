
import 'package:equatable/equatable.dart';
class WeightModel extends Equatable {
final  double weight;
final  String? id;
final  DateTime? createdAt;
const  WeightModel({required this.weight, this.id,this.createdAt, });


 factory WeightModel.fromJson(Map<String, dynamic> json,id) => WeightModel(weight: json['weight'],

createdAt: json['created_at'].toDate(),
id: id

 );
  @override

  List<Object?> get props => [weight];

}