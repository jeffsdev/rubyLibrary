require('capybara/rspec')
require('./app')
require('launchy')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

# describe("the book search path", {:type => :feature}) do
#   it('it filters the catalog according to search term') do
#     visit('/')
#     click_link("View Catalog")
#     expect(page).to have_content("Catalog")
#     click_link("Add a book")
#     fill_in "Author", :with => "alexander"
#     fill_in "Title", :with => "test_title"
#     click_button("Submit")
#     expect(page).to have_content("Library")
#     click_link("View Catalog")
#     fill_in "search", :with => "alexander"
#     click_button("Submit")
#     expect(page).to have_content("alexander")
#   end
# end
