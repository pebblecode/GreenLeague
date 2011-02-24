require 'rubygems'
require 'betabuilder'

BetaBuilder::Tasks.new do |config|
  config.target        = "GreenLeague"
  config.configuration = "Adhoc" 
  
  # configure deployment via TestFlight
  config.deploy_using(:testflight) do |tf|
    tf.api_token  = "o3CrB0GWRdEzOQaA74hwu3bZXB01onaBvJnpkN3ZDQc"
    tf.team_token = "b406aaaa7a7c21be36270e7b513e7a94_MTMyNQ"
  end  
end
