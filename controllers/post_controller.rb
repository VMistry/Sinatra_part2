class PostController < Sinatra::Base
  #sets root as the parent-directory of the current File
  set :root, File.join(File.dirname(__FILE__), '..')
  #Sets the view directory correcly
  set :views, Proc.new {File.join(root, 'views')}
  # Allows you to register and reload
  configure :development do
    register Sinatra::Reloader
  end
  # variable to hold objects in array. Each object represents an animal.
  $zoo = [
    {
      id:0,
      animal_names: 'Animal 0',
      animal_description:'This is the first animal'
    },
    {
      id:1,
      animal_names: 'Animal 1',
      animal_description:'This is the second animal'
    },
    {
      id:2,
      animal_names: 'Animal 2',
      animal_description:'This is the third animal'
    }
  ]
  # This targets the main area
  get "/" do
    # This will allow use to make a title
    @animal_names = "Zoo Database"
    # This stores the array in to a variable which other pages can access
    @zoo = $zoo
    erb :'zoo/index'
  end

  # This will be used to enter a new animal, or so called new arrival.
  get "/new" do
    @animal_names = "New Animal"
    # gives out an empty string to all the user to enter in to a clear form
    @zoo = {
      id: "",
      animal_names: "",
      animal_description: ""
    }
    # Target the new animal erb file.
    erb :'zoo/new_animal'
  end

  # This will be used to access an animal currently on the database.
  get "/:id" do
    # Access the id params of the chosen link.
    id = params[:id].to_i
    # retreive the object within the array which represents the chosen link
    @zoo = $zoo[id]
      #grab show.erb, then send it to "/:id" link
    erb :'zoo/show'
  end

  # This brings out a form and allow the user to edit infomation of animals currently on the system
  get "/:id/edit" do
    # The title of the page
    @title = "Edit Current animal"
    #Gets the id on the selected page
    id = params[:id].to_i
    # Storing the object with that id in to @posts variable
    @zoo = $zoo[id]
    #grab edit.erb, then send it to "/:id/edit" link
    erb :'zoo/edit'
  end

  # Used to send the data which has been entered, in to the database.
  post "/" do
    # Create an object
    new_animal = {
      # Get how long the array is and make it the id, the number is alway higher than the last id inserted
      id: $zoo.length,
      #Save the information inserted in to the provided feilds
      animal_names: params[:animal_names],
      animal_description: params[:animal_description]
    }
    # save the object in the array
    $zoo.push(new_animal)
    # Back to home page
    redirect "/"
  end

  # Update the infomation within the database.
  put "/:id" do
    id = params[:id].to_i
    zoo = $zoo[id]

    zoo[:animal_names] = params[:animal_names]
    zoo[:animal_description] = params[:animal_description]
    $zoo[id] = zoo
    redirect "/"
  end

  patch "/:id" do
  end

  # Delete data which is requested to be deleted. This could be detected once a button is clicked.
  delete "/:id" do
    id = params[:id].to_i
    # delete the data selected
    $zoo.delete_at(id)
    redirect '/'
  end



end
