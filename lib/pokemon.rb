require 'pry'
class Pokemon
  attr_accessor :name,:type,:db,:id,:hp
  def initialize(hash)
    @id=hash[:id]
    @name=hash[:name]
    @type=hash[:type]
    @db=[:db]
    @hp=hash[:hp]
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
    @id= db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end
  def self.find(id, db)
    @id=id
    @db=db
    sql = <<-SQL
      SELECT * FROM pokemon WHERE id= ?
    SQL
    new_poke = @db.execute(sql,id)
    poke=Hash.new
    poke = { "id": new_poke[0][0] , "name": new_poke[0][1] , "type": new_poke[0][2] , "hp": new_poke[0][3], "db": @db}
    pokemon = self.new(poke)
  end

  def alter_hp(hp,db)
    @hp = hp
    @db = db
    sql = <<-SQL
      UPDATE pokemon SET hp= ? WHERE id= ?
    SQL
    @db.execute(sql,hp,@id)
  end
end
