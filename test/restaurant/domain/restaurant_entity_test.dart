
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_management/domain/restaurant/entities/restaurant_entity.dart';

import '../../utilities/test_utilities.dart';

void main(){

  setUp(() async{
    await TestUtilities.setupLocalization();
  });


  test('Check if the restaurant is opening in the time  then return TRUE with time format 1',(){
    const entity =  RestaurantEntity(
      name: 'Go Noodle House',
      operatingHours: 'Mon-Sun 12:00 am - 10:00 pm'
    );
    final currentTimeMock = DateTime(2021,9,16,12);
    expect(entity.isOpen(currentTime: currentTimeMock), true);
  });


  test('Check if the restaurant is closed in the time  then return False with time format 1',(){
    const entity =  RestaurantEntity(
        name: 'Go Noodle House',
        operatingHours: 'Mon-Sun 9:30 am - 9:00 pm'
    );
    final currentTimeMock = DateTime(2021,9,16,7);
    expect(entity.isOpen(currentTime: currentTimeMock), false);
  });



  test('Check if the restaurant is opening in the time  then return TRUE time format 2',(){
    final currentTimeMock = DateTime(2021,9,16,11);
    const entity =  RestaurantEntity(
        name: 'Village Park',
        operatingHours: 'Mon-Thu, Sun 9:30 am - 10:00 pm  / Fri-Sat 11:30 am - 11:00 pm'
    );
    expect(entity.isOpen(currentTime: currentTimeMock), true);
  });

  test('Check if the restaurant is closed in the time  then return FALSE time format 2',(){
    final currentTimeMock = DateTime(2021,9,16,23);
    const entity =  RestaurantEntity(
        name: 'Village Park',
        operatingHours: 'Mon-Thu, Sun 9:30 am - 10:00 pm  / Fri-Sat 11:30 am - 11:00 pm'
    );
    expect(entity.isOpen(currentTime: currentTimeMock), false);
  });



  test('Check if the restaurant is closed in a day  then return FALSE time format 2',(){
    final currentTimeMock = DateTime(2021,9,16,12);
    const entity =  RestaurantEntity(
        name: 'Village Park',
        operatingHours: 'Mon-Wed, Sun 9:30 am - 10:00 pm  / Fri-Sat 11:30 am - 11:00 pm'
    );
    expect(entity.isOpen(currentTime: currentTimeMock), false);
  });



}