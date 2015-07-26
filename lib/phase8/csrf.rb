class AuthToken
  def initialize(req)
    @token = SecureRandom.urlsafe_base64
    store_token(req)
  end

  def store_token(req)
    req.cookies << WEBrick::Cookie.new('csrf_token', token)
  end

  def is_token?(req)
    token_cookie = req.cookies.find do |cookie|
      cookie.name == 'csrf_token'
    end

    token_cookie.value == token
  end

  private
  attr_reader :token
end