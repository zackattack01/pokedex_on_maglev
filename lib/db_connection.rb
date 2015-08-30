require 'pg'

# https://tomafro.net/2010/01/tip-relative-paths-with-file-expand-path
ROOT_FOLDER = File.join(File.dirname(__FILE__), '..')
SQL_FILE = File.join(ROOT_FOLDER, 'pokesnag_ultra.sql')
DB_FILE = File.join(ROOT_FOLDER, 'pokemon.db')

class DBConnection < PG::Connection
  def self.open(db_file_name)
    @db = PG::Connection.new(db_file_name)
    @db.results_as_hash = true
    @db.type_translation = true

    @db
  end

  def self.reset
    %x( rm '#{DB_FILE}' )
    %x( psql #{DB_FILE} < #{SQL_FILE} )

    DBConnection.open(DB_FILE)
  end

  def self.instance
    reset if @db.nil?

    @db
  end

  def self.execute(*args)
    puts args[0]

    instance.execute(*args)
  end

  def self.execute2(*args)
    puts args[0]

    instance.execute2(*args)
  end

  def self.last_insert_row_id
    instance.last_insert_row_id
  end
end