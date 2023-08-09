require_relative 'admin.rb'
require_relative 'user.rb'
require_relative 'book.rb'
require_relative 'search.rb'
class Main
  
  def initialize
    @adminobj = Admin.new
    @userobj =User.new
    @searchobj =Search.new
    @bookobj = Book.new
  end  
  def log_in
    system('clear')
    count = 0
    loop do
      puts '***Log in page***'
      puts 
      puts '1. Login as Admin'
      puts '2. Login as user'
      puts '3. Exit'
      puts 
      print 'Enter your choice:'
      choice = gets.chomp.to_i
      case choice
      when 1 then @adminobj.admin_login(@userobj,@bookobj)
      when 2 then @userobj.login_user(@bookobj,@searchobj)
      when 3 then return 
      else
        count += 1
        return puts 'Time limit Exceed' if count == 3
        puts 'Invalid Input'
      end
    end
  end
  
  def display_main_menu
    puts '********** Main Menu **********'
    puts
    puts '1. Browse Books'
    puts '2. Search Books'
    puts '3. Register an Account'
    puts '4. Log In'
    puts '5. Exit'
    puts 
    puts '*******************************'
  end
  
  def start_program
    system('clear')
    count = 0
    puts '================================================'
    puts '|    !!..Welcome to the Online Bookstore..!!    |'
    puts '================================================'
    loop do
      puts
      display_main_menu
      print 'Please enter your choice: '
      choice = gets.chomp.to_i
      puts
      case choice
      when 1 then @bookobj.show_book
      when 2 then @searchobj.searching_option(@bookobj)
      when 3 then @userobj.register_an_account(@bookobj)
      when 4 then log_in
      when 5
        puts 'Thanks for using the online bookstore'
        puts 'Goodbye!'
        puts '=================================================================='
        return
      else
        count += 1
        puts 'Invalid Choice'
        if count == 3
          puts 'Time limit Exceed'
          return 
        end 
      end
    end
  end
  
end 

main = Main.new
main.start_program