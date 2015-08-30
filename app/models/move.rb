require_relative '../../lib/sql_object'

class Move < SQLObject
  self.table_name = 'moves'

  has_many :poke_moves
  has_many_through :pokemon, :poke_moves, :pokemon
  
  finalize!
end

class PokeMove < SQLObject
  self.table_name = 'poke_moves'

  belongs_to :pokemon
  belongs_to :move

  finalize!
end