# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
#ActionController::Base.session = {
#  :key         => '_prova_session',
#  :secret      => 'e76d8339754cb0de94a6dfa52b302a491a7367d9537100a5828f769bd9e2f9988e8e3d7614074d3ce97166c756d27159e8e5b1601f7ab362b5b6ba5de6a338e1'
#}
ActionController::Base.session = {
  :session_key => '_xmpp_server_session',
  :secret      => '78e35f84547f46870ce10128cd207dfe6aba27a2ac9ea12d8b92f72dff5b40ec7e1d8f3b740e4e3a51db1ad5f077ddb27fc997753f2890c8a574e2a3ae16f034'
}


# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
#ActionController::Base.session_store = :active_record_store
