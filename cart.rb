require_relative 'validation.rb'
class Cart
  include Validate
  
  def initialize
    @cart = []
  end 
  
  #add to cart by user 
  def add_to_cart(book_name, quantity,bookobj)
    book_details = bookobj.book_hs_arr[book_name]
    return puts 'Error: Book not found' if book_details.nil?
    if  book_details[3] >= quantity
      book_details = book_details.dup #copy data
      book_details[3] = quantity
      @cart << book_details
      puts "#{quantity} of #{book_name} have been added to the cart."
      # Update the quantity in @book_hs_arr
      bookobj.book_hs_arr[book_name][3] -= quantity 
    else
      puts 'Error: Insufficient quantity!'
    end
  end
  
  #show cart by user when cart is empty or not 
  def show_cart()
    if @cart.empty?
      puts 'Your cart is empty.'
    else
      puts 'Your cart contains the following books:'
      total_amount = 0
      @cart.each_with_index do |book, index|
        puts '*' * 10 + "Book #{index + 1}" + '*' * 10
        puts "Author Name: #{book[0]}"
        puts "Amount: $#{book[2]}"
        puts "Quantity: #{book[3]}"
        puts "Category: #{book[4]}"
        total_amount += book[2] * book[3]
      end
      puts '*' * 35
      puts "Total Amount: $#{total_amount}"
      puts '*' * 35
    end
  end
  
  #after add cart and place order 
  def place_order
    if @cart.empty?
      puts 'Your cart is empty. Please add books to your cart.'
    else
      puts 'Your order has been placed..!!'
      @cart.clear
      puts 'You want to rate...(Y/N)?'
      choice = gets.chomp.downcase
      if choice == 'y'
        rate
      else
        puts 'Thanks for Shopping!'
      end
    end
  end
  
  #after place order give a rating 
  def rate
    count = 0
    loop do
      puts 'Rating Between(1 to 5)'
      rate = gets.chomp.to_i
      if (1..5).include?(rate)
        puts 'Thanks for Rating'
        return
      else
        puts 'Gives Valid Rating'
        count += 1
        if count == 3
          puts 'Time limit Exceeded' 
          return 
        end 
      end
    end
  end
  
end  
