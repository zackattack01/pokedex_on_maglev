require 'active_support/inflector'
require_relative 'searchable'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @name = name
    @foreign_key = options[:foreign_key] || :"#{name}_id"
    @class_name = options[:class_name] || name.to_s.camelcase
    @primary_key = options[:primary_key] || :id
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @name = name
    @foreign_key = options[:foreign_key] || :"#{self_class_name.underscore}_id"
    @class_name = options[:class_name] || name.to_s.camelcase.singularize
    @primary_key = options[:primary_key] || :id
  end
end

module Associatable
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)
    define_method(name) do 
      fk = send("#{options.foreign_key}")
      options.model_class.where(options.primary_key => fk).first
    end

    assoc_options[name] = options
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self.to_s, options)
    define_method(name) do 
      options.model_class.where(options.foreign_key => send(options.primary_key))
    end
  end

  def assoc_options
    @assoc_options ||= {}
  end

  def has_one_through(name, through_name, source_name)
    define_method(name) do
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]
      
      source_options.model_class.parse_all(DBConnection.execute(<<-SQL, id)
        SELECT
          source_table.*
        FROM  
          #{through_options.table_name} AS through_table
        JOIN
          #{source_options.table_name} AS source_table
        ON 
          through_table.#{source_options.foreign_key} = source_table.#{source_options.primary_key}
        WHERE
          through_table.#{through_options.primary_key} = ?
        LIMIT
          1
      SQL
          ).first
    end
  end
end