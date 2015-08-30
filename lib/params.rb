require 'uri'

class Params
  def initialize(req, route_params = {})

    ## set the params to a new hash with a default proc that initializes 
    ## a deeper hash with the parent default proc.  this allows the params 
    ## to be nested arbitrarily deep in parse_www_encoded_form
    @params = Hash.new { |h, k| h[k] = Hash.new(&h.default_proc) }
    @params.merge!(route_params)
    parse_www_encoded_form(req.query_string) unless req.query_string.nil?
    parse_www_encoded_form(req.body) unless req.body.nil?
  end

  def [](key)
    
    ## check if the value is empty rather than truthy since the default proc 
    ## will never return nil
    @params[key.to_s] == {} ? @params[key.to_sym] : @params[key.to_s]
  end

  class AttributeNotFoundError < ArgumentError; end;

  private  
  def parse_www_encoded_form(www_encoded_form)

    ## this could and should be done iteratively (or recursively)
    URI::decode_www_form(www_encoded_form).each do |(key, val)|
      eval("@params#{parse_key(key).map { |k| "['#{k}']" }.join} = '#{val}'")
    end
  end

  def parse_key(key)
    key.split(/\]\[|\[|\]/)
  end
end