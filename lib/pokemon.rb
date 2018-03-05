require 'pry'
class Pokemon
  attr_accessor :name,:type,:db,:id
  def initialize(hash)
    @id=hash[:id]
    @name=hash[:name]
    @type=hash[:type]
    @db=[:db]
  end
  def self.save(name,type,db)
    @name=name
    @type=type
    @db=db
    sql = <<-SQL
      INSERT INTO pokemon (name , type)
      VALUES (?, ?)
    SQL
    @db.execute(sql,name,type)
    @id=("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end
  def self.find(id, db)
    @id=id
    @db=db
    sql = <<-SQL
      SELECT * FROM pokemon WHERE id= ?
    SQL
    new_poke = @db.execute(sql,id)
    poke=Hash.new
    poke = { "id": new_poke[0][0] , "name": new_poke[0][1] , "type": new_poke[0][2] , "db": @db}
    pokemon = self.new(poke)
  end

end
