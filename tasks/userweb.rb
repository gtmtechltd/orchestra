namespace :userweb do 

  task :hello_world, 
    :method => :ssh, 
    :roles => :app,
    :as_user => :root do
    
    execute :roles => [:app, :web], { 
      command :as_user => root, "echo '${orchestra.server.property}_hello world'" 
    }

    output = {}

    execute {
      output[server.name] = command "echo /tmp/foo"
    }

    collate output

    

  end
  
end