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
  book = Book.new({author: author, title: title, patron_id: nil, id: nil})
  book.save()
  erb(:index)
end

delete("/catalog/:id") do
  @book =  Book.find(params.fetch("id").to_i())
  @book.delete()
  @books = Book.all()
  erb(:index)
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

post('/patron/form') do
  @patrons = Patron.all()
  erb(:patron)
end

patch("/catalog/:id") do
  title = params.fetch("title")
  author = params.fetch("author")
  @books = Book.all()
  @book = Book.find(params.fetch("id").to_i())
  @book.update({:title => title, :author => author})
  erb(:catalog)
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
