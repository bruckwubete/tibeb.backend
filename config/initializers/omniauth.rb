Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1741788386086120','120d1b3b5ff35d81d960cb2d08304561'
  provider :twitter, 'fB48Gjd2i0H5l4MOME37pi9vA', 'r3EuiL7zdsF82jATEvfmMZgFGXkcvmtbBGuVemyCXgz3KkkmeD'
  provider :google_oauth2, '242462878549-g6bjq5mf3g7r4j8fjjgd9gjt7lk45poq.apps.googleusercontent.com', 'rPR81jQYp_iERCI1wi9fhjb9'
  provider :github, 'ebd874ea8feb4bdba604', '750af728708510f7cb4f43dcbcac3bc4b59c5ac9'
end