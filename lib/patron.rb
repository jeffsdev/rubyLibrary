class Patron
  attr_reader(:name, :phone, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @phone = attributes.fetch(:phone)
    @id = attributes.fetch(:id)
  end

    define_singleton_method(:all) do
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    patrons = []
    returned_patrons.each() do |patron|
      name = patron.fetch("name")
      phone = patron.fetch("phone")
      id = patron.fetch("id").to_i()
      patrons.push(Patron.new({:name => name, :phone => phone, :id => id}))
    end
    patrons
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patrons (name, phone) VALUES ('#{@name}', '#{@phone}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  # define_method(:==) do |another_patron|
  #   self.name().==(another_patron.name()).&(self.id().==(another_patron.id()))
  # end

  def ==(another_customer)
    self.name() == another_customer.name() &&
    self.id() == another_customer.id() &&
    self.phone().to_i == another_customer.phone().to_i
  end

  end
