class Patron
  attr_reader(:name, :phone, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @phone = attributes.fetch(:phone)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    Patron.map_results_to_objects(returned_patrons)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patrons (name, phone) VALUES ('#{@name}', '#{@phone}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:delete) do
    DB.exec("DELETE FROM patrons_books WHERE patron_id = #{self.id()};")
    DB.exec("DELETE FROM patrons WHERE id = #{self.id()};")
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE patrons SET name = '#{@name}' WHERE id = #{self.id()};")
    attributes.fetch(:book_ids, []).each() do |book_id|
      DB.exec("INSERT INTO patrons_books (patron_id, book_id) VALUES (#{self.id()}, #{book_id});")
    end
  end

  define_method(:books) do
    patron_books = []
    results = DB.exec("SELECT book_id FROM patrons_books WHERE patron_id = #{self.id()};")
    results.each() do |result|
      book_id = result.fetch("book_id").to_i()
      book = DB.exec("SELECT * FROM books WHERE id = #{book_id};")
      title = book.first().fetch("title")
      author = book.first().fetch("author")
      patron_books.push(Book.new({:title => title, :author => title, :id => book_id}))
    end
    patron_books
  end

  define_singleton_method(:find) do |id|
    found_patron = nil
    Patron.all().each() do |patron|
      if patron.id().==(id)
        found_patron = patron
      end
    end
    found_patron
  end

  def self.map_results_to_objects(returned_patrons)
    patrons = []
    returned_patrons.each() do |patron|
      name = patron.fetch("name")
      phone = patron.fetch("phone")
      id = patron.fetch("id").to_i()
      patrons.push(Patron.new({:name => name, :phone => phone, :id => id}))
    end
    patrons
  end

  def ==(another_customer)
    self.name() == another_customer.name() &&
    self.id() == another_customer.id() &&
    self.phone().to_i == another_customer.phone().to_i
  end

end
