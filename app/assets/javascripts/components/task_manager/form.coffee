@TaskForm = React.createClass
  getInitialState: ->
    name: ''
    description: ''

  handleNameChange: (e) ->
    @setState ->
      name: e.target.value

  handleDescriptionChange: (e) ->
    @setState ->
      description: e.target.value

  handleSubmit: (e) ->
    e.preventDefault()
    @props.create(@state)
    @setState @getInitialState()

  render: ->
    <div>
      <h2 className='text-center'>Create a new task</h2>
      <form onSubmit={@handleSubmit} >
        <div className="form-group">
          <label>Name</label>
          <input onChange={@handleNameChange} value={@state.name} type="text" className="form-control" placeholder="Name" required/>
        </div>
        <div className="form-group">
          <label>Description</label>
          <textarea onChange={@handleDescriptionChange} rows='8' value={@state.description} type="text" className="form-control" placeholder="Description" required/>
        </div>
        <button type="submit" className="btn btn-primary">Create</button>
      </form>
    </div>
