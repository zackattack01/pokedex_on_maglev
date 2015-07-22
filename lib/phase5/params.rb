require 'uri'
require 'byebug'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = Hash.new { |h, k| h[k] = Hash.new(&h.default_proc) }
      @params.merge!(route_params)
      parse_www_encoded_form(req.query_string) unless req.query_string.nil?
      parse_www_encoded_form(req.body) unless req.body.nil?
    end

    def [](key)
      @params[key.to_s] == {} ? @params[key.to_sym] : @params[key.to_s]
    end

    # this will be useful if we want to `puts params` in the server log
    def to_s
      @params.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    
    ### tomorrow redo without eval    
    def parse_www_encoded_form(www_encoded_form)
      ##### good way #####################################
      # params_arr = URI::decode_www_form(www_encoded_form)
      # params_arr.each do |(keys, val)|     
      #   current = @params
      #   parsed = parse_key(keys)
      #   parsed[0..-2].each do |key|
      #     current[key] ||= {}
      #     current = current[key] 
      #   end
      #   current[parsed.last] = val
      #   @params.merge!(current)
      # end

      ####### sneaky way ####################################
      URI::decode_www_form(www_encoded_form).each do |(key, val)|
        eval("@params#{parse_key(key).map { |k| "['#{k}']" }.join} = '#{val}'")
      end
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end