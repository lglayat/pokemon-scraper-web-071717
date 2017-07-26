class Pokemon

  attr_accessor :name, :type, :db, :id, :hp

  @@all =[]

  def initialize(args)
    @name = args[:name]
    @type = args[:type]
    @db = args[:db]
    @id = args[:id]
    @hp = args[:hp]
    @@all << self
  end



  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (id, name, type) VALUES (?, ?, ?)" ,@id, name, type)
  end

  def self.find(id, db)
    poke_data = db.execute("SELECT * FROM pokemon WHERE id =?", id )
    data = poke_data.flatten
    # binding.pry
    poke_hash = {:name => data[1], :id => data[0] , :type => data[2], :db => db, :hp => data[3]}
    pokemon = Pokemon.new(poke_hash)
    pokemon
  end

  def alter_hp(new_hp, db)
    sql = "UPDATE pokemon SET hp = ? WHERE id=?"
    db.execute(sql, new_hp, id)
    @hp = new_hp
  end


end
