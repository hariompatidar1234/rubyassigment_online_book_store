require_relative 'validation.rb'
require_relative 'update.rb'
require_relative 'user.rb'
class Admin
  include Validate
  def initialize
    @updateobj=Update.new
  end 
  
  def display_menu
    puts 
    puts '1. Add book'
    puts '2. Show all books'
    puts '3. Show user details'
    puts '4. Update book details'
    puts '5. Delete book'
    puts '6. Exit'
    puts '-' * 30
  end
  
  def get_user_choice
    puts 'Enter your interest: '
    gets.chomp.to_i
  end
  
  def admin_panel(userobj, bookobj)
    system('clear')
    count = 0
    loop do
      display_menu
      choice = get_user_choice
      case choice
      when 1 then bookobj.add_book
      when 2 then bookobj.show_book
      when 3 then userobj.show_user_detail_by_admin
      when 4 then
        bookobj.show_book
        book_name = check_validation('Enter accurate name of the book you want to change: ')
        @updateobj.update_book_details(book_name,bookobj)
      when 5 then bookobj.show_book; bookobj.delete_book
      when 6 then return
      else
        count += 1
        puts 'Invalid Input'
        if count == 3
          puts 'Time limit Exceeded'
          return
        end
      end
    end
  end
  
  #admin login 
  def admin_login(userobj,bookobj)
    admin = %w[admin 123]
    count = 0
    admin_id = check_validation('Enter Admin ID:')
    return unless admin_id
    password = password_validation('Enter password:')
    if admin[0] == admin_id && admin[1] == password
      puts '===== Login successful ====='
      puts
      admin_panel(userobj,bookobj)
      return
    else
      puts 
      puts 'Invalid Admin ID or password'
      count += 1
    end
    if count == 3
      puts 'Time Limit exceeded'
    end 
  end
  
end 