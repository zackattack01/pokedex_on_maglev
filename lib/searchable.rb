require_relative 'db_connection'

module Searchable
  def where(params)
    where_line = params.keys.map do |attr_name| 
    	"#{attr_name} = ?" 
    end.join(' AND ')

    parse_all(DBConnection.execute(<<-SQL, *params.values)
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