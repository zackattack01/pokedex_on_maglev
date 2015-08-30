require 'pg'

# https://tomafro.net/2010/01/tip-relative-paths-with-file-expand-path
ROOT_FOLDER = File.join(File.dirname(__FILE__), '..')
SQL_FILE = File.join(ROOT_FOLDER, 'pokesnag_ultra.sql')
DB_FILE = File.join(ROOT_FOLDER, 'pokemon.db')

require 'pry'

class Pokedex 

  def self.open
    if ENV["USER"] == "zacharyolson"
      @conn = PG::Connection.new(dbname: 'pokedex')
      #@conn = PG::Connection.new()
    else
      ##todo

    end
  end

  # def self.reset
  #   %x( rm '#{DB_FILE}' )
  #   %x( psql #{DB_FILE} < #{SQL_FILE} )

  #   Pokedex.open()
  # end

  def self.instance
    #reset if @conn.nil?

    @conn
  end

  def self.exec(*args)
    puts args[0]
    self.instance.exec(*args)
  end

  def self.exec_params(*args)
    puts args[0]
    self.instance.exec_params(*args)
  end

  # def self.last_insert_row_id
  #   instance.last_insert_row_id
  # end
end