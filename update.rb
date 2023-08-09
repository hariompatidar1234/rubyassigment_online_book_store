require_relative 'validation.rb'
class Update
  include Validate
  
  def update_book_details(book_name,bookobj)
    attempts = 0
    loop do
      if bookobj.book_hs_arr.key?(book_name)
        choice = display_update_menu
        case choice
        when 1 then update_book_name(book_name,bookobj)
        when 2 then update_author(book_name,bookobj)
        when 3 then update_amount(book_name,bookobj)
        when 4 then update_quantity(book_name,bookobj)
        when 5 then update_category(book_name,bookobj)
        when 6 then update_description(book_name,bookobj)
        when 7 then return
        else
          puts "Invalid choice. Please try again."
        end
        break
      else
        puts 'Book not found!'
        break
      end
      attempts += 1
      break puts 'Time limit exceeded.' if attempts >= 3
    end
  end

  #update menu by admin
  def display_update_menu
    puts "Select you want to update:"
    puts 
    puts "1. Book name"
    puts "2. Author"
    puts "3. Amount"
    puts "4. Quantity"
    puts "5. Category"
    puts "6. Description"
    puts "7. Exit"
    puts "Enter your choice (1-7):"
    gets.chomp.to_i
  end
  
  #update book name 
  def update_book_name(old_book_name,bookobj)
    attempts = 0
    loop do
      if bookobj.book_hs_arr.key?(old_book_name)
        new_book_name = check_validation('Enter new book name:')
        break unless new_book_name
        bookobj.book_hs_arr[new_book_name] = bookobj.book_hs_arr.delete(old_book_name)
        puts 'Book name updated successfully!'
        break
      else
        puts 'Book not found!'
      end
      attempts += 1
      break puts 'Time limit exceeded.' if attempts >= 3
    end
  end
  
  #update auther name 
  def update_author(book_name,bookobj)
    attempts = 0
    loop do
      if bookobj.book_hs_arr.key?(book_name)
        new_author = check_validation('Enter new author name: ')
        break unless new_author
        bookobj.book_hs_arr[book_name][0] = new_author
        puts 'Author updated successfully!'
        break
      else
        puts 'Book not found!'
      end
      attempts += 1
      break puts 'Time limit exceeded.' if attempts >= 3
    end
  end
  
  #update the ammout of perticular book 
  def update_amount(book_name,bookobj)
    attempts = 0
    loop do
      if bookobj.book_hs_arr.key?(book_name) 
        new_amount = int_validation('Enter new amount: $')
        break unless new_amount
        bookobj.book_hs_arr[book_name][2] = new_amount.to_f
        puts 'Amount updated successfully!'
        break
      else
        puts 'Book not found!'
      end
      attempts += 1
      break puts 'Time limit exceeded.' if attempts >= 3
    end
  end
  
  #add more quantity for book
  def update_quantity(book_name,bookobj)
    attempts = 0
    loop do
      if bookobj.book_hs_arr.key?(book_name) 
        new_quantity = int_validation('Enter new quantity: ')
        break unless new_quantity
        bookobj.book_hs_arr[book_name][3] = new_quantity
        puts 'Quantity updated successfully!'
        break
      else
        puts 'Book not found!'
      end
      attempts += 1
      break puts 'Time limit exceeded.' if attempts >= 3
    end
  end
  
  def update_category(book_name,bookobj)
    attempts = 0
    loop do
      if bookobj.book_hs_arr.key?(book_name)
        new_category = check_validation('Enter new category: ')
        break unless new_category
        bookobj.book_hs_arr[book_name][4] = new_category
        puts 'Category updated successfully!'
        break
      else
        puts 'Book not found!'
      end
      attempts += 1
      break puts 'Time limit exceeded.' if attempts >= 3 
    end
  end
  
  def update_description(book_name,bookobj)
    attempts = 0
    loop do
      if bookobj.book_hs_arr.key?(book_name)
        new_description = check_validation('Enter new description: ')
        break unless new_description
        bookobj.book_hs_arr[book_name][1] = new_description
        puts 'Description updated successfully!'
        break
      else
        puts 'Book not found!'
      end
      attempts += 1
      break puts 'Time limit exceeded.' if attempts >= 3
    end
  end
end 