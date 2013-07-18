# namespace :userweb do 

  task :hello_world, 
    :method => :ssh, 
    :roles => :app,
    :as_user => :root do
    
    execute :roles => [:app, :web] do
      command "echo 'hello world'"
    end

    output = {}

    execute {
      output[server.name] = command "echo /tmp/foo"
    }

    interactive :as_user => root {
      type "yum install foo"
      expect "Y/n"
      type "Y"
    }
    
    collate output



  end
  
# end
