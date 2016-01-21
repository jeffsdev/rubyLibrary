require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/patron")
require("./lib/book")
require("pg")
require("pry")

DB = PG.connect({:dbname => "library"})

get('/') do
  erb(:index)
end

get("/catalog") do
  @books = Book.all()
  erb(:catalog)
end

get("/catalog/book_form") do
  @books = Book.all()
  erb(:book_form)
end

post('/catalog') do
  @books = Book.all()
  @book =  Book.find(params.fetch("id").to_i())
  #@id = Book.id()
  author = params.fetch('author')
  title = params.fetch('title')
  book = Book.new({author: author, title: title, id: nil})
  book.save()
  erb(:index)
end

delete("/catalog/:id") do
  @book =  Book.find(params.fetch("id").to_i())
  @book.delete()
  @books = Book.all()
  erb(:index)
end

delete("/patron/:id") do
  @patron =  Patron.find(params.fetch("id").to_i())
  @patron.delete()
  @patrons = Patron.all()
  erb(:patron)
end

get('/catalog/:id') do
  @book =  Book.find(params.fetch("id").to_i())
  erb(:book_page)
end

get('/catalog/:id/edit') do
  @book =  Book.find(params.fetch("id").to_i())
  erb(:edit_book)
end

get('/patron') do
  @patrons = Patron.all()
  erb(:patron)
end

get('/patron/form') do
  @patrons = Patron.all()
  erb(:patron_form)
end

post('/patron') do
  @patrons = Patron.all()
  name = params.fetch('name')
  phone = params.fetch('phone')
  id = params.fetch('id')
  patron = Patron.new({name: name, phone: phone, id: nil})
  patron.save()
  erb(:patron)
end

get('/patron/:id') do
  @books = Book.all()
  @patrons = Patron.all()
  @patron =  Patron.find(params.fetch("id").to_i())
  erb(:patron_page)
end

patch("/catalog/:id") do
  title = params.fetch("title")
  author = params.fetch("author")
  @books = Book.all()
  @book = Book.find(params.fetch("id").to_i())
  @book.update({:title => title, :author => author})
  erb(:catalog)
end

patch("/patron/:id") do
  patron_id = params.fetch("id").to_i()
  @patron = Patron.find(patron_id)
  book_ids = params.fetch("book_ids")
  @patron.update({:book_ids => book_ids})
  @books = Book.all()
  erb(:patron_page)
end

post('/catalog/search') do
  @results =  Book.filter(params.fetch("search"))
  erb(:search_result)
end

get("/librarian") do
  erb(:librarian)
end

get("/patron") do
  erb(:patron)
end
