class Station

  require_relative 'instance_counter.rb'
  include InstanceCounter

  @@all_stations = []

  def self.all
    @@all_stations
  end

  attr_reader :trains, :name

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@all_stations.push(self)
    register_instance
  end

  def take_train(train)
    @trains << train
  end
  
  def send_train(train)
    @trains.delete(train)
  end

  def trains_by_class(car_class = nil)
    if car_class == nil
      @trains
    else
      @trains.find_all { |tr| tr.class == car_class }
    end
  end

  def validate!
    raise 'Название станции должно состоять не менее, чем из двух символов' if @name.to_s.length < 2
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  def block_stations (&block) #метод принимает блок и проходит по всем поездам на станции, передавая каждый поезд в блок.
    @trains.each do |train|
      yield(train)
    end
  end
end

