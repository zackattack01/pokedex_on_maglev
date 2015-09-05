require 'uri'

class Params
  def initialize(req, route_params = {})
    @params = route_params
    parse_www_encoded_form(req.query_string) unless req.query_string.nil?
    parse_www_encoded_form(req.body) unless req.body.nil?
  end

  def [](key)
    @params[key.to_s] || @params[key.to_sym]
  end

  class AttributeNotFoundError < ArgumentError; end;

  private  
  def parse_www_encoded_form(www_encoded_form)
    params_arr = URI::decode_www_form(www_encoded_form)
    params_arr.each do |(keys, val)|     
      current = @params
      parsed = parse_key(keys)
      parsed[0..-2].each do |key|
        current[key] ||= {}
        current = current[key] 
      end
      current[parsed.last] = val
      @params.merge!(current)
    end
  end

  def parse_key(key)
    key.split(/\]\[|\[|\]/)
  end
end