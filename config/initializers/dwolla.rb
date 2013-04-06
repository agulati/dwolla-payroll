DWOLLA_CONFIG = YAML.load_file("#{Rails.root}/config/dwolla.yml")[Rails.env]

DWOLLA_URL = DWOLLA_CONFIG['url']
DWOLLA_SECRET = DWOLLA_CONFIG['client_secret']
DWOLLA_KEY = DWOLLA_CONFIG['client_key']
