require 'json'

class Book
  attr_accessor :title, :author, :isbn

  def initialize(title, author, isbn)
    @title = title
    @author = author
    @isbn = isbn
  end

 
end

class Inventory
  attr_accessor :books
  FILE_NAME = "Inventory.json"

  def initialize
    if File.exist?(FILE_NAME)
      file = File.read(FILE_NAME)
      data = JSON.parse(file)
      @books = data.map { |book| Book.new(book["title"], book["author"], book["isbn"]) }
    puts @books[0].title
    else
      @books = []
    end
  end

  def add_book(book)
    @books << book
    save_inventory
  end

  def remove_book(isbn)
    @books.delete_if { |book| book.isbn == isbn }
    save_inventory
  end

  def find_book(isbn)
    @books.find { |book| book.isbn == isbn }
  end

  def list_books
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}, ISBN: #{book.isbn}"
    end
  end

  def save_inventory
    books_array = @books.map do |book|
      { title: book.title, author: book.author, isbn: book.isbn }
    end

    File.write(FILE_NAME, JSON.pretty_generate(books_array))
  end
end

inventory = Inventory.new

inventory.add_book(Book.new("Learn Ruby", "Jane Doe", "9876543210"))
inventory.add_book(Book.new("Master Rails", "John Smith", "1234567890"))

inventory.list_books

book = inventory.find_book("9876543210")
puts "Found book: #{book.title} by #{book.author}" 
