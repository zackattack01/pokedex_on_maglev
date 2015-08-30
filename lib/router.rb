class Route
  attr_reader :pattern, :http_method, :controller_class, :action_name

  def initialize(pattern, http_method, controller_class, action_name)
    @pattern, @http_method, @controller_class, @action_name = 
      pattern, http_method, controller_class, action_name
  end

  def matches?(req)
    req.request_method.downcase.to_sym == http_method &&
    pattern =~ req.path 
  end

 
  ## grab params and create an instance of the matching controller
  def run(req, res)
    route_params = {}
    match_data = req.path.match(pattern)
    match_data.names.each { |k| route_params[k] = match_data[k] }
    controller = controller_class.new(req, res, route_params)
    controller.invoke_action(action_name)
  end
end

class Router
  attr_reader :routes

  def initialize
    @routes = []
  end

  def add_route(pattern, method, controller_class, action_name)
    routes << Route.new(pattern, method, controller_class, action_name)
  end

  ## uses instance eval to allow routes to be drawn in server file
  ## more similarly to a typical rails route file 
  def draw(&proc)
    self.instance_eval(&proc)
  end
 
  ## macro creates methods that add the appropriate routes as they are called
  [:get, :post, :put, :delete].each do |http_method|
    define_method(http_method) do |pattern, controller_class, action_name|
      add_route(pattern, http_method, controller_class, action_name)
    end
  end

  def match(req)
    routes.find { |route| route.matches?(req) }
  end

  def run(req, res)
    req_route = match(req)
    if req_route
      req_route.run(req, res)
    else
      res.status = 404
    end
  end
end