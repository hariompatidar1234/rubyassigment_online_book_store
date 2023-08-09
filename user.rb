require_relative 'validation.rb'
require_relative 'cart.rb'
class User
  include Validate
  attr_accessor :user_hs_arr, :username, :address, :contact, :password, :username
  
  def initialize
    @user_hs_arr = {
      'devendra123' => ['ujjain', 9165976224, '12345'],
      'user' => ['devas', 8462963139, '123']
    }
    @cartobj = Cart.new
  end 
  
  #user working 
  def register_an_account(bookobj)
    attempts = 0
    loop do
      puts '1 Create user account'
      puts ''
      puts '2 Exit'
      puts ''
      puts 'Enter your choice:'
      choice = gets.chomp.to_i
      case choice
      when 1
        user_details
        break
      when 2
        return
      else
        puts 'Invalid Input'
        attempts += 1
        return puts 'Maximum attempts reached. Time limit exceeded.' if attempts >= 3
      end
    end
  end
  
  def user_penal(bookobj,searchobj)
    system('clear')
    count = 0
    loop do
      puts '***** User Penal *****'
      puts 
      puts '1. See Your details'
      puts '2. See all Books'
      puts '3. See all categories'
      puts '4. Search book by category'
      puts '5. Change password'
      puts '6. Add to cart'
      puts '7. See cart'
      puts '8. Place order'
      puts '9. Return'
      puts '-' * 30
      puts ('Enter your option:')
      choice =gets.chomp.to_i
      case choice
      when 1 then  username = check_validation('Enter username:'); show_user_detail(username)
      when 2 then bookobj.show_book
      when 3 then  bookobj.show_all_categories 
      when 4 then search_term = check_validation('Enter category:');  searchobj.search_by_category(search_term,bookobj)
      when 5 then  res = user_change_details; return unless res
      when 6 then 
        bookobj.show_book
        book_name = check_validation('Enter Book name:')
        if book_name != 'Invalid input'
          quant=int_validation('Enter quantity:')
          if (quant != false)
            @cartobj.add_to_cart(book_name,quant,bookobj)
          end 
        end 
      when 7 then @cartobj.show_cart()
      when 8 then  @cartobj.place_order()
      when 9 then  break
      else
        puts 'Invalid Input'
        count += 1
        if count == 3
          puts 'Time limit Exceed'
          return
        end 
      end
    end
  end

  #user login 
  def login_user(bookobj,searchobj)
    count = 0
    username = check_validation('Enter Username:')
    return unless username 
    password = password_validation('Enter password:')
    u_hs = @user_hs_arr
    if u_hs.key?(username)
      user_data = u_hs[username]
      if user_data[2] == password
        puts 'Login successful'
        user_penal(bookobj,searchobj)
      else
        puts 
        puts 'Invalid password'
      end
    else
      puts 
      puts 'User not found'
      count += 1
      if count == 3
        puts 'Time limit exceed' 
        return 
      end 
    end
  end

  def user_details
    username = check_validation('Enter your Username:')
    # return if username == 'Invalid input'
    return unless username 
    while @user_hs_arr.key?(username)
      puts'User name already axists.please valid user'
      return
    end
    address = check_validation('Enter Address:')
    return  unless address
    contact_regex = /^\d{10}$/ # Regular expression (10 digits not special characters)
    contact = contact_validation('Enter your contact (10 
    digits only):', contact_regex)
    return if contact.nil?
    password = check_validation('Create Password:')
    return  unless password
    puts 'Congratulations! Account Created Successfully'
    @user_hs_arr[username] = [address, contact,password] # Store user details in the hash.
  end
    
  def show_user_detail_by_admin
    puts '***** User details *****'
    puts 
    @user_hs_arr.each do |username, user_data|
      puts "Username: #{username}"
      puts "Address: #{user_data[0]}"
      puts "Contact Number: #{user_data[1]}"
      puts '-' * 30
    end
  end
  # Show user details by username
  def show_user_detail(username)
    user_data = @user_hs_arr[username]
    if user_data
      puts "Username: #{username}"
      puts "Address: #{user_data[0]}"
      puts "Contact Number: #{user_data[1]}"
    else
      puts 'User not found!'
    end
  end
    
  # User change password
  def user_change_details
    attempts = 0
    username = check_validation('Enter username:')
    user_data = @user_hs_arr[username]
    if user_data
      old_password = check_validation('Please enter your old password:')
      if user_data.include?(old_password)
        new_password = check_validation('Please enter new password:')
        user_data[2] = new_password
        puts 'Password changed successfully.'
        return false 
      else
        puts 'Invalid old password.'
      end
    else
      puts 'User not found.'
    end
    attempts += 1
    if attempts >= 3
      puts 'Time limit exceeded.'
      return 
    end 
  end
end 