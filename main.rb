require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'train.rb'
require_relative 'cargo_car.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_car.rb'
require_relative 'passenger_train.rb'
require_relative 'action.rb'
require_relative 'manufacturer.rb'

action = Action.new
#####для теста
action.trains << PassengerTrain.new('55555')
action.trains << PassengerTrain.new('33333')
action.trains << CargoTrain.new('22222')
action.trains << CargoTrain.new('88888')

action.stations << Station.new('aaa')
action.stations << Station.new('bbb')
action.stations << Station.new('ccc')

#########################
action.run

