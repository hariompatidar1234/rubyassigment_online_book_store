require 'io/console'
module Validate
  
  #for hide start validation 
  def password_validation(msg)
    print msg
    password = ''
    loop do
      char = $stdin.getch
      break if ["\n", "\r"].include?(char)
      if char == "\b" || char.ord == 127
        if !password.empty?
          password.chop!
          print("\b \b")
        end
      else
        print('*')
        password << char
      end
    end
    password
  end
  
  #string and whitespace check validation 
  def check_validation(var)
    count = 0
    loop do
      print var
      value = gets.chomp.strip
      count += 1
      if value.empty? && count == 3
        puts 'Time Limit Exceed'
        return false 
      end 
      return value unless value.empty?
      puts 'Invalid input. Please try again.'
    end
  end
  
  #number check validation 
  def int_validation(text)
    count = 0
    loop do
      print text
      num = gets.chomp.to_i
      if num >= 1 && num <= 10000
        return num
      else
        count += 1
        puts 'Invalid input! Please try again.' if count < 3
      end
      if count == 3
        puts 'Time limit exceeded....'
        return false 
      end
    end
  end

  #contact validation for m10 digit 
  def contact_validation(prompt, regex)
    count = 0
    loop do
      print prompt
      input = gets.chomp.strip 
      if input.match(regex)
        return input
      else
        count += 1
        puts 'Invalid input! Please try again.'
        if count == 3 
          puts 'Time limit Exceed' 
          return
        end 
      end
    end
  end
end 