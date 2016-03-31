@TaskList = React.createClass
  render: ->
    component = @
    tasksNode = @props.tasks.map (task) ->
      <Task key={task.id} task={task}, parentComponent={component.props.parentComponent}/>
    <h2 className='text-center'>Done task</h2>
    <ul className='list-group'>
      {tasksNode}
    </ul>

