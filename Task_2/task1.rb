require 'date'

module Validation
  def self.valid_name?(string)
    if string =~ /\A[A-Za-z]+(-[A-Za-z]+)*\z/ && string.length <= 40
      true
    else
      false
    end
  end

  def self.valid_inn?(string)
    if string =~ /\A[A-Z]{2}\d{10}\z/
      true
    else
      false
    end
  end

  def self.after_date?(date)
    if date < Date.today
      true
    else
      false
    end
  end
end

puts Validation.valid_name?("Maria-Anna")
puts Validation.valid_name?("Svan-Ivanov")
puts Validation.valid_name?("Serhii-Pertonymous")

puts Validation.valid_inn?("AZ1234543456")
puts Validation.valid_inn?("AB4386736744")
puts Validation.valid_inn?("AC6324673665")

puts Validation.after_date?(Date.new(2003, 04, 13))
puts Validation.after_date?(Date.today)
