@TaskList = React.createClass
  render: ->
    component = @
    tasksNode = @props.tasks.map (task) ->
      <Task key={task.id} task={task}, mainComponent={component.props.mainComponent} />
    classes = 'text-center'
    classes += ' hidden' unless @props.tasks.length
    <div>
      <h2 className={classes}>{@props.type} task</h2>
      <ul className='list-group'>
        {tasksNode}
      </ul>
    </div>

