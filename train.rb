class Train

  require_relative 'manufacturer.rb'
  require_relative 'instance_counter.rb'

  include Manufacturer
  include InstanceCounter

  attr_reader :speed, :route, :number, :cars, :station_number

  @@all_trains = []

  TRAIN_NUMBER = /^\w{3}\-?\w{2}$/  #три буквы/цифры, необязательный дефис, 2 буквы/цифры.

  def self.find(train_number)
    @@all_trains.select{ |t| t.number == train_number }[0]
  end

  def initialize(number)
    @number = number
    validate!
    @speed = 0
    @station_number = 0
    @cars = []
    @@all_trains.push(self)
    register_instance
  end

  def validate!
    raise 'Номер поезда должен быть следующего формата: три буквы/цифры, необязательный дефис, 2 буквы/цифры' if @number !~ TRAIN_NUMBER
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  def accelerate(speed)
    @speed = speed
  end

  def brake
    @speed = 0
  end

  def detach_car(car)
    @cars.delete(car) if @speed==0
  end

  def get_route(route)
    @route = route
    @station_number = 0
  end

  def move_forward

    if (@station_number + 1) >= @route.route_stations.size
      puts 'Нельзя переместить поезд дальше конечной станции'
    else
      @route.route_stations[station_number].send_train(self)
      @route.route_stations[station_number+1].take_train(self)
      @station_number += 1
    end
  end
  
  def move_back

    if @station_number == 0
      puts 'Нельзя переместить поезд дальше начальной станции'
    else
      @route.route_stations[station_number].send_train(self)
      @route.route_stations[station_number-1].take_train(self)
      @station_number -= 1
    end
  end

  def previous_station
    @route.route_stations[@station_number - 1] if @station_number >= 1
  end

  def current_station
    @route.route_stations[@station_number]
  end

  def next_station
    @route.route_stations[@station_number + 1] if @station_number < @route.route_stations.size
  end

  def attach_car(car)
    if @speed == 0 and @type == car.type
      @cars << car
    end
  end

  def block_cars(&block) #принимает блок, проходит по всем вагонам поезда, передавая каждый объект вагона в блок.
    cars.each do |car|
      yield(car)
    end
  end
end

