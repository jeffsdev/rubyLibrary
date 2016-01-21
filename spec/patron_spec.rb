require('spec_helper')

describe(Patron) do
  describe(".all") do
    it("starts off with no patrons") do
      expect(Patron.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("tells you their name") do
      patron = Patron.new({:name => "Greg", :phone => "555-555-5555", :id => nil})
      expect(patron.name()).to(eq("Greg"))
    end
  end

  describe("#id") do
    it("sets the ID when you save it") do
      patron = Patron.new({:name => "Greg", :phone => "555-555-5555", :id => nil})
      patron.save()
      expect(patron.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save patrons to the database") do
      patron = Patron.new({:name => "Greg", :phone => "555-555-5555", :id => nil})
      patron.save()
      expect(Patron.all()).to(eq([patron]))
    end
  end

  describe("#==") do
    it("is the same patron if it has the same name") do
      patron1 = Patron.new({:name => "Greg", :phone => "555-555-5555", :id => nil})
      patron2 = Patron.new({:name => "Greg", :phone => "555-555-5555", :id => nil})
      expect(patron1).to(eq(patron2))
    end
  end
end
