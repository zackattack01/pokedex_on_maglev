require_relative '../../lib/sql_object'

class Type < SQLObject
  self.table_name = 'types'

  has_many :poke_types, foreign_key: :type_id
  has_many_through :pokemon, :poke_types, :pokemon
  
  finalize!
end

class PokeType < SQLObject
  self.table_name = 'poke_types'

  belongs_to :pokemon
  belongs_to :type

  finalize!
end