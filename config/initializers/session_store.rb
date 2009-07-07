# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_spielvolk_session',
  :secret      => 'f4a128806d7032bde468803cafc8a939fd88c26b238828e5e46e6b991ae680b6f553c3324c93ed5b3b97d236cce32923e0975c533ee856c8c75e999472612783'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
