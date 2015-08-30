require_relative 'db_connection'

module Searchable
  def self.find(id)
    found = Pokedex.exec_params(<<-SQL, [id.to_s]) 
              SELECT 
                * 
              FROM 
                #{table_name}
              WHERE
                id = $1
              LIMIT
                1
            SQL
            
    found.to_a.empty? ? nil : new(found.to_a.first)
  end

  def where(params)
    where_line = params.keys.map do |attr_name| 
    	"#{attr_name} = ?" 
    end.join(' AND ')

    parse_all(Pokedex.exec(<<-SQL, *params.values)
					    	SELECT
					    		*
					    	FROM
					    		#{table_name}
					    	WHERE
					    		#{where_line}
					    SQL
					    )
  end
end