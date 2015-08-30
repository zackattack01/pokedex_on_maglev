require_relative '../../lib/sql_object'

class Ability < SQLObject
  self.table_name = 'abilities'

  has_many :poke_abilities, foreign_key: :ability_id
  has_many_through :pokemon, :poke_abilities, :pokemon
  
  finalize!
end

class PokeAbility < SQLObject
  self.table_name = 'poke_abilities'

  belongs_to :pokemon
  belongs_to :ability

  finalize!
end