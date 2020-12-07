require 'csv'
require_relative 'person'

class SecretSanta
  attr_accessor :participants, :secret_santa_pairs

  def initialize(file_name: 'secret_santa.csv')
    @secret_santa_pairs = Hash.new
    @participants = CSV.read("#{file_name}").map do |row|
      Person.new(name: row.first, email: row.last)
    end
  end

  def shuffle
    @participants.shuffle.each do |person|
      giving    = @secret_santa_pairs.key(person) if @participants.count.odd?
      receiving = @secret_santa_pairs.values

      secret_santa = (@participants - [person, giving] - receiving).sample

      @secret_santa_pairs[person] = secret_santa
    end

    @secret_santa_pairs
  end

  def show_pairs
    @secret_santa_pairs.each { |giving, receiving| puts build_message(giving, receiving) }
  end

  def send_email
    @secret_santa_pairs.map do |giving, receiving|
      { from: giving.email, to: receiving.email, body: build_message(giving, receiving) }
    end
    # TODO: Implement send email
  end

  private
  def build_message(giving, receiving)
    "Hey #{giving.name}, you secret santa is #{receiving.name}!"
  end
end

if $0 == __FILE__
  secret_santa = SecretSanta.new
  secret_santa.shuffle
  secret_santa.show_pairs
end