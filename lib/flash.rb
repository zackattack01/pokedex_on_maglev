class Flash
  def initialize(req)
    flash_cookie = req.cookies.find do |cookie|
      cookie.name == 'flash'
    end
    @now_flash = flash_cookie.nil? ? {} : JSON.parse(flash_cookie.value)
    @later_flash = {}
  end

  def [](key)
    return false unless now_flash.has_key?(key)
    now_flash[key]
  end

  def []=(key, val)
    later_flash[key] = val
  end

  def now
    now_flash
  end

  def store_flash(res)
    res.cookies << WEBrick::Cookie.new('flash', later_flash.to_json)
  end

  private
  attr_reader :now_flash, :later_flash
end