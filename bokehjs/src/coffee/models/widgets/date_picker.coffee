_ = require "underscore"
$ = require "jquery"
$1 = require "jquery-ui/datepicker"

p = require "../../core/properties"

InputWidget = require "./input_widget"
Widget = require "./widget"

class DatePickerView extends Widget.View

  initialize: (options) ->
    super(options)
    @render()

  render: () ->
    super()
    @$el.empty()
    $label = $('<label>').text(@mget("title"))
    $datepicker = $("<div>").datepicker({
      defaultDate: new Date(@mget('value'))
      minDate: if @mget('min_date')? then new Date(@mget('min_date')) else null
      maxDate: if @mget('max_date')? then new Date(@mget('max_date')) else null
      onSelect: @onSelect
    })
    @$el.append([$label, $datepicker])
    return @

  onSelect: (dateText, ui) =>
    @mset('value', new Date(dateText))
    @mget('callback')?.execute(@model)

class DatePicker extends InputWidget.Model
  type: "DatePicker"
  default_view: DatePickerView

  @define {
      # TODO (bev) types
      value:    [ p.Any, Date.now() ]
      min_date: [ p.Any             ]
      max_date: [ p.Any             ]
    }

module.exports =
  Model: DatePicker
  View: DatePickerView
