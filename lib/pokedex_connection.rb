require 'pg'

class Pokedex 
  def self.open
    if ENV["USER"] == "zacharyolson"
      @conn = PG::Connection.new(dbname: 'pokedex')
    else
      @conn = PG::Connection.new(
        host: 'ec2-54-83-59-154.compute-1.amazonaws.com',
        dbname: 'd9u4r4jh0k4huk',
        port: 5432,
        user: 'mcbkpplzftqrmi',
        password: '0IkiVL_rPNbozqeAt2YrcDYe5S'
      )
    end
  end

  def self.instance
    Pokedex.open() if @conn.nil?

    @conn
  end

  def self.exec(*args)
    self.instance.exec(*args)
  end

  def self.exec_params(*args)
    self.instance.exec_params(*args)
  end
end