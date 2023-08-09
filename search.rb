require_relative 'validation.rb'
class Search
  include Validate

  #search option by any user 
  def searching_option(bookobj)
    count = 0
    loop do
      puts '*****Search book by*****'
      puts 
      puts '1 By category'
      puts '2 By Bookname'
      puts '3 By author'
      puts '4 Exit'
      puts 
      puts ('Enter your option for Search :=>')
      choice = gets.chomp.to_i
      case choice
      when 1 then 
        search_term =check_validation('Enter the Category:')
        break unless search_term
        search_by_category(search_term,bookobj)
      when 2 then
        book_search_term =check_validation('Enter Book name:')
        break unless book_search_term
        search_book_by_name_or_character(book_search_term,bookobj)
      when 3 then
        author_search_term=check_validation('Enter the author:')
        break unless author_search_term
        search_books_by_author(author_search_term,bookobj)
      when 4 then 
        return
      else
        count += 1
        return puts 'Time limit Exceeded' if count == 3
        puts 'Invalid Input'
      end
    end
  end
  
  #search auther by any person 
  def search_books_by_author(search_term,bookobj)
    results = {}
    bookobj.book_hs_arr.each do |title, details|
      author = details[0].downcase # author name is in lowercase
      if author.include?(search_term.downcase)
        results[title] = details
      end
    end
    if results.empty?
      puts 'No author match'
    else
      display_search_results(results)
    end
  end
  
  #search category by any user 
  def search_by_category(search_term,bookobj)
    results = {}
    bookobj.book_hs_arr.each do |title, details|
      category = details[4].downcase
      if category.include?(search_term.downcase)
        results[title] = details
      end
    end
    if results.empty?
      puts 'No books found'
    else
      display_search_results(results)
    end
  end
  
  #book search nam and also any character 
  def search_book_by_name_or_character(search_term,bookobj)
    results = [] 
    bookobj.book_hs_arr.each do |book_name, book_details|
      next unless book_name.downcase.include?(search_term.downcase)
      results << { book_name => book_details } #array me hash gaaya 
    end
    if results.empty?
      puts 'No matching books found.'
    else
      puts 'Matching books:'
      results.each do |result|
        title = result.keys.first
        details = result.values.first
        puts "Title: #{title}"
        puts "Author: #{details[0]}"
        puts "Description: #{details[1]}"
        puts "Price: $#{details[2]}"
        puts "Available Copies: #{details[3]}"
        puts "Category: #{details[4]}"
        puts '-----------------------------'
        puts '-' * 30
      end
    end
  end
  
  def display_search_results(results)
    results.each do |title, details|
      puts "Title: #{title}"
      puts "Author: #{details[0]}"
      puts "Description: #{details[1]}"
      puts "Price: $#{details[2]}"
      puts "Available Copies: #{details[3]}"
      puts "Category: #{details[4]}"
      puts '-----------------------------'
      puts '-' * 30
    end
  end
  
end 