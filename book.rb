require_relative 'validation.rb'
require_relative 'search.rb'
class Book
  attr_accessor :book_hs_arr, :category_hs, :username, :author, :description, :price, :quantity, :categories, :cart
  include Validate
  def initialize
    @book_hs_arr = {
      'Mockingbird' => ['Harper', 'classic novel set in the 1930s moral', 12.99, 30, 'Fiction'],
      'Sapiens king' => ['Yuval ', 'An engaging exploration', 14.99, 50, 'Non-Fiction'],
      'Gone Girl' => ['Gillian Flynn', 'A gripping psychological thriller', 11.99, 55, 'Mystery'],
      'CosmicChronicles' => ['Rahul Sharma', 'Chronicles isascience fiction', 33.04, 15, 'Science Fiction'],
      'Journey of a Soul' => ['Aparna Patel', 'Journey of a Soul this bpok', 50.30, 10, 'Biography'],
      'Whispers in the Dark' => ['Priya Sharma', 'Whispers in the Dark', 34.45, 12, 'Horror']
    }
    @category_hs = {
      'Fiction' => ['Mockingbird'],
      'Non-Fiction' => ['Sapiens king'],
      'Mystery' => ['Gone Girl'],
      'Science Fiction' => ['CosmicChronicles'],
      'Biography' => ['Journey of a Soul'],
      'Horror' => ['Whispers in the Dark']
    }
    
  end
  
  #Add book in the book store 
  def add_book
    loop do
      book_name = check_validation('Enter the book name:')
      break unless book_name
      if @book_hs_arr.key?(book_name)
        puts 'Book name already exists'
        return
      end
      author = check_validation('Enter the book author:')
      break unless author
      description = check_validation('Enter the description:')
      break unless description
      price = int_validation('Enter price: $')
      break unless price
      quantity = int_validation('Enter quantity:')
      break unless quantity
      categories = check_validation('Enter Book category:')
      break unless categories
      book_arr = [author, description, price, quantity, categories, []]
      @book_hs_arr[book_name] = book_arr
      add_category(categories, book_name)
      puts '***** Book added successfully *****'
      choice = check_validation('Add more books? (Y/N)')
      return if choice.downcase == 'n'
      puts 'Please enter a valid input (Y/N).'
    end
  end
  
  #if admin add new category 
  def add_category(category, book_name)
    @category_hs[category] = [] 
    @category_hs[category] << book_name unless @category_hs[category].include?(book_name)
  end
  
  #show all book admin and user 
  def show_book() 
    if @book_hs_arr.empty?
      puts 'book not Available'
    else 
      @book_hs_arr.each do |key, value|
        display_book_info(key, value)
        puts '-' * 30
      end
    end 
  end 
  
  # display book information
  def display_book_info(book_name, value)
    puts "Book name = #{book_name}"
    puts "Author name = #{value[0]}"
    puts "Description = #{value[1]}"
    puts "Price = #{value[2]}"
    puts "Quantity = #{value[3]}"
    puts "Category = #{value[4]}"
  end
  
  # print all category have in book store
  def show_all_categories
    if @category_hs.empty?
      puts 'No categories found.'
    else
      puts '***** Available Categories: *****'
      @category_hs.keys.each do |category|
        puts category
      end
    end
  end
  
  #remove book book store
  def delete_book
    attempts = 0
    loop do
      name = check_validation('Enter book name you want to delete:')
      return unless name
      if @book_hs_arr.delete(name)
        puts 'Deleted successfully.'
        break
      else
        puts 'Book name is not found.'
      end
      attempts += 1
      if attempts >= 3
        puts 'Maximum attempts reached. Time limit exceeded.' 
        return
      end 
    end
  end
  # 
end 