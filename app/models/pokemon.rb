require_relative '../../lib/sql_object'

class Pokemon < SQLObject
  self.table_name = 'pokemons'

  has_many :poke_types, foreign_key: :pokemon_id
  has_many_through :types, :poke_types, :type

  has_many :poke_abilities, foreign_key: :pokemon_id
  has_many_through :abilities, :poke_abilities, :ability

  has_many :poke_moves, foreign_key: :pokemon_id
  has_many_through :moves, :poke_moves, :move

  finalize!
end