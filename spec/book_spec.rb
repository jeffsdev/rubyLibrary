require('spec_helper')

describe(Book) do
  describe("#==") do
    it("is the same book if it has the same title") do
      book1 = Book.new({:author => "Joyce", :title => "Ulysses", :patron_id => 1, :id =>nil})
      book2 = Book.new({:author => "Joyce", :title => "Ulysses", :patron_id => 1, :id => nil})
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
      book = Book.new({:author => "Joyce", :title => "Ulysses", :patron_id => 1, :id => nil})
      end
    end

    describe("#save") do
      it("adds an book to the array of saved books") do
      test_book = Book.new({:author => "Joyce", :title => "Ulysses", :patron_id => 1, :id => 1})
      test_book.save()
      expect(Book.all()).to(eq([test_book]))
      end
    end

    describe("#delete") do
    it("lets you delete a bookfrom the database") do
      book = Book.new({:author => "Joyce", :title => "Ulysses", :patron_id => 1, :id => nil})
      book.save()
      book2 = Book.new({:author => "Proust", :title => "Recherche", :patron_id => 3, :id => nil})
      book2.save()
      book.delete()
        expect(Book.all()).to(eq([book2]))
    end
  end

    describe("#update") do
      it("lets you update books in the database") do
        book = Book.new({:author => "Joyce", :title => "Ulysses", :patron_id => 1, :id => nil})
        book.save()
        book.update({:author => "Joyce2", :title => "Ulysses2", :patron_id => 3, :id => nil})
          expect(book.title()).to(eq("Ulysses2"))
      end
    end

    describe('.filter') do
      it('filters by given parameter') do
        book1 = Book.new({author: "Joyce",
                             title: "Ulysses",
                             patron_id: 1,
                             id: nil})
        book1.save
        book2 = Book.new({author: "Rilke",
                             title: "Poetry",
                             patron_id: 1,
                             id: nil})
       book2.save
       book3 = Book.new({author: "Joyce",
                             title: "Finnegans Wake",
                             patron_id: 1,
                             id: nil})
        book3.save
        expect(Book.filter("Joyce")).to(eq([book1, book3]))
      end
    end
  end
