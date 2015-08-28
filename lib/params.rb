require 'uri'
require 'byebug'

class Params
  def initialize(req, route_params = {})
    # @params = Hash.new { |h, k| h[k] = Hash.new(&h.default_proc) }
    # @params.merge!(route_params)
    @params = route_params
    parse_www_encoded_form(req.query_string) unless req.query_string.nil?
    parse_www_encoded_form(req.body) unless req.body.nil?
  end

  def [](key)
    #@params[key.to_s] == {} ? @params[key.to_sym] : @params[key.to_s]
    @params[key.to_s] || @params[key.to_sym]
  end

  def to_s
    @params.to_s
  end

  class AttributeNotFoundError < ArgumentError; end;

  private  
  def parse_www_encoded_form(www_encoded_form)
    ##### good way #####################################
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

    ####### sneakzilla ####################################
    # URI::decode_www_form(www_encoded_form).each do |(key, val)|
    #   eval("@params#{parse_key(key).map { |k| "['#{k}']" }.join} = '#{val}'")
    # end
  end

  def parse_key(key)
    key.split(/\]\[|\[|\]/)
  end
end
