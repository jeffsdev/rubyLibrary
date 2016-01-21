class Book
  attr_reader(:author, :title, :patron_id, :id)

  define_method(:initialize) do |attributes|
    @author = attributes.fetch(:author)
    @title = attributes.fetch(:title)
    @patron_id = attributes.fetch(:patron_id)
    @id = attributes.fetch(:id)
  end

  define_method(:==) do |another_book|
    self.title().==(another_book.title())
  end

  def self.all
    returned_books = DB.exec("SELECT * FROM books;")
    Book.map_results_to_objects(returned_books)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO books (author, title, patron_id) VALUES ('#{@author}', '#{@title}', #{@patron_id.to_i}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:delete) do
    DB.exec("DELETE FROM books WHERE id = #{self.id()};")
  end

  define_method(:update) do |attributes|
    @author = attributes.fetch(:author, @author)
    @title = attributes.fetch(:title, @title)
    @patron_id = self.patron_id()
    @id = self.id()
      DB.exec("UPDATE books SET author = '#{@author}', title = '#{@title}' WHERE id = #{@id};")

    attributes.fetch(:patron_ids, []).each() do |patron_id|
      DB.exec("INSERT INTO patrons_books (patron_id, movie_id) VALUES (#{patron_id}, #{self.id});")
  end


  define_method(:patrons) do
    book_patrons = []
    results = DB.exec("SELECT patron_id FROM patrons_books WHERE book_id = #{self.id()};")
    results.each() do |result|
      patron_id = result.fetch("patron_id").to_i()
      patron = DB.exec("SELECT * FROM patrons WHERE id = #{patron_id};")
      name = patron.first().fetch("name")
      book_patrons.push(Patron.new({:name => name, :id => patron_id}))
  end
  book_patrons
end

  define_singleton_method(:find) do |id|
    found_book = nil
    Book.all().each() do |book|
      if book.id().==(id)
        found_book = book
      end
    end
    found_book
  end

  def self.filter(filter)
    filtered_books = DB.exec("SELECT * FROM books WHERE author LIKE '%#{filter}%' OR title LIKE '%#{filter}%';")
    Book.map_results_to_objects(filtered_books)
  end

  def self.map_results_to_objects(filtered_books)
    books = []
    filtered_books.each() do |book|
      author = book.fetch('author')
      title = book.fetch('title')
      patron_id = book.fetch('patron_id').to_i
      id = book.fetch('id').to_i
      books.push(Book.new({author: author,
                           title: title,
                           patron_id: patron_id,
                           id: id}))
    end
    books
  end
end
end
