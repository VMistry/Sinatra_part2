require 'sinatra'
require 'sinatra/contrib'
# This will make changes to browser anything done in development if it is being developed.
require 'sinatra/reloader' if development?
require 'pry'
require_relative './controllers/post_controller.rb'

use Rack::Reloader
use Rack::MethodOverride
run PostController
