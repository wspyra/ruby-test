RubyTest::Application.routes.draw do

  scope '(:locale)', :locale => /en|pl/ do
    root :to => 'containers#index'
    match 'page-1', to: redirect('/')
    match 'page-(:page)' => 'containers#index'
    match 'containers/:id/:move' => 'containers#index', :move => /up|down/
    match 'containers/:id/upload(/:page)' => 'containers#upload'
    match 'containers/:id/send_email' => 'containers#send_email'
    resources :containers
  end

end
