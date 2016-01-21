require('spec_helper')

describe(Book) do
  describe("#==") do
    it("is the same book if it has the same title") do
      book1 = Book.new({:author => "Joyce", :title => "Ulysses", :id =>nil})
      book2 = Book.new({:author => "Joyce", :title => "Ulysses", :id => nil})
      expect(book1).to(eq(book2))
    end
  end

    describe(".all") do
      it("starts off with no books") do
        expect(Book.all()).to(eq([]))
      end
    end

    describe("#title") do
      it("tells you its title") do
      book = Book.new({:author => "Joyce", :title => "Ulysses", :id => nil})
      end
    end

    describe("#save") do
      it("adds an book to the array of saved books") do
      test_book = Book.new({:author => "Joyce", :title => "Ulysses", :id => 1})
      test_book.save()
      expect(Book.all()).to(eq([test_book]))
      end
    end

    describe("#delete") do
    it("lets you delete a bookfrom the database") do
      book = Book.new({:author => "Joyce", :title => "Ulysses", :id => nil})
      book.save()
      book2 = Book.new({:author => "Proust", :title => "Recherche", :id => nil})
      book2.save()
      book.delete()
        expect(Book.all()).to(eq([book2]))
    end
  end

    describe("#update") do
      it("lets you update books in the database") do
        book = Book.new({:author => "Joyce", :title => "Ulysses", :id => nil})
        book.save()
        book.update({:author => "Joyce2", :title => "Ulysses2", :id => nil})
          expect(book.title()).to(eq("Ulysses2"))
      end

      it("lets you add a patron to a book") do
       book = Book.new({:author => "Joyce", :title => "Ulysses", :id => nil})
       book.save()
       patron1 = Patron.new({:name => "Greg", :phone => "555-555-5555", :id => nil})
       patron1.save()
       patron2 = Patron.new({:name => "Jeff", :phone => "777-777-7777", :id => nil})
       patron2.save()
       book.update({:patron_ids => [patron1.id(), patron2.id()]})
       expect(book.patrons()).to(eq([patron1, patron2]))
      end
    end

  describe("#patrons") do
    it("returns all of the patrons that have checked out a book") do
      book = Book.new({:author => "Joyce", :title => "Ulysses", :id => nil})
      book.save()
      patron1 = Patron.new({:name => "Greg", :phone => "555-555-5555", :id => nil})
      patron1.save()
      patron2 = Patron.new({:name => "Jeff", :phone => "777-777-7777", :id => nil})
      patron2.save()
      book.update({:patron_ids => [patron1.id(), patron2.id()]})
      expect(book.patrons()).to(eq([patron1, patron2]))
    end
  end

    describe('.filter') do
      it('filters by given parameter') do
        book1 = Book.new({author: "Joyce",
                             title: "Ulysses",
                             id: nil})
        book1.save
        book2 = Book.new({author: "Rilke",
                             title: "Poetry",
                             id: nil})
       book2.save
       book3 = Book.new({author: "Joyce",
                             title: "Finnegans Wake",
                             id: nil})
        book3.save
        expect(Book.filter("Joyce")).to(eq([book1, book3]))
      end
    end


  end
